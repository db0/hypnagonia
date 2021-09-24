extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.board.connect("battle_begun", self, "_on_battle_start")


func _on_battle_start():
	if not _activate():
		return
	var script = [
		{
			"name": "assign_defence",
			"subject": "dreamer",
			"amount": ArtifactDefinitions.StartingConfidence.amounts.defence_amount,
		}
	]
	execute_script(script)
