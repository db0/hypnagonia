class_name EnemyEntity
extends CombatEntity

signal started_activation(enemy)
signal finished_activation(enemy)

const intents_background := preload("res://assets/bubble-155333_1280.png")
onready var intents: EnemyIntents = $Intents/MC/EnemyIntents

var animated_art
var is_activating

func _process(_delta: float) -> void:
	if is_dead:
		for node in [incoming]:
			if node.visible:
				node.visible = false
#		if animated_art:
#			animated_art.enemy_polygon.material.set_shader_param(
#					'progress', shader_progress)

func _ready() -> void:
	$Intents/IntentBackground.texture = CFUtils.convert_texture_to_image(intents_background)
	entity_type = "torment"
	intents.combat_entity = self
	if _properties.has('Intents'):
		intents.all_intents = _properties.Intents.duplicate(true)
	# If the _unlock_triggers property is defined. The intents specified in this
	# array will be unlocked when the specified signal is fired
	if _properties.has('_unlock_triggers'):
		intents.unlock_triggers = _properties._unlock_triggers.duplicate(true)
	# If the _lock_triggers property is defined. The intents specified in this
	# array will be locked (i.e. not used anymore) when the specified signal is fired
	if _properties.has('_lock_triggers'):
		intents.lock_triggers = _properties._lock_triggers.duplicate(true)
	if _properties.has('_art_scene'):
		var art_scene = load(_properties.get('_art_scene')).instance()
		animated_art = art_scene
		art.add_child(art_scene)
#		art_scene.scale = Vector2(0.24,0.24)
		art_scene.enemy_polygon.position =+ art.rect_size + art_scene.enemy_polygon.position
		entity_texture.visible = false
		entity_texture.material = null
		highlight.entity_art = art_scene
	# warning-ignore:return_value_discarded
	if _properties.has('starting_intent'):
		intents.prepare_intents(_properties.starting_intent)
	else:
		intents.prepare_intents()


func setup(entity_name: String, properties: Dictionary) -> void:
	.setup(entity_name,properties)
	health += CFUtils.randi_range(-properties['_health_variability'], properties['_health_variability'])
		

func activate() -> void:
	# Just in case the end-turn button is pressed too fast
	emit_signal("started_activation", self)
	if is_dead: 
		emit_signal("finished_activation", self)
		return
	is_activating = true
#	print_debug(damage, is_dead, health)
	if animated_art:
		animated_art.act(intents.animation_name)
	var sceng = intents.execute_scripts()
	if sceng is GDScriptFunctionState:
		# Yielding for anything when the entity is about to deinstance is not a good idea
		if not is_dead:
			sceng = yield(sceng, "completed")
	var wait_for_anim := 0
	# I don't want to be waiting too long for the animation to finish
	# so I give it at most 1.5 seconds to run before I proceed to the next enemy
	while animated_art and animated_art.animation_player.is_playing():
		# If we wait while the torment is dead, the instance mit disappear by the time we return
		if is_dead:
			break
		yield(get_tree().create_timer(0.5), "timeout")
		wait_for_anim += 1
		if wait_for_anim > 2: 
			break
	if not is_dead:
		yield(get_tree().create_timer(0.1), "timeout")
	# print_debug("Activated: " + canonical_name)
	emit_signal("finished_activation", self)
	is_activating = false
	# warning-ignore:return_value_discarded
	intents.prepare_intents()

func die() -> void:
	if is_dead:
		return
	is_dead = true
	emit_signal("entity_killed", damage, health)
	if animated_art:
		animated_art.defeat()
		yield(animated_art.animation_player, "animation_finished")
#		animated_art.enemy_polygon.material = ShaderMaterial.new()
#		animated_art.enemy_polygon.material.shader = CFConst.REMOVE_FROM_GAME_SHADER
		cfc.flush_cache()
		call_deferred("queue_free")
		emit_signal("death_animation_finished", self)
	else:
		entity_texture.material = ShaderMaterial.new()
		entity_texture.material.shader = CFConst.REMOVE_FROM_GAME_SHADER

		
