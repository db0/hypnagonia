extends "res://tests/UTCommon.gd"

const GUT_TORMENT:= {
	"Name": "GUT",
	"Type": "GUT",
	"Health": 100,
	"Intents": [
		{
			"intent_scripts": ["GUT"],
			"reshuffle": true,
		},
	],
	"_health_variability": 5,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/lantern-flame.png"),
	"_character_art": "GUT",
}


# For easy access
var dreamer: PlayerEntity
var turn: Turn

var test_card_names := []
var cards : Array
# used in spawn_test_torments()
var torments_amount := 1
# Holds the last torment spawned for easy access
var test_torment : EnemyEntity
# Holds all torments spawned
var test_torments := []

func before_each():
	var confirm_return = setup_board()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	yield(yield_for(0.1), YIELD)
	globals.test_flags["no_refill"] = true
	board.begin_encounter()
	dreamer = cfc.NMAP.board.dreamer
	turn = cfc.NMAP.board.turn
	cards = setup_test_cards(test_card_names)
	while board.counters.counters.immersion == 0:
		yield(yield_to(board.turn, "player_turn_started", 1), YIELD)
#	print_debug(board.counters.counters)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)


func after_each():
	teardown_hypnagonia_testing()
	yield(yield_for(0.1), YIELD)


func spawn_test_torments() -> void:
	for _iter in range(torments_amount):
		test_torment = board.spawn_enemy(GUT_TORMENT)
		test_torments.append(test_torment)


func spawn_effect(target: CombatEntity, effect_name: String, amount: int, upgrade := '') -> void:
	target.active_effects.mod_effect(effect_name, amount, false, false, ['GUT'], upgrade)


func get_all_card_names() -> Array:
	var all_card_names := []
	for card in cfc.get_tree().get_nodes_in_group("cards"):
		all_card_names.append(card.canonical_name)
	return(all_card_names)

func count_cards(card_name: String) -> int:
	var count := 0
	for cname in get_all_card_names():
		if cname == card_name:
			count += 1
	return(count)
