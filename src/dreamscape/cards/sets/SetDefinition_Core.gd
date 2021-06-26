# This file contains just card definitions. See also `CardConfig.gd`

extends Reference

const SET = "Core Set"
const CARDS := {
	"Defend": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 5 confidence.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Assault": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret target Torment for 6.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Fly Upwards": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "You do not take any anxiety from Torment intents this turn.",
		"Cost": 3,
		"_illustration": "Nobody",
	},
	"Dive-in": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 2 Vulnerable. Your next interpretation is doubled.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Safety of Air": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Reduce your anxiety by 4.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Laugh at Danger": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Gain 1 Immersion at the start of each turn."\
			+ " Increase all anxiety taken from Torment intents by 2.",
		"Cost": 2,
		"_illustration": "Nobody",
	},
	"Confounding Movements": {
		"Type": "Control",
		"Tags": ["Confusing"],
		"Abilities": "Gain 4 confidence. Apply 1 Confusion to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Noisy Whip": {
		"Type": "Action",
		"Tags": ["Confusing"],
		"Abilities": "Interpret target Torment for 5 and apply Confusion.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Inner Justice": {
		"Type": "Control",
		"Tags": ["Purpose"],
		"Abilities": "Gain 5 Immersion",
		"Cost": 3,
		"_illustration": "Nobody",
	},
	"Whirlwind": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret target Torment for 3. Repeat 3 times",
		"Cost": 2,
		"_illustration": "Nobody",
	},
	"Overview": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Apply 2 Vulnerable to all Torments",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"War Paint": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "All interpretation is increased by 1 this turn.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Rubber Eggs": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, interpret a random confused Torment for 6.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"The Joke": {
		"Type": "Action",
		"Tags": ["Confusing"],
		"Abilities": "Target a Torment. If it's not confused. Apply 3 Confusion."\
			+ " If it is confused, interpret it for 10.",
		"Cost": 2,
		"_illustration": "Nobody",
	},
	"Nunclucks": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Increase your interpretation by 1, for each stack of Confusion on the Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Gummiraptor": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret Torment for 10."\
			+ "Repeat this if Torments are not going to be inflicting any anxiety this turn",
		"Cost": 2,
		"_illustration": "Nobody",
	},
}
