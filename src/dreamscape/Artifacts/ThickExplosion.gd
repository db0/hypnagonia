extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.board.connect("battle_begun", self, "_on_battle_start")


# Connecting the signal here ensures the artifact will not be disabled at the start of combat
func _on_battle_start() -> void:
	cfc.NMAP.discard.connect("discard_reshuffled_into_deck", self, "_on_first_reshuffle")


func _on_first_reshuffle() -> void:
	_activate()
	cfc.NMAP.discard.disconnect("discard_reshuffled_into_deck", self, "_on_first_reshuffle")
	var script = [
		{
			"name": "modify_damage",
			"subject": "boardseek",
			"amount": cfc.NMAP.discard.last_amount_pre_reshuffle,
			"subject_count": "all",
			"tags": ["Artifact", "Blockable", "Curio"],
			"filter_state_seek": [{
				"filter_group": "EnemyEntities",
			}],
		},
	]
	execute_script(script)
