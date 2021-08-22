extends PanelContainer

const CARD_SHOP_SCENE = preload("res://src/dreamscape/Shop/ShopCardChoice.tscn")

var card_prices := {
	"Commons": 50,
	"Uncommons": 75,
	"Rares": 100,
}

var uncommon_chance : float = 25.0/100
var rare_chance : float = 5.0/100

var shop_choices := {
	"Commons": [],
	"Uncommons": [],
	"Rares": [],
}
var all_card_pool_choices := []

onready var card_pool_shop := $VBC/CardPoolShop

func _ready() -> void:
	populate_shop_cards()

func populate_shop_cards() -> void:
	cfc.game_rng_seed = CFUtils.generate_random_seed()
	NewGameMenu.randomize_aspect_choices()
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
			var shop_choice_dict = {
				"card_name": card_name,
				"cost": card_prices[rarity],
			}
			all_card_pool_choices.append(shop_choice_dict)
	print_debug(all_card_pool_choices)
	for index in range(all_card_pool_choices.size()):
		var card_name: String = all_card_pool_choices[index].card_name
		var shop_card_object = CARD_SHOP_SCENE.instance()
		card_pool_shop.add_child(shop_card_object)
		shop_card_object.shop_card_cost.text = str(all_card_pool_choices[index].cost)
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

func _on_shop_card_selected(index: int, shop_card_object: CVGridCardObject) -> void:
	print_debug(all_card_pool_choices[index])
