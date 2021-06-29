extends CombatEffect

const _description_string := "{effect_name}: Add {amount} {energy} at the start of the turn.\n"\
		+ "All {health} taken is increased by {double_amount}."

func _ready() -> void:
	description_string = _description_string


func get_effect_alteration(script: ScriptTask, value: int, _sceng, is_source := false, _dry_run := true) -> int:
	if not script.script_name == 'modify_health'\
			or not "Damage" in script.get_property(SP.KEY_TAGS)\
			or is_source:
		return(0)
	var new_value = value + (2 * stacks)
	var alteration = new_value - value
#	print_debug("Laugh at Danger ({value} + 2) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	return(alteration)

func _on_turn_started(turn: Turn) -> void:
	._on_turn_started(turn)
	cfc.NMAP.board.counters.mod_counter("immersion", 1, false, false, self, ["New Turn"])
	
