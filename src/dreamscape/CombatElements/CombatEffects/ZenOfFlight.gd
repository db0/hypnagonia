extends CombatEffect

# This is effectively like poison in other vg-deckbuilders

const _description_string := "{effect_name}: At the end of each turn, {heal} 1. If Untouchable, {heal} 1 extra."


func _ready() -> void:
	description_string = _description_string

func _on_player_turn_ended(_turn: Turn) -> void:
	var heal_amount : int = stacks
	if cfc.NMAP.board.dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious):
		 heal_amount += stacks
	var script = [{
		"name": "modify_damage",
		"subject": "self",
		"amount": -heal_amount,
		"tags": ["Heal"],
	}]
	execute_script(script)
