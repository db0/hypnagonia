# This file contains just card definitions. See also `CardConfig.gd`

extends Reference

const SET = "Core Set"
const CARDS := {
	"Defend": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 5 defense",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Assault": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Do 6 Damage to target enemy.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Fly Upwards": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "You do not take any damage from enemy intents this turn",
		"Cost": 3,
		"_illustration": "Nobody",
	},
	"Dive-in": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 2 Vulnerable. Your next attack does double damage.",
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
		"Abilities": "Gain 1 Immersion at the start of each turn. Increase all anxiety taken from enemy intents by 2.",
		"Cost": 2,
		"_illustration": "Nobody",
	},
	"Confounding Movements": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 4 defense. Apply weaken to target enemy.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
	"Noisy Whip": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Do 5 Damage to target enemy and apply weaken.",
		"Cost": 1,
		"_illustration": "Nobody",
	},
}
