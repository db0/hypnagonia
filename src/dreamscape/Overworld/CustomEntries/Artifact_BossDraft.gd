extends JournalCustomEntry

const CARD_DRAFT_SCENE = preload("res://src/dreamscape/Overworld/CardDraftSlide.tscn")

var draft_nodes := []

onready var description := $Description
onready var secondary_choices := $SecondaryChoices

func _ready() -> void:
	description.bbcode_text = "It was time to drink that curious beer that I discovered.\n"\
			+ "[Draft %s cards from one of your aspects]" % [ArtifactDefinitions.BossDraft.amounts.draft_amount]
	for _iter in range(ArtifactDefinitions.BossDraft.amounts.draft_amount):
		var card_draft = CARD_DRAFT_SCENE.instance()
		add_child(card_draft)
		draft_nodes.append(card_draft)
	_reveal_entry(description, true)

func _execute_custom_entry() -> void:
	var secondary_choices_dict := {}
	for aspect in globals.player.deck_groups:
		secondary_choices_dict[aspect] = "Draft %s cards from my %s aspect (%s)" % [
				ArtifactDefinitions.BossDraft.amounts.draft_amount,
				aspect, 
				globals.player.deck_groups[aspect]
			]
	globals.journal.add_nested_choices(secondary_choices_dict, [], self)


func continue_encounter(key) -> void:
	for draft_node in draft_nodes:
		draft_node.get_node("CardDraft").connect("card_drafted", self, "_on_card_drafted")
		draft_node.get_node("CardDraft").display(key)


func _on_card_drafted(card: CardEntry) -> void:
	card.upgrade_progress = ArtifactDefinitions.BossDraft.amounts.progress_amount
