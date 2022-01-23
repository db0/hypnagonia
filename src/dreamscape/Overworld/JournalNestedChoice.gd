class_name JournalNestedChoice
extends JournalChoice

# The unique identifier for this choice
var choice_key

func _init(_journal: Node, secondary_choice: String, key).(_journal) -> void:
	choice_key = key
	formated_description = secondary_choice
	bbcode_text = formated_description
	add_to_group("secondary_choices")
