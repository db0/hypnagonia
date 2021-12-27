extends Artifact

const JOURNAL_CUSTOM_ENTRY = preload("res://src/dreamscape/Overworld/CustomEntries/Artifact_BossDraft.tscn")

func _on_artifact_added() -> void:
	globals.journal.add_custom_entry(JOURNAL_CUSTOM_ENTRY.instance())
