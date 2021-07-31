class_name EnemyDefinitions
extends Reference

const GASLIGHTER:= {
	"Name": "Gaslighter",
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
	"_texture": preload("res://assets/enemies/lantern-flame.png"),
	"_character_art": "Lorc",
}
const FEARMONGER:= {
	"Name": "Fearmonger",
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
	"_art_scene": "res://src/dreamscape/CombatElements/Enemies/Art/fearmonger.tscn",
	"_character_art": "insomniac_lemon",
}
const THE_LAUGHING_ONE:= {
	"Name": "The Laughing One",
	"Type": "Fear",
	"Health": 25,
	"Intents": [
		{
			"intent_scripts": ["Stress:3","Stress:2","Stress:2"],
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
const UNNAMED_ENEMY_1 := {
	"Name": "Unknown",
	"Type": "Undefined",
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

#const BANKER := {
#const BUTTERFLY := {
