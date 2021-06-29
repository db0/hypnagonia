extends CombatEffect

const _description_string := "{effect_name}: {defence} is not removed at start of turn.\n"\
		+ "Reduce these stacks by 1 at the start of the turn."

func _ready() -> void:
	description_string = _description_string
