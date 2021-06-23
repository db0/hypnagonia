extends CombatEffect

const description_string := "{damage} {damage_verb} by this {entity} is reduced by 30%"

# To override
func _set_current_description() -> void:
	decription_label.text = description_string.format(Terms.COMMON_FORMATS[entity_type])
