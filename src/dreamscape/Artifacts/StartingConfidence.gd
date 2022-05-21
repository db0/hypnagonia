extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.board.dreamer.connect("entity_turn_started", self, "_on_entity_turn_started")


# We're not using the more appropriate battle_begun signal because the 
# turn-start defence will clear the starting defence
func _on_entity_turn_started():
	if not _activate():
		return
	var script = [
		{
			"name": "assign_defence",
			"subject": "dreamer",
			"amount": ArtifactDefinitions.StartingConfidence.amounts.defence_amount,
			"tags": ["Curio"],
		}
	]
	execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()
