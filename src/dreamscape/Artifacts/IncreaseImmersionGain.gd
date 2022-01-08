extends ModAmountsArtifact

func _on_artifact_added() -> void:
	amount_name = "immersion_amount"
	amount_value = '+1'
	card_choice_description = "Choose Immersion card to increase the immersion stacks it provides by 1."
	card_filters.append(CardFilter.new('Tags', Terms.GENERIC_TAGS.purpose.name, 'eq'))
	._on_artifact_added()
