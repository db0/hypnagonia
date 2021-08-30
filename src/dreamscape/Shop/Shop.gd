extends PanelContainer

const CARD_SHOP_SCENE = preload("res://src/dreamscape/Shop/ShopCardChoice.tscn")
const CARD_CHOICE_SCENE = preload("res://src/dreamscape/ChoiceCardObject.tscn")

var card_price_multipliers := {
	"Commons": 3,
	"Uncommons": 5,
	"Rares": 10,
}

var uncommon_chance : float = 25.0/100
var rare_chance : float = 5.0/100

var shop_choices := {
	"Commons": [],
	"Uncommons": [],
	"Rares": [],
}
var all_card_pool_choices := []

var current_decklist_cache: Array
var deck_operation : String
var progress_cost: int
var progress_uses: int = 0
var progress_max_usage: int = 3
var remove_cost: int
var remove_uses: int = 0
var remove_max_usage: int = 1
var remove_cost_increase_per_use := 25
# These variables are the type of pathos that we use to purchase the various
# Things in the shop. By specifying the variables here, I can tweak
# them easily later, or change them via an artifact
var card_pool_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.nce
var card_removal_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.enemy
var card_progress_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.rest

onready var card_pool_shop := $VBC/CC/CardPoolShop
onready var _deck_button := $VBC/HBC/Buttons/Remove
onready var _deck_preview_popup := $Deck
onready var _deck_operation_name := $Deck/VBC/OperationName/
onready var _deck_operation_cost := $Deck/VBC/OperationCost/
onready var _deck_preview_scroll := $Deck/VBC/ScrollContainer/
onready var _deck_preview_grid := $Deck/VBC/ScrollContainer/GridContainer
onready var _progress_cost := $VBC/HBC/Buttons/ProgressCost
onready var _progress_button := $VBC/HBC/Buttons/Progress
onready var _remove_cost := $VBC/HBC/Buttons/RemoveCost
onready var _remove_button := $VBC/HBC/Buttons/Remove

func _ready() -> void:
	populate_shop_cards()

func populate_shop_cards() -> void:
	cfc.game_rng_seed = CFUtils.generate_random_seed()
	NewGameMenu.randomize_aspect_choices()
	globals.player.setup()
	globals.player.deck.add_new_card("+ Confidence +")
	globals.player.deck.add_new_card("+ Confidence +")
	globals.player.deck.add_new_card("+ Confidence +")
	globals.player.deck.add_new_card("+ Confidence +")
	globals.player.pathos.released["frustration"] = 160
	globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.rest] = 20
	_update_progress_cost()
	_update_remove_cost()
	for _iter in range(5):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= rare_chance:
			shop_choices['Rares'].append(_get_shop_choice(
					globals.player.compile_rarity_cards('Rares')))
		elif chance <= rare_chance + uncommon_chance:
			shop_choices['Uncommons'].append(_get_shop_choice(
					globals.player.compile_rarity_cards('Uncommons')))
		else:
			shop_choices['Commons'].append(_get_shop_choice(
					globals.player.compile_rarity_cards('Commons')))
	for rarity in shop_choices:
		for card_name in shop_choices[rarity]:
			# By separating the cost_type like this, I can theoretically
			# randomize the cost_type per card.
			var cost_type : String = card_pool_cost_type
			var prog_avg := globals.player.pathos.get_progression_average(
						cost_type)
			var card_cost =\
					(prog_avg * card_price_multipliers[rarity])\
					+ (CFUtils.randi_range(
						prog_avg / -5 * card_price_multipliers[rarity],
						prog_avg / 5 * card_price_multipliers[rarity]))
			var shop_choice_dict = {
				"card_name": card_name,
				"cost": card_cost,
				"cost_type": cost_type,
			}
			all_card_pool_choices.append(shop_choice_dict)
	for index in range(all_card_pool_choices.size()):
		var card_name: String = all_card_pool_choices[index].card_name
		var shop_card_object = CARD_SHOP_SCENE.instance()
		card_pool_shop.add_child(shop_card_object)
		shop_card_object.cost_type = all_card_pool_choices[index].cost_type
		shop_card_object.cost = all_card_pool_choices[index].cost
		shop_card_object.shop_card_display.setup(card_name)
		shop_card_object.shop_card_display.index = index
		shop_card_object.shop_card_display.connect("card_selected", self, "_on_shop_card_selected", [shop_card_object])


func _get_shop_choice(card_names: Array) -> String:
	CFUtils.shuffle_array(card_names)
	if card_names.size():
		for card_name in card_names:
			# We use this to ensure no duplicates exist
			var card_pool_choices := []
			# We do not want a duplicate card choice option for the shop
			for rarity in shop_choices:
				card_pool_choices += shop_choices[rarity]
			if not card_name in card_pool_choices:
				return(card_name)
	return('')


func _on_shop_card_selected(index: int, shop_card_object) -> void:
	if globals.player.pathos.released[all_card_pool_choices[index].cost_type] <\
			all_card_pool_choices[index].cost:
		return
	globals.player.pathos.released[all_card_pool_choices[index].cost_type] -=\
			all_card_pool_choices[index].cost
	globals.player.deck.add_new_card(all_card_pool_choices[index].card_name)
	shop_card_object.modulate.a = 0
	_update_progress_cost()
	_update_remove_cost()


func _display_deck() -> void:
	var popup_size_x = (CFConst.CARD_SIZE.x * CFConst.THUMBNAIL_SCALE * _deck_preview_grid.columns)\
			+ _deck_preview_grid.get("custom_constants/vseparation") * _deck_preview_grid.columns
	_deck_preview_popup.rect_size = Vector2(popup_size_x,600)
	_deck_preview_popup.popup_centered()
	populate_preview_cards()


func populate_preview_cards() -> void:
	if current_decklist_cache != globals.player.deck.list_all_cards():
		for card in _deck_preview_grid.get_children():
			card.queue_free()
		current_decklist_cache = globals.player.deck.list_all_cards()
		for index in range(globals.player.deck.cards.size()):
			var card_preview_container = CARD_CHOICE_SCENE.instance()
			_deck_preview_grid.add_child(card_preview_container)
			card_preview_container.index = globals.player.deck.cards[index]
			card_preview_container.setup(globals.player.deck.cards[index].card_name)
			card_preview_container.display_card.deck_card_entry = globals.player.deck.cards[index]
			card_preview_container.connect("card_selected", self, "_on_deck_card_selected", [card_preview_container])


func _on_Remove_pressed() -> void:
	deck_operation = "remove"
	_deck_operation_name.text = "Remove Card"
	_display_deck()


func _on_ProgressCards_pressed() -> void:
	deck_operation = "progress"
	_deck_operation_name.text = "Progress Card Upgrade"
	_update_progress_cost()
	_display_deck()


func _on_deck_card_selected(card_entry: CardEntry, deck_card_object) -> void:
	if deck_operation == "remove" and\
			 remove_cost <= globals.player.pathos.released[card_removal_cost_type]:
		globals.player.pathos.released[card_removal_cost_type] -= remove_cost
		globals.player.deck.remove_card(card_entry)
		deck_card_object.queue_free()
		globals.encounters.shop_deck_removals += 1
		remove_uses += 1
		_update_remove_cost()
		if remove_uses >= remove_max_usage:
			_deck_preview_popup.hide()
			_remove_button.disabled = true
			deck_card_object.preview_popup.hide_preview_card()
	if deck_operation == "progress" and\
			 progress_cost <= globals.player.pathos.released[card_progress_cost_type]:
		globals.player.pathos.released[card_progress_cost_type] -= progress_cost
		card_entry.record_use()
		deck_card_object.refresh_preview_card()
		progress_uses += 1
		_update_progress_cost()
		# Each visit to the shop only allows a limited amount of uses of the upgrade
		if progress_uses >= progress_max_usage:
			_deck_preview_popup.hide()
			_progress_button.disabled = true
			deck_card_object.preview_popup.hide_preview_card()


# The cost to progress is equals three times the average rest progression
# then multiplied by the percentage of upgraded cards in the deck.
# This means, the more upgraded the deck is, the more costly it is to
# further upgrade cards
func _update_progress_cost() -> void:
	progress_cost = round(
			globals.player.pathos.get_progression_average(
				card_progress_cost_type)
			* globals.player.deck.get_upgrade_percentage()
			* 3)
	if progress_cost < 2:
		progress_cost = 3
	var progress_text_format = {
		"cost": str(progress_cost),
		"pathos": card_progress_cost_type.capitalize(),
		"uses_avail": str(progress_uses),
		"uses_max": str(progress_max_usage),
	}
	_progress_cost.text = "{cost} {pathos}\n({uses_avail}/{uses_max} uses)".format(progress_text_format)
	if deck_operation == "progress":
		_deck_operation_cost.text = "{cost} {pathos} ({uses_avail}/{uses_max} uses)".format(progress_text_format)
	if progress_cost > globals.player.pathos.released[card_progress_cost_type]:
		if deck_operation == "progress":
			_deck_operation_cost.add_color_override("font_color", Color(1,0,0))
		_progress_cost.add_color_override("font_color", Color(1,0,0))
	else:
		if deck_operation == "progress":
			_deck_operation_cost.add_color_override("font_color", Color(1,1,0))
		_progress_cost.add_color_override("font_color", Color(1,1,0))

# The cost to upgrade is equals three times the average enemy progression
# + 25 for every card already removed from the deck.
func _update_remove_cost() -> void:
	remove_cost = round(
			globals.player.pathos.get_progression_average(
				card_removal_cost_type)
			* 3)\
			+ (remove_cost_increase_per_use * globals.encounters.shop_deck_removals)
	var remove_text_format = {
		"cost": str(remove_cost),
		"pathos": card_removal_cost_type.capitalize(),
		"uses_avail": str(remove_uses),
		"uses_max": str(remove_max_usage),
	}
	_remove_cost.text = "{cost} {pathos}\n({uses_avail}/{uses_max} uses)".format(remove_text_format)
	if deck_operation == "remove":
		_deck_operation_cost.text = "{cost} {pathos} ({uses_avail}/{uses_max} uses)".format(remove_text_format)
	if remove_cost > globals.player.pathos.released[card_removal_cost_type]:
		if deck_operation == "remove":
			_deck_operation_cost.add_color_override("font_color", Color(1,0,0))
		_remove_cost.add_color_override("font_color", Color(1,0,0))
	else:
		if deck_operation == "remove":
			_deck_operation_cost.add_color_override("font_color", Color(1,1,0))
		_remove_cost.add_color_override("font_color", Color(1,1,0))
