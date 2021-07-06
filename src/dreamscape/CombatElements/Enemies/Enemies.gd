class_name EnemyDefinitions
extends Reference

const ENEMIES := {
	"Gaslighter": {
		"Type": "Abuse",
		"Health": 40,
		"Intents": [
			{
				"intent_scripts": ["Stress:5"],
				"reshuffle": false,
			},
			{
				"intent_scripts": ["Stress:4", "Perplex:4"],
				"reshuffle": true,
			},
			{
				"intent_scripts": ["Debuff:2:poison"],
				"reshuffle": false,
			},
		],
		"_health_variability": 3,
		"_texture_size_x": "120",
		"_texture_size_y": "120",
	},
	"Fearmonger": {
		"Type": "Abuse",
		"Health": 50,
		"Intents": [
			{
				"intent_scripts": ["Stress:3","Debuff:1:vulnerable"],
				"reshuffle": false,
			},
			{
				"intent_scripts": ["Stare"],
				"reshuffle": true,
			},
			{
				"intent_scripts": ["Stress:12"],
				"reshuffle": false,
			},
			{
				"intent_scripts": ["Stress:5","Stress:5"],
				"reshuffle": false,
			},
		],
		"_health_variability": 4,
		"_texture_size_x": "120",
		"_texture_size_y": "120",
	},
	"The Laughing One": {
		"Type": "Fear",
		"Health": 25,
		"Intents": [
			{
				"intent_scripts": ["Stress:3","Stress:3","Stress:3"],
				"reshuffle": false,
			},
			{
				"intent_scripts": ["Stress:1","Buff:1:impervious"],
				"reshuffle": false,
			},
			{
				"intent_scripts": ["Stress:5","Debuff:1:poison"],
				"reshuffle": true,
			},
		],
		"_health_variability": 5,
		"_texture_size_x": "120",
		"_texture_size_y": "120",
		"_art_scene": "res://src/dreamscape/CombatElements/Enemies/Art/the_laughing_one.tscn"
	},
}
