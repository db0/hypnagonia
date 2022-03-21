extends CombatEffect

func _on_player_turn_started(turn: Turn) -> void:
	._on_player_turn_started(turn)
	var immersion_amount : int = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_immersion")
	var forget_amount : int = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_forget")
	cfc.NMAP.board.counters.mod_counter(
			"immersion", immersion_amount, false, false, self,
			["New Turn", "Concentration", "Combat Effect"])
	var script := [
		{
			"name": "move_card_to_container",
			"tags": ["Card"],
			"src_container": "deck",
			"dest_container": "forgotten",
			"subject_count": forget_amount,
			"subject": "index",
			"subject_index": "bottom",
		},
	]
	execute_script(script)
	set_stacks(stacks - 1, ["Scripted"])
