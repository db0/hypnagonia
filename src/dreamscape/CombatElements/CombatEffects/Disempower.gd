extends CombatEffect

const _description_string := "{effect_name}: {damage} {damage_verb} by this {entity} is reduced by 30%.\n" \
		+ "Reduce these stacks by 1 at the end of the turn."

func _ready() -> void:
	description_string = _description_string

# To override. This is called by the scripting engine
# Is source is telling this script that the owning combat_entity is the one owning
# this alteration
func get_effect_alteration(script: ScriptTask, value: int, sceng, is_source := false, dry_run := true) -> int:
	if not script.script_name == 'modify_health'\
			or not "Damage" in script.get_property(SP.KEY_TAGS)\
			or not is_source:
		return(0)
	var new_value = round(value * 0.7)
	var alteration = new_value - value
#	print_debug("Disempower ({value} * 0.7) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	return(alteration)
