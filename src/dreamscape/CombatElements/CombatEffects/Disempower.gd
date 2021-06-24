extends CombatEffect

const description_string := "{effect_name}: {damage} {damage_verb} by this {entity} is reduced by 30%.\n" \
		+ "Reduce these stacks by 1 at the end of the turn."

# To override
func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[entity_type].duplicate()
	format["effect_name"] = name
	decription_label.text = description_string.format(format)

# To override. This is called by the scripting engine
# Is source is telling this script that the owning combat_entity is the one owning
# this alteration
func get_effect_alteration(script: ScriptTask, value: int, is_source := false) -> int:
	if not script.script_name == 'inflict_damage' or not is_source:
		return(0)
	var new_value = round(value * 0.7)
	var alteration = new_value - value
	print_debug("Disempower ({value} * 0.7) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	return(alteration)
