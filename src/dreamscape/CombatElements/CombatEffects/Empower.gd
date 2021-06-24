extends CombatEffect

const _description_string := "{effect_name}: {damage} {damage_verb} by this {entity} is increased by 30%.\n"\
		+ "Reduce these stacks by 1 at the end of the turn."


func _ready() -> void:
	description_string = _description_string
