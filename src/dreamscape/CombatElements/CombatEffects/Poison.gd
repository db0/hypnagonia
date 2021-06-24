extends CombatEffect

# This is effectively like poison in other vg-deckbuilders

const _description_string := "{effect_name}: At the start of this {entity}'s turn it receives"\
		+ " {amount} {damage}, then reduce the stacks of {effect_name} by 1."


func _ready() -> void:
	description_string = _description_string
