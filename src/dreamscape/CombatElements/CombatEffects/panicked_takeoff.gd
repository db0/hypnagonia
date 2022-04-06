extends CombatEffect

func _ready():
# warning-ignore:return_value_discarded
	owning_entity.connect("entity_damaged", self, "_on_entity_damaged")

func _on_entity_damaged(entity, _amount, _trigger: Node, _tags: Array) -> void:
	pass
	if cfc.NMAP.board.turn.current_turn != cfc.NMAP.board.turn.Turns.ENEMY_TURN:
		return
	if entity_type != Terms.PLAYER:
		return
	var takeoff = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
			"subject": "dreamer",
			"modification": stacks * cfc.card_definitions[name]\
					.get("_amounts",{}).get("concentration_stacks", 1),
			"tags": ["Combat Effect", "Concentration"],
		},
	]
	if upgrade == "wildly":
		var wild := {
			"name": "draw_cards",
			"card_count": stacks * cfc.card_definitions[name]\
					.get("_amounts",{}).get("concentration_cards", 1),
			"tags": ["Combat Effect", "Concentration"],
		}
		takeoff.append(wild)
	execute_script(takeoff, entity)

