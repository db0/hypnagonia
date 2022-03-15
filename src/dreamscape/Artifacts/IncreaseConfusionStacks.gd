extends ModAmountsArtifact

func _on_artifact_added() -> void:
	amount_name = "discover_purpose"
	purpose = Terms.ACTIVE_EFFECTS.disempower.name
	amount_value = '+1'
	card_choice_description = "Choose Confusion card to increase the confusion stacks it inflicts by 1."
	card_filters.append(CardFilter.new('Tags', Terms.ACTIVE_EFFECTS.disempower.name, 'eq'))
	._on_artifact_added()
