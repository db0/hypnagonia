extends CombatEffect

func _ready():
	# warning-ignore:return_value_discarded
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_reshuffle")


func _on_reshuffle(_pile: Pile):
	var multiplier = cfc.card_definitions['Mouse']\
			.get("_amounts",{}).get("effect_stacks")
	var unfocus = [{
		"name": "apply_effect",
		"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
		"subject": "dreamer",
		"modification": -stacks * multiplier,
		"tags": ["Combat Effect", "Concentration"],
	}]
	execute_script(unfocus)
	

func _on_player_turn_started(_turn: Turn) -> void:
	cfc.NMAP.board.counters.mod_counter("immersion", stacks, false, false, self, ["New Turn"])
