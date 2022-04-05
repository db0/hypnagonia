extends JournalCustomDraft

func _setup() -> void:
	custom_draft_name = "artifact_birdhouse_draft"
	draft_amount = ArtifactDefinitions.BirdHouse.amounts.draft_amount
	draft_choices = ArtifactDefinitions.BirdHouse.amounts.draft_choices
	description.bbcode_text = "I could see the first residents of the bird house approaching.\n"\
			+ "[Draft %s cards]" % [draft_amount]


func _execute_custom_entry() -> void:
	initiate_custom_draft()
