class_name ShopEncounter
extends NonCombatEncounter

const SHOP_SCENE := preload("res://src/dreamscape/Shop/Shop.tscn")
const journal_description := "I saw a friend mine becking me over. We certainly had much to catch up on."

var current_shop



func _init():
	introduction.setup_with_vars("Shop", journal_description, "A Dear Old Friend")
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.shop
	var shop_images = CFUtils.list_imported_in_directory("res://assets/journal/shop/", true)
	CFUtils.shuffle_array(shop_images, true)
	prepare_journal_art(load(shop_images[0]))

func begin() -> void:
	.begin()
	current_shop = SHOP_SCENE.instance()
	current_shop.connect("ready",self, "on_shop_scene_ready")
	cfc.get_tree().get_root().call_deferred("add_child", current_shop)


func on_shop_back_pressed() -> void:
	end()
	globals.journal.display_nce_rewards('')
	current_shop.queue_free()


func on_shop_scene_ready() -> void:
	current_shop.back_button.connect("pressed", self, "on_shop_back_pressed")
