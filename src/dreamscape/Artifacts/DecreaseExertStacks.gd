extends ModAmountsArtifact

func _on_artifact_added() -> void:
	amount_name = "exert_amount"
	amount_value = '-2'
	card_choice_description = "Choose a Rationalizations card to decrease the anxiety it gives by 2."
	card_filters.append(CardFilter.new('Tags', Terms.GENERIC_TAGS.exert.name, 'eq'))
	._on_artifact_added()
