extends CombatEffect

# This is effectively like poison in other vg-deckbuilders

const description_string := "{effect_name}: At the start of this {entity}'s turn it receives"\
		+ " {amount} {damage}, then reduce the stacks of {effect_name} by 1."

# To override
func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[entity_type].duplicate()
	format["effect_name"] = name
	format["amount"] = str(stacks)
	decription_label.text = description_string.format(format)
