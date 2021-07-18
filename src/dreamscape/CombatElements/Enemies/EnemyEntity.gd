class_name EnemyEntity
extends CombatEntity

signal finished_activation(enemy)

onready var intents: EnemyIntents = $Intents

var animated_art

func _process(_delta: float) -> void:
	if is_dead:
		for node in [incoming]:
			if node.visible:
				node.visible = false
#		if animated_art:
#			animated_art.enemy_polygon.material.set_shader_param(
#					'progress', shader_progress)

func _ready() -> void:
	entity_type = "torment"
	intents.combat_entity = self
	if _properties.has('Intents'):
		intents.all_intents = _properties.Intents.duplicate(true)
	if _properties.has('_art_scene'):
		var art_scene = load(_properties.get('_art_scene')).instance()
		animated_art = art_scene
		art.add_child(art_scene)
#		art_scene.scale = Vector2(0.24,0.24)
		art_scene.enemy_polygon.position =+ art.rect_size + art_scene.enemy_polygon.position
		entity_texture.visible = false
		highlight.entity_art = art_scene
	intents.prepare_intents()


func setup(entity_name: String, properties: Dictionary) -> void:
	.setup(entity_name,properties)
	health += CFUtils.randi_range(-properties['_health_variability'], properties['_health_variability'])
		
	
func activate() -> void:
	# Just in case the end-turn button is pressed too fast
	if is_dead: 
		emit_signal("finished_activation", self)
		return
#	print_debug(damage, is_dead, health)
	if animated_art:
		animated_art.act(intents.intent_name)
	var sceng = intents.execute_scripts()
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	var wait_for_anim := 0
	# I don't want to be waiting too long for the animation to finish
	# so I give it at most 1.5 seconds to run before I proceed to the next enemy
	while animated_art and animated_art.animation_player.is_playing():
		yield(get_tree().create_timer(0.5), "timeout")
		wait_for_anim += 1
		if wait_for_anim > 2: 
			break
	yield(get_tree().create_timer(0.1), "timeout")
#	print_debug("Activated: " + canonical_name)
	emit_signal("finished_activation", self)
	intents.prepare_intents()

func die() -> void:
	is_dead = true
	emit_signal("entity_killed")
	if animated_art:
		animated_art.defeat()
		yield(animated_art.animation_player, "animation_finished")
#		animated_art.enemy_polygon.material = ShaderMaterial.new()
#		animated_art.enemy_polygon.material.shader = CFConst.REMOVE_FROM_GAME_SHADER
		call_deferred("queue_free")
	else:
		entity_texture.material = ShaderMaterial.new()
		entity_texture.material.shader = CFConst.REMOVE_FROM_GAME_SHADER
		is_dead = true
