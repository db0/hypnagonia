extends AddTagArtifact

func _on_artifact_added() -> void:
	tag_name = Terms.GENERIC_TAGS.alpha.name
	card_choice_description = "Choose card which should always start at the top of the deck."
	._on_artifact_added()
