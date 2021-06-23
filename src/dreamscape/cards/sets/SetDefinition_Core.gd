# This file contains just card definitions. See also `CardConfig.gd`

extends Reference

const SET = "Core Set"
const CARDS := {
	"Defend": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 5 confidence",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Assault": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Remove 6 cohesion from target Torment.",
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
		"Abilities": "Gain 2 Vulnerable. Your next attack removes double cohesion.",
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
		"Abilities": "Gain 1 Immersion at the start of each turn. Increase all anxiety taken from Torment intents by 2.",
		"Cost": 2,
		"_illustration": "Nobody",
	},
	"Confounding Movements": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 4 defense. Apply weaken to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Noisy Whip": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Remove 5 cohesion from target Torment and apply weaken.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
}
