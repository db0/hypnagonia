extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		globals.player.deck.connect("card_entry_progressed", self, "_on_card_entry_progressed")


func _on_card_entry_progressed(card_entry: CardEntry, amount: int) -> void:
	if globals.player.deck.count_cards() < 25:
		return
	# We need to avoid resending the upgrade_signal again, or we'll create a loop
	# until the card upgrades are maxed out
	card_entry.set_upgrade_progress(card_entry.upgrade_progress + amount, true)
	_send_trigger_signal()

