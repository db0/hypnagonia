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
	"_texture_size_x": "90",
	"_texture_size_y": "90",
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
const EXERT_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": 5,
				"tags": ["Exert", "Card"],
			},
		],
	},
}
const HEAL_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": -5,
				"tags": ["Heal", "Card"],
			},
		],
	},
}
const DEBUFF_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"needs_subject": true,
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "target",
				"modification": 1,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const EFFECT_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.empower.name,
				"subject": "dreamer",
				"modification": 1
			},
		],
	},
}
const SPAWN_CARD_SCRIPT := {
	"manual": {
		"hand": [
			{
				"name": "spawn_card_to_container",
				"card_name": "GUT",
				"dest_container": "hand",
				"immediate_placement": true,
				"tags": ["GUT"],
			},
		],
	},
}

func before_each():
	cfc._setup_testing()
	setup_hypnagonia_testing()
	watch_signals(EventBus)
	if not globals.test_flags.has("disable_board_background"):
		globals.test_flags["disable_board_background"] = true
	if not globals.test_flags.has("disable_starting_artifacts"):
		globals.test_flags["disable_starting_artifacts"] = true


func after_each():
	teardown_hypnagonia_testing()
	yield(yield_for(0.1), YIELD)

