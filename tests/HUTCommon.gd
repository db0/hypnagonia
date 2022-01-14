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

const BASIC_HAND := [
	"Interpretation",
	"Interpretation",
	"Confidence",
	"Confidence",
	"Nothing to Fear",
]

# The standard interpretation damage
const DMG := 6
const DEF := 5
const X_ATTACK_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": DMG,
				"x_modifier": '0',
				"x_operation": "multiply",
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const REPEAT = 3
const REPEAT_ATTACK_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": DMG,
				"repeat": REPEAT,
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const MULTI_ATTACK_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"needs_subject": true,
				"subject_count": "all",
				"amount": DMG,
				"tags": ["Attack", "Card"],
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const BIG_ATTACK_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": DMG * 5,
				"x_modifier": '0',
				"x_operation": "multiply",
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const BIG_DEFENCE_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": DEF * 5,
			},
		],
	},
}
# For easy access
var dreamer: PlayerEntity
var turn: Turn
var counters: Counters

var test_card_names := []
var cards : Array
### used in spawn_test_torments()
var torments_amount := 1
# Holds the last torment spawned for easy access
var test_torment : EnemyEntity
# Holds all torments spawned
var test_torments := []
var starting_torment_dgm = 30
var test_torment_starting_effects := [
#	{
#		"name": ,
#		"amount": ,
#		"upgrade": ,
#	}
]
### Pathos
var set_repressed_pathos := {}
var set_released_pathos := {}
var card: DreamCard
var test_scripts := {}

func before_each():
	var confirm_return = setup_board()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	yield(yield_for(0.1), YIELD)
	for pathos_name in Terms.RUN_ACCUMULATION_NAMES.values():
		if set_repressed_pathos.has(pathos_name):
			globals.player.pathos.repressed[pathos_name] = set_repressed_pathos[pathos_name]
		else:
			globals.player.pathos.repressed[pathos_name] = 0
	for pathos_name in Terms.RUN_ACCUMULATION_NAMES.values():
		if set_released_pathos.has(pathos_name):
			globals.player.pathos.released[pathos_name] = set_released_pathos[pathos_name]
		else:
			globals.player.pathos.released[pathos_name] = 0
	# We can override flags from test inner classer
	if not globals.test_flags.has("no_refill"):
		globals.test_flags["no_refill"] = true
	board.begin_encounter()
	dreamer = cfc.NMAP.board.dreamer
	turn = cfc.NMAP.board.turn
	counters = cfc.NMAP.board.counters
	cards = setup_test_cards(test_card_names)
	if cards.size() > 0:
		card = cards[0]
		if not test_scripts.empty():
			card.scripts = test_scripts
	while board.counters.counters.immersion == 0:
		yield(yield_to(board.turn, "player_turn_started", 1), YIELD)
#	print_debug(board.counters.counters)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)


func after_each():
	teardown_hypnagonia_testing()
	card = null
	test_scripts.clear()
	test_torments.clear()
	yield(yield_for(0.1), YIELD)


func spawn_test_torments() -> void:
	for _iter in range(torments_amount):
		test_torment = board.spawn_enemy(GUT_TORMENT)
		test_torment.damage = starting_torment_dgm
		test_torments.append(test_torment)
	for effect in test_torment_starting_effects:
		spawn_effect(test_torment, effect.name, effect.amount, effect.get("upgrade", ''))


func spawn_effect(target: CombatEntity, effect_name: String, amount: int, upgrade := '') -> void:
	target.active_effects.mod_effect(effect_name, amount, false, false, ['GUT'], upgrade)


func get_all_card_names() -> Array:
	var all_card_names := []
	for c in cfc.get_tree().get_nodes_in_group("cards"):
		all_card_names.append(c.canonical_name)
	return(all_card_names)

func count_card_names(card_name: String) -> int:
	var count := 0
	for cname in get_all_card_names():
		if cname == card_name:
			count += 1
	return(count)

func get_filtered_cards(property: String, value, comparison := 'eq') -> Array:
	var matching_cards := []
	var cfilter = CardFilter.new(property, value, comparison)
	for c in cfc.get_tree().get_nodes_in_group("cards"):
		if cfilter.check_card(c.properties):
			matching_cards.append(c)
	return(matching_cards)
	

func get_dreamer_effect_script(effect_name: String, amount: int) -> Dictionary:
	var apply_dreamer_effect_script := {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": effect_name,
					"subject": "dreamer",
					"modification": amount,
				}
			],
		},
	}	
	return(apply_dreamer_effect_script)


# Returns the expected amount of damage, after including the torments starting dmgs
func tdamage(damage: int) -> int:
	return(starting_torment_dgm + damage)