extends ModifyPropertyArtifact

func _on_artifact_added() -> void:
	property = 'Cost'
	new_value = 0
	card_filters.append(CardFilter.new(property, 1, 'ge'))
	selection_type = SelectionType.RANDOM
	._on_artifact_added()
