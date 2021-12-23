extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
			cfc.NMAP.board.connect("battle_ended", self, "_on_battle_ended")

func _on_battle_ended() -> void:
	globals.player.damage -= 6
