extends Artifact

const JOURNAL_CUSTOM_ENTRY = preload("res://src/dreamscape/Overworld/CustomEntries/CustomDraft.tscn")
const JOURNAL_DRAFT_SCRIPT = preload("res://src/dreamscape/Overworld/CustomEntries/Artifact_BossDraft.gd")


func _on_artifact_added() -> void:
	var custom_journal_entry = JOURNAL_CUSTOM_ENTRY.instance()
	custom_journal_entry.script = JOURNAL_DRAFT_SCRIPT
	globals.journal.add_custom_entry(custom_journal_entry)
	_send_trigger_signal()
