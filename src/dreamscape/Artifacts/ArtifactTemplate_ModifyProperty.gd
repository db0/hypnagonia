class_name ModifyPropertyArtifact
extends CardSelectArtifact

var property: String
var new_value

func _on_artifact_added() -> void:
	if property == '':
		print_debug("ERROR: 'property' var has to be set before calling this function.")
		return
	._on_artifact_added()


func on_card_upgrade_ended(old_card: CardEntry, new_card: CardEntry) -> void:
	.on_card_upgrade_ended(old_card, new_card)
	if old_card == modified_card:
		modified_card.modify_property(property, new_value)


func set_modified_card(card_entry: CardEntry) -> void:
	.set_modified_card(card_entry)
	modified_card.modify_property(property, new_value)
