extends CombatEffect

func _ready():
# warning-ignore:return_value_discarded
	owning_entity.connect("entity_damaged", self, "_on_entity_damaged")

func _on_entity_damaged(_entity, amount, _trigger: Node, _tags: Array) -> void:
	if entity_type != Terms.PLAYER:
		return
	if owning_entity.damage >= owning_entity.health:
		owning_entity.damage -= amount
		set_stacks(stacks - 1, ["Triggered"])
		var tolerance = [
			{
				"name": "draw_cards",
				"card_count": cfc.card_definitions[name]\
						.get("_amounts",{}).get("concentration_special"),
				"tags": ["Combat Effect", "Concentration"],
			},
		]
		var immersion_script: Dictionary
		if cfc.NMAP.board.turn.current_turn == cfc.NMAP.board.turn.Turns.PLAYER_TURN:
			immersion_script = {
				"name": "mod_counter",
				"counter_name": "immersion",
				"modification": cfc.card_definitions[name]\
						.get("_amounts",{}).get("concentration_special"),
				"tags": ["Combat Effect", "Concentration"],
			}
		else:
			immersion_script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": cfc.card_definitions[name]\
						.get("_amounts",{}).get("concentration_special"),
				"tags": ["Combat Effect", "Concentration"],
			}
		tolerance.append(immersion_script)
		execute_script(tolerance, owning_entity)
