extends CombatEffect

func _ready():
# warning-ignore:return_value_discarded
	owning_entity.connect("entity_damaged", self, "_on_entity_damaged")

func _on_entity_damaged(_entity, amount, _trigger: Node, _tags: Array) -> void:
	if cfc.NMAP.board.turn.current_turn != cfc.NMAP.board.turn.Turns.PLAYER_TURN:
		return
	if entity_type != Terms.PLAYER:
		return
	var multiplier := 3
	if upgrade == "frustrated":
		multiplier = 5
	var all_enemies := get_tree().get_nodes_in_group("EnemyEntities")
	CFUtils.shuffle_array(all_enemies)
	var lash_out = [{
	"name": "modify_damage",
	"subject": "trigger",
	"amount": amount * multiplier,
	# The Reactive tag is used to avoid infinite loops between effects
	# For example between this card and Thorns.
	# As such, when this card is triggered by a reactive effect, 
	# that effect will not trigger again from this effect in turn.
	"tags": ["Attack", "Combat Effect", "Concentration", "Reactive"],
	}]
	# Just in case all enemies died during execution...
	if all_enemies.size():
		execute_script(lash_out, all_enemies[0])
