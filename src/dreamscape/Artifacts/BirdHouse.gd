extends Artifact

const JOURNAL_CUSTOM_ENTRY = preload("res://src/dreamscape/Overworld/CustomEntries/CustomDraft.tscn")
const JOURNAL_DRAFT_SCRIPT = preload("res://src/dreamscape/Overworld/CustomEntries/Artifact_BirdHouseDraft.gd")


func _on_artifact_added() -> void:
	var custom_journal_entry = JOURNAL_CUSTOM_ENTRY.instance()
	custom_journal_entry.script = JOURNAL_DRAFT_SCRIPT
	globals.journal.add_custom_entry(custom_journal_entry)
	var rng_pathos : PathosType = globals.player.pathos.grab_random_pathos()
	var pathos_amount = rng_pathos.get_progression_average()\
			* ArtifactDefinitions.BirdHouse.amounts.pathos_avg_multiplier
	rng_pathos.released += pathos_amount
	var memory_prep = MemoryPrep.new(ArtifactDefinitions.BirdHouse.amounts.memory_amount, true)
	for memory in memory_prep.selected_memories:
		var existing_memory = globals.player.find_memory(memory.canonical_name)
		if existing_memory:
			existing_memory.upgrades_amount += \
					ArtifactDefinitions.BirdHouse.amounts.memory_upgrade_amount
		else:
			# warning-ignore:return_value_discarded
			var new_memory = globals.player.add_memory(memory.canonical_name)
	globals.player.health += ArtifactDefinitions.BirdHouse.amounts.health_amount
	var progress_card := globals.player.deck.get_card_needing_most_progress()
	progress_card.upgrade_progress += ArtifactDefinitions.BirdHouse.amounts.progress_amount
	_send_trigger_signal()
