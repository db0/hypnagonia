extends ModAmountsArtifact

func _on_artifact_added() -> void:
	amount_name = "discover_purpose"
	purpose = Terms.ACTIVE_EFFECTS.buffer.name
	amount_value = '+1'
	card_choice_description = "Choose Fascination card to increase the fascination stacks it provides by 1."
	card_filters.append(CardFilter.new('Tags', Terms.ACTIVE_EFFECTS.buffer.name, 'eq'))
	._on_artifact_added()
