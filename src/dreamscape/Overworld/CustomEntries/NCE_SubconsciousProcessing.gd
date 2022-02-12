extends JournalCustomDraft

var description_text: String

func _setup() -> void:
	custom_draft_name = "nce_subconscious_processing"
	description.bbcode_text = description_text\
			+ "\n[Draft %s Understanding cards]" % [draft_amount]
