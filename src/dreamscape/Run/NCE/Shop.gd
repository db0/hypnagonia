class_name ShopEncounter
extends NonCombatEncounter

const SHOP_SCENE := preload("res://src/dreamscape/Shop/Shop.tscn")
var current_shop



func _init():
	description = "I saw a friend mine becking me over. We certainly had much to catch up on."
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.shop
	var rng = CFUtils.randi_range(1,3)
	prepare_journal_art(load("res://assets/journal/shop/shop%s.jpeg" % [rng]))

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
