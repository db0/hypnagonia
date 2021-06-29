class_name PostBattleMenu
extends PanelContainer

const CARD_DRAFT_SCENE = preload("res://src/dreamscape/DraftCardObject.tscn")

var uncommon_chance : float = 25.0/100
var rare_chance : float = 5.0/100
var draft_amount := 3
var draft_card_choices : Array

onready var card_choices_grid = $CardDraft/CardChoices
onready var card_draft = $CardDraft
onready var card_draft_button = $VBC/CardReward
onready var proceed_button = $VBC/Proceed

func display() -> void:
	rect_global_position = get_viewport().size/2 - rect_size/2
	visible = true
	card_draft_button.visible = true
	populate_draft_cards()


func populate_draft_cards() -> void:
	retrieve_draft_cards()
	for index in range(draft_card_choices.size()):
		var card_name: String = draft_card_choices[index]
		var draft_card_object = CARD_DRAFT_SCENE.instance()
		card_choices_grid.add_child(draft_card_object)
		draft_card_object.setup(card_name)
		draft_card_object.index = index
		draft_card_object.connect("card_selected", self, "_on_card_draft_selected")


func _on_CardReward_pressed() -> void:
	card_draft.popup_centered_minsize()


func _on_card_draft_selected(option) -> void:
	for child in card_choices_grid.get_children():
		child.queue_free()
	card_draft.hide()
	card_draft_button.visible = false
	globals.player.deck.add_new_card(draft_card_choices[option])


func _on_Proceed_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(CFConst.PATH_CUSTOM + 'Main.tscn')


func retrieve_draft_cards() -> void:
	draft_card_choices.clear()
	for _iter in range(draft_amount):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= rare_chance:
#			print_debug('Rare: ' + str(chance))
			card_names = compile_rarity_cards('Rares')
		elif chance <= rare_chance + uncommon_chance:
#			print_debug('Uncommon: ' + str(chance))
			card_names = compile_rarity_cards('Uncommons')
		else:
#			print_debug('common: ' + str(chance))
			card_names = compile_rarity_cards('Commons')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					draft_card_choices.append(card_name)
					break


func compile_rarity_cards(rarity: String) -> Array:
	var rarity_cards := []
	for key in globals.player.deck.deck_groups:
		rarity_cards += CardGroupDefinitions[key.to_upper()][globals.player.deck.deck_groups[key]][rarity]
	return(rarity_cards)
