extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		if not cfc.NMAP.board.dreamer:
			yield(cfc.NMAP.board, "ready")
		cfc.NMAP.board.dreamer.stop_upgrades()


func _on_player_turn_started(_turn: Turn = null) -> void:
	var script = [
		{
			"name": "mod_counter",
			"counter_name": "immersion",
			"tags": ["Curio", "New Turn"],
			"modification": ArtifactDefinitions.ProgressiveImmersion.amounts.immersion_amount,
		},
	]
	execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()
