extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.hand.connect("hand_refilled", self, "_on_first_refill")


func _on_first_refill():
	if not _activate():
		return
	var script = [{
		"name": "draw_cards",
		"card_count": ArtifactDefinitions.StartingCards.amounts.draw_amount,
	}]
	execute_script(script)
