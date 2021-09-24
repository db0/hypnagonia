extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.board.connect("battle_begun", self, "_on_battle_start")


func _on_battle_start():
	if not _activate():
		return
	var repr_frustration = globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.enemy]
	var multiplier = repr_frustration / ArtifactDefinitions.RepressedEnemyBuff.amounts.pathos_amount
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
			"subject": "dreamer",
			"modification": ArtifactDefinitions.RepressedEnemyBuff.amounts.effect_stacks * multiplier,
		},
	]
	execute_script(script)
