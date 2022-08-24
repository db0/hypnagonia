extends Artifact


func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		scripting_bus.connect("scripting_event_triggered", self, "_on_signal_received")


func _on_signal_received(trigger_card, trigger, details) -> void:
	if trigger != "card_played":
		return
	if not _activate():
		return
	trigger_card.abort_deck_removal()
	if cfc.NMAP.board.turn.wants_to_end_turn == trigger_card:
		cfc.NMAP.board.turn.abort_request_end_player_turn()
	var script = [
		{
			"name": "autoplay_card",
			"subject": "trigger",
			"tags": ["Curio"],
		},
	]
	execute_script(script,trigger_card)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

func _on_player_turn_started(_turn: Turn = null) -> void:
	# Can be used once per turn
	_is_activated = false
