extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.OVERWORLD:
		globals.player.deck.connect("card_added", self, "_on_card_added")

func _on_card_added(card_entry: CardEntry)  -> void:
	if card_entry.get_property("Type") == "Concentration":
		card_entry.upgrade_progress += ArtifactDefinitions.UpgradedConcentration.amounts.progress_amount
