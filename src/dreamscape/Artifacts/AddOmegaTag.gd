extends AddTagArtifact

func _on_artifact_added() -> void:
	tag_name = Terms.GENERIC_TAGS.omega.name
	card_choice_description = "Choose card which should always start at the bottom of the deck."
	._on_artifact_added()
