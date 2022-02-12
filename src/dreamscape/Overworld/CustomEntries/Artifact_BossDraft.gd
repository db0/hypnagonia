extends JournalCustomDraft

func _setup() -> void:
	custom_draft_name = "artifact_boss_draft"
	draft_amount = ArtifactDefinitions.BossDraft.amounts.draft_amount
	description.bbcode_text = "It was time to drink that curious beer that I discovered.\n"\
			+ "[Draft %s cards from one of your aspects]" % [draft_amount]


func _execute_custom_entry() -> void:
	var secondary_choices_dict := {}
	for aspect in globals.player.deck_groups:
		secondary_choices_dict[aspect] = "Draft %s cards from my %s aspect (%s)" % [
				draft_amount,
				aspect, 
				globals.player.deck_groups[aspect]
			]
	globals.journal.add_nested_choices(secondary_choices_dict, [], self)


func continue_encounter(key) -> void:
	draft_payload = key
	initiate_custom_draft()


func _on_card_drafted(card: CardEntry) -> void:
	card.upgrade_progress = ArtifactDefinitions.BossDraft.amounts.progress_amount
