class_name EnemyDefinitions
extends Reference

const GASLIGHTER:= {
	"Name": "Gaslighter",
	"Type": "Abuse",
	"Health": 50,
	"Intents": [
		{
			"intent_scripts": ["Stress:6"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:6"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Debuff:3:poison"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:10"],
			"reshuffle": true,
		},
	],
	"_health_variability": 3,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/lantern-flame.png"),
	"_character_art": "Lorc",
}
const FEARMONGER:= {
	"Name": "Fearmonger",
	"Type": "Abuse",
	"Health": 70,
	"Intents": [
		{
			"intent_scripts": ["Stress:8","Debuff:2:vulnerable"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:10"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:5","Stress:5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stare","Perplex:4"],
			"reshuffle": true,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_art_scene": "res://src/dreamscape/CombatElements/Enemies/Art/fearmonger.tscn",
	"_character_art": "insomniac_lemon",
}
const THE_LAUGHING_ONE:= {
	"Name": "The Laughing One",
	"Type": "Fear",
	"Health": 20,
	"Intents": [
		{
			"intent_scripts": ["Stress:1","Stress:1","Stress:1"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:6"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:3","Buff:1:strengthen"],
			"reshuffle": true,
		},
	],
	"_health_variability": 5,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_art_scene": "res://src/dreamscape/CombatElements/Enemies/Art/the_laughing_one.tscn",
	"_character_art": "insomniac_lemon",
}
const THE_CRITIC:= {
	"Name": "The Critic",
	"Type": "Fear",
	"Health": 37,
	"Intents": [
		{
			"intent_scripts": ["Stress:6"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Debuff:3:vulnerable"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:9", "Perplex:4"],
			"reshuffle": true,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/tapir.png"),
	"_character_art": "Delapouite",
}
const CLOWN:= {
	"Name": "Clown",
	"Type": "Phobia",
	"Health": 53,
	"Intents": [
		{
			"intent_scripts": ["Stress:7","Debuff:1:disempower"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Debuff:3:disempower"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:12"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:8","Buff:1:fortify"],
			"reshuffle": false,
		},
	],
	"_health_variability": 3,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/clown.png"),
	"_character_art": "Delapouite",
}
const BUTTERFLY:= {
	"Name": "Butterfly",
	"Type": "Phobia",
	"Health": 40,
	"Intents": [
		{
			"intent_scripts": ["Buff:3:strengthen"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:1","Stress:1"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:7"],
			"reshuffle": true,
		}
	],
	"_health_variability": 8,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/butterfly.png"),
	"_character_art": "Lorc",
		}
const UNNAMED_ENEMY_1 := {
	"Name": "Unnamed Enemy 1",
	"Type": "Undefined",
	"Health": 52,
	"Intents": [
		{
			"intent_scripts": ["Debuff:2:disempower"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Buff:3:thorns"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:10"],
			"reshuffle": true,
		},
	],
	"_health_variability": 3,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/lantern-flame.png"),
	"_character_art": "Lorc"
}
const BROKEN_MIRROR:= {
	"Name": "Broken Mirror",
	"Type": "Phobia",
	"Health": 22,
	"Intents": [
		{
			"intent_scripts": ["Debuff:3:burn"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Debuff:2:burn","Perplex:5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:10"],
			"reshuffle": true,
		},
	],
	"_health_variability": 2,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/cracked-glass.png"),
	"_character_art": "Lorc"
}
const PIALEPHANT:= {
	"Name": "Pialephant",
	"Type": "Absurdity",
	"Health": 80,
	"Intents": [
		{
			"intent_scripts": ["Stress:22"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:20"],
			"reshuffle": true,
		},
	],
	"_health_variability": 10,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/elephant.png"),
	"_character_art": "Delapouite"
}
#	"Spider": {
#		"Type": "Phobia",
#		"Health": 1,
#		"Intents": [
#		],
#		"_health_variability": 2,
#		"_texture_size_x": "120",
#		"_texture_size_y": "120",
#		"_character_art": "nobody",
#	},
#	"Mouse": {
#		"Type": "Phobia",
#		"Health": 1,
#		"Intents": [
#		],
#		"_health_variability": 2,
#		"_texture_size_x": "120",
#		"_texture_size_y": "120",
#		"_character_art": "nobody",
#	},
