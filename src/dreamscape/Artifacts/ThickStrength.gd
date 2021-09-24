extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.board.connect("battle_begun", self, "_on_battle_start")


func _on_player_turn_started(_turn: Turn = null) -> void:
	if _is_activated:
		return
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
			"subject": "dreamer",
			"modification": ArtifactDefinitions.ThickStrength.amounts.effect_stacks,
			"upgrade_name": "thick",
		},
	]
	execute_script(script)

# Connecting the signal here ensures the artifact will not be disabled at the start of combat
func _on_battle_start() -> void:
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_first_reshuffle")



func _on_first_reshuffle(_pile: Pile) -> void:
	# warning-ignore:return_value_discarded
	_activate()
	cfc.NMAP.deck.disconnect("shuffle_completed", self, "_on_first_reshuffle")
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
			"subject": "dreamer",
			"modification": 0,
			"set_to_mod": true,
			"upgrade_name": "thick",
		},
	]
	execute_script(script)
