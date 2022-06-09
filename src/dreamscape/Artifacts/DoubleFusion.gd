extends Artifact

func _ready():
	EventBus.connect("card_drafted",self, "_on_card_drafted")

func _on_card_drafted(drafted_card: CardEntry) -> void:
	var aaa = drafted_card.properties.get("Tags", [])
	if Terms.GENERIC_TAGS.fusion.name in drafted_card.properties.get("Tags", []):
		globals.player.deck.add_new_card(drafted_card.card_name)
		_send_trigger_signal()
