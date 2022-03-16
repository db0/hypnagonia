extends ModAmountsArtifact

func _on_artifact_added() -> void:
	amount_name = "discover_purpose"
	purpose = Terms.ACTIVE_EFFECTS.poison.name
	amount_value = '+1'
	card_choice_description = "Choose Doubt card to increase the doubt stacks it applies by 1."
	card_filters.append(CardFilter.new('Tags', Terms.ACTIVE_EFFECTS.poison.name, 'eq'))
	._on_artifact_added()
