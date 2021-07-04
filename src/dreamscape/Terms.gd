class_name Terms
extends Reference

const PLAYER = "dreamer"
const ENEMY = "torment"

# These specify the component groups the player selects to make their deck
# changing the values allows us to change the theme of the game quick
# for example instead of "race", a game might use "tribe".
const CARD_GROUP_TERMS := {
	"class": "Ego",
	"race": "Disposition",
	"item": "Instrument",
	"life_goal": "Injustice",
}


const PLAYER_HEALTH := "Anxiety"
const PLAYER_DAMAGE_DONE := "done"
const ENEMY_HEALTH := "Interpretation"
const ENEMY_DAMAGE_DONE := "inflicted"
const PLAYER_ACTIONS := "Cards"
const PLAYER_ACTIONS_VERB := "played"
const ENEMY_ACTIONS := "Intents"
const ENEMY_ACTIONS_VERB := "used"
const PLAYER_ATTACK := "Interpret"
const ENEMY_ATTACK := "Stress"

const PLAYER_TERMS := {
	"enemy": "Torment",
	"entity": "Dreamer",
	"damage": ENEMY_HEALTH,
	"damage_verb": PLAYER_DAMAGE_DONE,
	"defence": "Confidence",
	"energy": "Immersion",
	"health": PLAYER_HEALTH,
	"exhaust": "Forget",
	"heal": "Relax",
	"attack": PLAYER_ATTACK,
	"opponent_attack": ENEMY_ATTACK,
	"damage_taken": PLAYER_HEALTH,
	"damage_taken_verb": ENEMY_DAMAGE_DONE,
	"actions": PLAYER_ACTIONS,
	"actions_verb": PLAYER_ACTIONS_VERB,
	"opponent_actions": ENEMY_ACTIONS,
	"opponent_actions_verb": ENEMY_ACTIONS_VERB,
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
	"heal": "Reshape",
	"attack": ENEMY_ATTACK,
	"opponent_attack": PLAYER_ATTACK,
	"damage_taken": ENEMY_HEALTH,
	"damage_taken_verb": PLAYER_DAMAGE_DONE,
	"actions": ENEMY_ACTIONS,
	"actions_verb": ENEMY_ACTIONS_VERB,
	"opponent_actions": PLAYER_ACTIONS,
	"opponent_actions_verb": PLAYER_ACTIONS_VERB,
}

const COMMON_FORMATS = {
	PLAYER: PLAYER_TERMS,
	ENEMY: ENEMY_TERMS,
}


# A way to map generic names to thematic names, so that I can perform
# a rename later if needed
const ACTIVE_EFFECTS := {
	"advantage": {
		"name": "Advantage",
		"description": "{effect_name}: The next {amount} actions doing {damage} by this {entity} are doubled."},
	"buffer":  {
		"name": "Fascination",
		"description": "{effect_name}: At the start of your turn gain 1 {energy} per stack."\
				+ "then remove all stacks of {effect_name}."},
	"disempower": {
		"name": "Confusion",
		"description": "{effect_name}: {damage} {damage_verb} by this {entity} is reduced by 30%.\n" \
				+ "Reduce these stacks by 1 at the end of the turn."},
	"empower": {
		"name": "Clarity",
		"description": "{effect_name}: {damage} {damage_verb} by this {entity} is increased by 30%.\n"\
				+ "Reduce these stacks by 1 at the end of the turn."},
	"fortify": {
		"name": "Courage",
		"description": "{effect_name}: {defence} is not removed at start of turn.\n"\
				+ "Reduce these stacks by 1 at the start of the turn."},
	"impervious": {
		"name": "Untouchable",
		"description": "{effect_name}: No {health} is taken this turn.\n" \
				+ "Reduce these stacks by 1 at the start of the turn."},
	"poison": {
		"name": "Doubt",
		"description": "{effect_name}: At the start of this {entity}'s turn it receives"\
				+ " {amount} {health}, then reduce the stacks of {effect_name} by 1."\
				+ "\n({effect_name} bypasses {defence})"},
	"vulnerable": {
		"name": "Shaken",
		"description": "{effect_name}: {defence} added to this {entity} is reduced by 25%.\n" \
				+ "Reduce these stacks by 1 at the end of the turn."},
	"outrage": {
		"name": "Outrage",
		"description": "{effect_name}: This {entity} has become more powerful in some fashion."},
	# Below are unique effects. Typically from concentrations
	"laugh_at_danger":  {
		"name": "Laugh at Danger",
		"description": "{effect_name}: After a {enemy} {opponent_attack} the {entity}, it gains 1 Doubt."},
	"nothing_to_fear":  {
		"name": "Nothing to Fear",
		"description": "{effect_name}: Add {amount} {energy} at the start of the turn.\n"\
				+ "All {health} taken is increased by {double_amount}."},
	"rubber_eggs":  {
		"name": "Rubber Eggs",
		"description": "{effect_name}: At the end of your turn, Interpret a random Confused {enemy} for 6."},
	"nunclucks":  {
		"name": "Nunclucks",
		"description": "{effect_name}: Increase your {damage} by 1, for each stack of Confusion on the {enemy}."},
	"unassailable":  {
		"name": "Unassailable",
		"description": "{effect_name}: Whenever you apply Doubt, gain 1 {defence}."},
	"master_of_skies":  {
		"name": "Master of Skies",
		"description": "{effect_name}: Whenever you Gain Untouchable, gain 1 {energy}."},
	"zen_of_flight":  {
		"name": "Zen of Flight",
		"description": "{effect_name}: At the end of each turn, {heal} 1. If Untouchable, {heal} 1 extra."},
	"absurdity_unleashed":  {
		"name": "Absurdity Unleashed",
		"description": "{effect_name}: Whenever you apply Confusion to a Torment, {attack} it for 4"},
}
