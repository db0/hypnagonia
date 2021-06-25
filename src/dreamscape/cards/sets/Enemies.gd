class_name EnemyDefinitions
extends Reference

const ENEMIES := {
	"Gaslighter": {
		"Type": "Abuse",
		"Health": 25,
		"Intents": [
			{
				"intent_scripts": ["Attack:5"],
				"reshuffle": false,
			},
			{
				"intent_scripts": ["Attack:4", "Defend:4"],
				"reshuffle": true,
			},
		],
		"_texture_size_x": "64",
		"_texture_size_y": "64",
	},
}
