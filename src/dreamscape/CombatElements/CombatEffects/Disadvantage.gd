extends CombatEffect

const description_string := "{effect_name}: {damage} {damage_verb} by this {entity} is reduced by 30%.\n" \
		+ "Reduce these stacks by 1 at the end of the turn."

# To override
func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[entity_type].duplicate()
	format["effect_name"] = name
	decription_label.text = description_string.format(format)
