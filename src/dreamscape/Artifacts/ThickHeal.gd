extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.board.connect("battle_begun", self, "_on_battle_start")


func _on_player_turn_started(_turn: Turn = null) -> void:
	var script = [
		{
			"name": "modify_damage",
			"subject": "dreamer",
			"amount": -ArtifactDefinitions.ThickHeal.amounts.heal_amount,
			"tags": ["Heal","Curio"],
		},
	]
	execute_script(script)
	_send_trigger_signal()


func _on_battle_start() -> void:
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_reshuffle")


func _on_reshuffle(_pile: Pile) -> void:
	var script = [
		{
			"name": "modify_damage",
			"subject": "dreamer",
			"amount": ArtifactDefinitions.ThickHeal.amounts.exert_amount,
			"tags": ["Exert","Curio"],
		},
	]
	execute_script(script)
	_send_trigger_signal()
