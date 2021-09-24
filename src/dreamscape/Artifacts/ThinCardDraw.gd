extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		cfc.NMAP.hand.connect("hand_refilled", self, "_on_first_refill")

# We use this stop-gap to prevent the artifact trying to draw a card on the
# very first shuffle of the game, which can break things
func _on_first_refill():
	cfc.NMAP.hand.disconnect("hand_refilled", self, "_on_first_refill")
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_reshuffle")
	
func _on_reshuffle(_pile: Pile):
	var script = [{
		"name": "draw_cards",
		"card_count": ArtifactDefinitions.ThinCardDraw.amounts.draw_amount,
	}]
	execute_script(script)

