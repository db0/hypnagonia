extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		if not cfc.NMAP.board.dreamer:
			yield(cfc.NMAP.board, "ready")
	var deck_size_needed = ArtifactDefinitions.ThickBoss.amounts.min_deck_size
	var missing_cards = deck_size_needed - globals.player.deck.count_cards()
	if missing_cards <= 0:
		return
	var script = [
		{
			"name": "spawn_card_to_container",
			"card_name": "Lacuna",
			"dest_container": "discard",
			"object_count": missing_cards,
			"tags": ["Curio", "Perturbation"],
			"yield_time": 0.05,
		},
	]
	execute_script(script)

func _on_player_turn_started(_turn: Turn = null) -> void:
	var script = [
		{
			"name": "mod_counter",
			"counter_name": "immersion",
			"tags": ["Curio", "New Turn"],
			"modification": ArtifactDefinitions.ThickBoss.amounts.immersion_amount,
		},
	]
	execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()
