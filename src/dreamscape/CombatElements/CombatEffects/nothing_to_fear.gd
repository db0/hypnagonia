extends CombatEffect

func get_effect_alteration(
		script: ScriptTask,
		value: int,
		_sceng,
		is_source := false,
		_dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'modify_damage'\
			or not "Attack" in script.get_property(SP.KEY_TAGS)\
			or is_source:
		return(0)
	var new_value = value + (2 * stacks)
	if upgrade == "absolutely":
		new_value = value + stacks
	var alteration = new_value - value
	return(alteration)

func _on_player_turn_started(turn: Turn) -> void:
	._on_player_turn_started(turn)
	cfc.NMAP.board.counters.mod_counter(
			"immersion", stacks, false, false, self,
			["New Turn", "Concentration", "Combat Effect"])

