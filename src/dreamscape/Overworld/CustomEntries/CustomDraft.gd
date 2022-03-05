class_name JournalCustomDraft
extends JournalCustomEntry

const CARD_DRAFT_SCENE = preload("res://src/dreamscape/Overworld/CardDraftSlide.tscn")

var draft_nodes := []
var draft_payload
var draft_amount := 1
var draft_choices := 3
var custom_draft_name : String

onready var description := $Description
onready var secondary_choices := $SecondaryChoices

func _ready() -> void:
	_setup()
	for _iter in range(draft_amount):
		var card_draft = CARD_DRAFT_SCENE.instance()
		add_child(card_draft)
		draft_nodes.append(card_draft)
	_reveal_entry(description, true)


func _execute_custom_entry() -> void:
	initiate_custom_draft()


func initiate_custom_draft() -> void:
	for draft_node in draft_nodes:
		draft_node.get_node("CardDraft").connect("card_drafted", self, "_on_card_drafted")
		draft_node.get_node("CardDraft").special_draft_payload = draft_payload
		draft_node.get_node("CardDraft").draft_amount = draft_choices
		draft_node.get_node("CardDraft").display(custom_draft_name)


# Overridable function in case we want more stuff to hapen post-draft
func _on_card_drafted(card: CardEntry) -> void:
	pass

# Overridable function to set prepare the custom draft
func _setup() -> void:
	description.bbcode_text = "Initiate Custom Draft for %s cards." % [draft_amount]
	custom_draft_name = 'CustomDraft'
	draft_choices = 3
