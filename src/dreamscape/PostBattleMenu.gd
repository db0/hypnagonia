class_name PostBattleMenu
extends PanelContainer

const CARD_DRAFT_SCENE = preload("res://src/dreamscape/DraftCardObject.tscn")
var card_choices := [
	"Assault",
	"Defend",
	"Noisy Whip",
]

onready var card_choices_grid = $CardDraft/CardChoices
onready var card_draft = $CardDraft
onready var card_draft_button = $VBC/CardReward
onready var proceed_button = $VBC/Proceed

func display() -> void:
	rect_global_position = get_viewport().size/2 - rect_size/2
	visible = true
	card_draft_button.visible = true


func populate_draft_cards() -> void:
	for index in range(card_choices.size()):
		var card_name: String = card_choices[index]
		var draft_card_object = CARD_DRAFT_SCENE.instance()
		card_choices_grid.add_child(draft_card_object)
		draft_card_object.setup(card_name)
		draft_card_object.index = index
		draft_card_object.connect("card_selected", self, "_on_card_draft_selected")


func _on_CardReward_pressed() -> void:
	populate_draft_cards()
	card_draft.popup_centered_minsize()
	

func _on_card_draft_selected(option) -> void:
	for child in card_choices_grid.get_children():
		child.queue_free()
	card_draft.hide()
	card_draft_button.visible = false

	globals.deck.add_new_card(card_choices[option])
	print_debug(globals.deck.list_all_cards())


func _on_Proceed_pressed() -> void:
	get_tree().change_scene(CFConst.PATH_CUSTOM + 'Main.tscn')
