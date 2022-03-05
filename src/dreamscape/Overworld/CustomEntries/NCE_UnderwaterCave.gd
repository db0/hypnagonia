extends JournalCustomDraft

var description_text: String

func _setup() -> void:
	custom_draft_name = "nce_underwater_cave"
	description.bbcode_text = description_text\
			+ "\n[Draft %s cards with higher rarity chance]" % [draft_amount]
	draft_choices = 5
