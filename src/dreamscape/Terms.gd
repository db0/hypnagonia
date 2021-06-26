class_name Terms
extends Reference

const PLAYER = "dreamer"
const ENEMY = "torment"

# These specify the component groups the player selects to make their deck
# changing the values allows us to change the theme of the game quick
# for example instead of "race", a game might use "tribe".
const CARD_GROUP_TERMS := {
	"class": "class",
	"race": "race",
	"item": "item",
	"life_goal": "life_goal",
}

const PLAYER_TERMS := {
	"entity": "Dreamer",
	"damage": "Interpretation",
	"damage_verb": "done",
	"defence": "Confidence",
	"energy": "Immersion",
	"health": "Anxiety",
}
const ENEMY_TERMS := {
	"entity": "Torment",
	"damage": "Anxiety",
	"damage_verb": "inflicted",
	"defence": "Perplexity",
	"energy": "Energy",
	"health": "Interpretation",
}
const COMMON_FORMATS = {
	PLAYER: PLAYER_TERMS,
	ENEMY: ENEMY_TERMS,
}
