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


const PLAYER_HEALTH := "Anxiety"
const PLAYER_DAMAGE_DONE := "done"
const ENEMY_HEALTH := "Interpretation"
const ENEMY_DAMAGE_DONE := "inflicted"
const PLAYER_ACTIONS := "Cards"
const PLAYER_ACTIONS_VERB := "played"
const ENEMY_ACTIONS := "Intents"
const ENEMY_ACTIONS_VERB := "used"

const PLAYER_TERMS := {
	"enemy": "Torment",
	"entity": "Dreamer",
	"damage": ENEMY_HEALTH,
	"damage_verb": PLAYER_DAMAGE_DONE,
	"defence": "Confidence",
	"energy": "Immersion",
	"health": PLAYER_HEALTH,
	"exhaust": "Forget",
	"damage_taken": PLAYER_HEALTH,
	"damage_taken_verb": ENEMY_DAMAGE_DONE,
	"actions": PLAYER_ACTIONS,
	"actions_verb": PLAYER_ACTIONS_VERB,
	"enemy_actions": ENEMY_ACTIONS,
	"enemy_actions_verb": ENEMY_ACTIONS_VERB,
}

const ENEMY_TERMS := {
	"enemy": "Dreamer",
	"entity": "Torment",
	"damage": PLAYER_HEALTH,
	"damage_verb": ENEMY_DAMAGE_DONE,
	"defence": "Perplexity",
	"energy": "Energy",
	"health": ENEMY_HEALTH,
	"exhaust": "Forget",
	"damage_taken": ENEMY_HEALTH,
	"damage_taken_verb": PLAYER_DAMAGE_DONE,
	"actions": ENEMY_ACTIONS,
	"actions_verb": ENEMY_ACTIONS_VERB,
	"enemy_actions": PLAYER_ACTIONS,
	"enemy_actions_verb": PLAYER_ACTIONS_VERB,
}

const COMMON_FORMATS = {
	PLAYER: PLAYER_TERMS,
	ENEMY: ENEMY_TERMS,
}

# A way to map generic names to thematic names, so that I can perform
# a rename later if needed
const ACTIVE_EFFECTS := {
	"poison": "doubt",
	"empower": "clarity",
	"disempower": "confusion",
	"advantage": "advantage",
	"vulnerable": "shaken",
	"impervious": "untouchable",
	"barricade": "courage",
	# Below are unique effects. Typically from concentrations
	"laugh_at_danger": "laugh at danger",
	"nothing_to_fear": "nothing to fear",
	"rubber_eggs": "rubber eggs",
}
