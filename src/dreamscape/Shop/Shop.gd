extends PanelContainer

const CARD_SHOP_SCENE = preload("res://src/dreamscape/Shop/ShopCardChoice.tscn")
const ARTIFACT_SHOP_SCENE = preload("res://src/dreamscape/Shop/ShopArtifactChoice.tscn")

var rarity_price_multipliers := {
	"Common": 3,
	"Uncommon": 5,
	"Rare": 10,
	"Understanding": 10,
}
# Artifacts tend to be more expensive based on their pathos average
# So we multiply their cost a bit further
var artifact_cost_multiplier := 1.5

var uncommon_chance := 25
var rare_chance := 5
var shop_card_choices := {
	"Common": [],
	"Uncommon": [],
	"Rare": [],
	"Understanding": [],
}
var all_card_pool_choices := []
var all_special_card_choices := []
var artifact_prep: ArtifactPrep
var all_artifact_choices := []

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
var card_removal_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.enemy
var card_progress_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.rest
var card_pool_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.nce
var special_cards_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.artifact
# We want one of the card choices to use a different currency
var card_pool_secondary_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.enemy
var artifact_cost_type : String = Terms.RUN_ACCUMULATION_NAMES.elite

onready var card_pool_shop := $VBC/VBC/CC/CardPoolShop
onready var special_cards_shop := $VBC/VBC/HBC/MainArea/SpecialCards
onready var artifact_shop := $VBC/VBC/HBC/MainArea/ArtifactCC/Artifacts
onready var _deck_button := $VBC/VBC/HBC/Buttons/Remove
onready var _deck_preview_popup := $Deck
onready var _progress_cost := $VBC/VBC/HBC/Buttons/ProgressCost
onready var _progress_button := $VBC/VBC/HBC/Buttons/Progress
onready var _remove_cost := $VBC/VBC/HBC/Buttons/RemoveCost
onready var _remove_button := $VBC/VBC/HBC/Buttons/Remove
# This button is connected to the event code.
onready var back_button := $VBC/VBC/HBoxContainer/Back
onready var player_info := $VBC/PlayerInfo


func _ready() -> void:
	## DEBUG - Allows to run scene by itself ##
	if not globals.journal:
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		# warning-ignore:return_value_discarded
		NewGameMenu.randomize_aspect_choices()
		globals.player.setup()
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("+ Confidence +")
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("+ Confidence +")
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("+ Confidence +")
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("+ Confidence +")
		globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.nce] = 160
		globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.rest] = 20
		globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.elite] = 40
		globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.enemy] = 400
		globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.artifact] = 100
		# We're doing a connect here, because the globals.deck will not exist during its ready
		# warning-ignore:return_value_discarded
		globals.player.deck.connect("card_added", player_info, "_update_deck_count")
		# warning-ignore:return_value_discarded
		globals.player.deck.connect("card_removed", player_info, "_update_deck_count")
	## END DEBUG ##
	globals.music.switch_scene_music('shop')
	# warning-ignore:return_value_discarded
	_deck_preview_popup.connect("operation_performed", self, "_on_deck_operation_performed")
	populate_shop_cards()
	populate_special_cards()
	populate_shop_artifacts()
	if not cfc.game_settings.get('first_shop_tutorial_done'):
		player_info._on_Help_pressed()
		cfc.set_setting('first_shop_tutorial_done', true)

func populate_shop_cards() -> void:
	_update_progress_cost()
	_update_remove_cost()
	for _iter in range(5):
		var chance := CFUtils.randi_range(1, 100)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= rare_chance:
			shop_card_choices['Rare'].append(_get_shop_choice(
					globals.player.compile_rarity_cards('Rare')))
		elif chance <= rare_chance + uncommon_chance:
			shop_card_choices['Uncommon'].append(_get_shop_choice(
					globals.player.compile_rarity_cards('Uncommon')))
		else:
			shop_card_choices['Common'].append(_get_shop_choice(
					globals.player.compile_rarity_cards('Common')))
	var card_number := 0
	for rarity in shop_card_choices:
		for card_name in shop_card_choices[rarity]:
			card_number += 1
			# By separating the cost_type like this, I can theoretically
			# randomize the cost_type per card.
			var cost_type : String = card_pool_cost_type
			# I want at least one card to use frustration for cost
			if card_number == 5:
				cost_type = card_pool_secondary_cost_type
			var prog_avg : float = globals.player.pathos.get_progression_average(
						cost_type)
			var card_cost =\
					(prog_avg * rarity_price_multipliers[rarity])\
					+ (CFUtils.randi_range(
						prog_avg / -5 * rarity_price_multipliers[rarity],
						prog_avg / 5 * rarity_price_multipliers[rarity]))
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


func populate_shop_artifacts() -> void:
	artifact_prep = ArtifactPrep.new(rare_chance, uncommon_chance, 4)
	## DEBUG
#	artifact_prep.append_artifact("ImproveImpervious")
	## END DEBUG
	for artifact in artifact_prep.selected_artifacts:
		var rarity = artifact.rarity
		# By separating the cost_type like this, I can theoretically
		# randomize the cost_type per card.
		var cost_type : String = artifact_cost_type
		var prog_avg : float = globals.player.pathos.get_progression_average(
					cost_type)
		var artifact_cost =\
				(round(prog_avg * rarity_price_multipliers[rarity] * artifact_cost_multiplier))\
				+ (CFUtils.randi_range(
					prog_avg / -5 * rarity_price_multipliers[rarity],
					prog_avg / 5 * rarity_price_multipliers[rarity]))
		var shop_choice_dict = {
			"artifact_name": artifact.name,
			"cost": artifact_cost,
			"cost_type": cost_type,
		}
		all_artifact_choices.append(shop_choice_dict)
	for index in range(all_artifact_choices.size()):
		var artifact: Dictionary = artifact_prep.selected_artifacts[index]
		var shop_artifact_object = ARTIFACT_SHOP_SCENE.instance()
		artifact_shop.add_child(shop_artifact_object)
		shop_artifact_object.cost_type = all_artifact_choices[index].cost_type
		shop_artifact_object.cost = all_artifact_choices[index].cost
		shop_artifact_object.shop_artifact_display.setup(artifact, artifact.canonical_name)
		shop_artifact_object.shop_artifact_display.index = index
		shop_artifact_object.shop_artifact_display.connect("artifact_selected", self, "_on_shop_artifact_selected", [shop_artifact_object])


func populate_special_cards() -> void:
	var rarity = "Understanding"
	for _iter in range(3):
		shop_card_choices[rarity].append(_get_shop_choice(
					globals.player.compile_card_type(rarity)))
	for card_name in shop_card_choices[rarity]:
		# By separating the cost_type like this, I can theoretically
		# randomize the cost_type per card.
		var cost_type : String = special_cards_cost_type
		var prog_avg : float = globals.player.pathos.get_progression_average(
					cost_type)
		var card_cost =\
				(prog_avg * rarity_price_multipliers[rarity])\
				+ (CFUtils.randi_range(
					prog_avg / -5 * rarity_price_multipliers[rarity],
					prog_avg / 5 * rarity_price_multipliers[rarity]))
		var shop_choice_dict = {
			"card_name": card_name,
			"cost": card_cost,
			"cost_type": cost_type,
		}
		all_special_card_choices.append(shop_choice_dict)
	for index in range(all_special_card_choices.size()):
		var card_name: String = all_special_card_choices[index].card_name
		var shop_card_object = CARD_SHOP_SCENE.instance()
		special_cards_shop.add_child(shop_card_object)
		shop_card_object.cost_type = all_special_card_choices[index].cost_type
		shop_card_object.cost = all_special_card_choices[index].cost
		shop_card_object.shop_card_display.setup(card_name)
		shop_card_object.shop_card_display.index = index
		shop_card_object.shop_card_display.connect(
			"card_selected",
			self,
			"_on_shop_card_selected",
			[shop_card_object, all_special_card_choices])


func _get_shop_choice(choices_list: Array) -> String:
	CFUtils.shuffle_array(choices_list)
	if choices_list.size():
		for card_name in choices_list:
			# We use this to ensure no duplicates exist
			var card_pool_choices := []
			# We do not want a duplicate card choice option for the shop
			for rarity in shop_card_choices:
				card_pool_choices += shop_card_choices[rarity]
			if not card_name in card_pool_choices:
				return(card_name)
	return('')


func _on_shop_card_selected(index: int, shop_card_object, containing_array := all_card_pool_choices) -> void:
	if globals.player.pathos.released[containing_array[index].cost_type] <\
			containing_array[index].cost:
		return
	globals.player.pathos.released[containing_array[index].cost_type] -=\
			containing_array[index].cost
	globals.player.pathos.release_pathos(
			containing_array[index].cost_type,
			-containing_array[index].cost)
	# warning-ignore:return_value_discarded
	globals.player.deck.add_new_card(containing_array[index].card_name)
	shop_card_object.disable()
	_update_progress_cost()
	_update_remove_cost()


func _on_shop_artifact_selected(index: int, shop_artifact_object) -> void:
	if globals.player.pathos.released[all_artifact_choices[index].cost_type] <\
			all_artifact_choices[index].cost:
		return
	globals.player.pathos.released[all_artifact_choices[index].cost_type] -=\
			all_artifact_choices[index].cost
	globals.player.add_artifact(shop_artifact_object.shop_artifact_display.canonical_name)
	shop_artifact_object.modulate.a = 0


func _on_Remove_pressed() -> void:
	_deck_preview_popup.initiate_card_removal(remove_cost, card_removal_cost_type)
	_update_remove_cost()


func _on_ProgressCards_pressed() -> void:
	_deck_preview_popup.initiate_card_progress(progress_cost, card_progress_cost_type)
	_update_progress_cost()


# The cost to progress is equals three times the average rest progression
# then multiplied by the percentage of upgraded cards in the deck.
# This means, the more upgraded the deck is, the more costly it is to
# further upgrade cards
func _update_progress_cost() -> void:
	# warning-ignore:narrowing_conversion
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
	if _deck_preview_popup.operation == "progress":
		_deck_preview_popup.operation_cost = progress_cost
		_deck_preview_popup.update_header(
				"{cost} {pathos} ({uses_avail}/{uses_max} uses)".format(progress_text_format))
	if progress_cost > globals.player.pathos.released[card_progress_cost_type]:
		if _deck_preview_popup.operation == "progress":
			_deck_preview_popup.update_color(Color(1,0,0))
		_progress_cost.add_color_override("font_color", Color(1,0,0))
	else:
		if _deck_preview_popup.operation == "progress":
			_deck_preview_popup.update_color(Color(1,1,0))
		_progress_cost.add_color_override("font_color", Color(1,1,0))


# The cost to upgrade is equals three times the average enemy progression
# + 25 for every card already removed from the deck.
func _update_remove_cost() -> void:
# warning-ignore:narrowing_conversion
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
	if _deck_preview_popup.operation == "remove":
		_deck_preview_popup.operation_cost = remove_cost
		_deck_preview_popup.update_header(
				"{cost} {pathos} ({uses_avail}/{uses_max} uses)".format(remove_text_format))
	if remove_cost > globals.player.pathos.released[card_removal_cost_type]:
		if _deck_preview_popup.operation == "remove":
			_deck_preview_popup.update_color(Color(1,0,0))
		_remove_cost.add_color_override("font_color", Color(1,0,0))
	else:
		if _deck_preview_popup.operation == "remove":
			_deck_preview_popup.update_color(Color(1,1,0))
		_remove_cost.add_color_override("font_color", Color(1,1,0))


func _on_deck_operation_performed(operation_details: Dictionary) -> void:
	if operation_details["operation"] == "remove":
		remove_uses += 1
		# Each use makes further uses more expensive in this run
		globals.encounters.shop_deck_removals += 1
		_update_remove_cost()
		if remove_uses >= remove_max_usage:
			_deck_preview_popup.hide()
			_remove_button.disabled = true
			globals.hide_all_previews()
	elif operation_details["operation"] == "progress":
		progress_uses += 1
		_update_progress_cost()
		# Each visit to the shop only allows a limited amount of uses of the upgrade
		if progress_uses >= progress_max_usage:
			_deck_preview_popup.hide()
			_progress_button.disabled = true
			globals.hide_all_previews()
