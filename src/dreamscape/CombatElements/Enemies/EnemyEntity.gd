class_name EnemyEntity
extends CombatEntity

signal finished_activation(enemy)

onready var intents: EnemyIntents = $Intents

func _ready() -> void:
	entity_type = "torment"
	intents.combat_entity = self
	intents.all_intents = _properties.Intents.duplicate(true)
	intents.prepare_intents()
	
func activate() -> void:
	intents.execute_scripts()
	yield(get_tree().create_timer(0.1), "timeout")
#	print_debug("Activated: " + canonical_name)
	emit_signal("finished_activation", self)
	intents.prepare_intents()
	
