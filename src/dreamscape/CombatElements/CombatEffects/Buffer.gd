extends CombatEffect

const _description_string := "{effect_name}: At the start of your turn gain 1 {energy} per stack."\
		+ "then remove all stacks of {effect_name}."

func _ready() -> void:
	description_string = _description_string

func _on_player_turn_started(turn: Turn) -> void:
	._on_player_turn_started(turn)
	cfc.NMAP.board.counters.mod_counter("immersion", stacks, false, false, self, ["New Turn"])
	set_stacks(0)
	
