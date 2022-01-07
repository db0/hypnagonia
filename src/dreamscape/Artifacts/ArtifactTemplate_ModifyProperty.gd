class_name ModifyPropertyArtifact
extends CardSelectArtifact

var property: String
var new_value

func _on_artifact_added() -> void:
	if property == '':
		print_debug("ERROR: 'property' var has to be set before calling this function.")
		return
	._on_artifact_added()


func set_modified_card(card_entry: CardEntry) -> void:
	.set_modified_card(card_entry)
	modified_card.modify_property(property, new_value)
