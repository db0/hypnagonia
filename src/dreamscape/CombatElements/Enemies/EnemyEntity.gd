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
	
#The Torments do not really have health, they have an interpetation meter
# which makes them vanish when full.
# As such we want to reverse the health to show it increasing instead of 
# decreasing when taking damage
# But we keep the underlying mechanics the same to stay consistent.
func _update_health_label() -> void:
	health_label.text = str(max_health - health) + '/' + str(max_health)
	defence_label.text = '(' + str(defence) + ')'
