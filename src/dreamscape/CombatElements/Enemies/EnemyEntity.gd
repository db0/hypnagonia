class_name EnemyEntity
extends CombatEntity

signal finished_activation(enemy)

onready var intents: EnemyIntents = $Intents

var is_dead := false
var shader_progress := 0.0

func _ready() -> void:
	entity_type = "torment"
	intents.combat_entity = self
	intents.all_intents = _properties.Intents.duplicate(true)
	intents.prepare_intents()

func _process(delta: float) -> void:
	if is_dead:
		shader_progress += delta
		entity_texture.material.set_shader_param(
					'progress', shader_progress)
		var texture_pos = entity_texture.rect_global_position
		for node in [name_label, health_label, defence_label, active_effects, incoming, intents]:
			if node.visible:
				node.visible = false
		entity_texture.rect_global_position = texture_pos
		if shader_progress > 0.8:
			queue_free()

	
func activate() -> void:
	# Just in case the end-turn button is pressed too fast
	if is_dead: 
		emit_signal("finished_activation", self)
		return
	intents.execute_scripts()
	yield(get_tree().create_timer(0.1), "timeout")
#	print_debug("Activated: " + canonical_name)
	emit_signal("finished_activation", self)
	intents.prepare_intents()

func die() -> void:
	emit_signal("entity_killed")
	entity_texture.material = ShaderMaterial.new()
	entity_texture.material.shader = CFConst.REMOVE_FROM_GAME_SHADER
	is_dead = true
