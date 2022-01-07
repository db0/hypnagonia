extends AddTagArtifact

func _on_artifact_added() -> void:
	tag_name = Terms.GENERIC_TAGS.frozen.name
	card_choice_description = " Choose card which should not be discarded at the end of the turn."
	._on_artifact_added()
