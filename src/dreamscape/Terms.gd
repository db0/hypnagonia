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
		"icon": preload("res://assets/icons/crow-dive.png"),
		"generic_description": "{effect_name}: Doubles damage done by Interpretations.",
		"description": "{effect_name}: The next {amount} actions doing {damage} by this {entity} are doubled."
	},
	"buffer":  {
		"name": "Fascination",
		"icon": preload("res://assets/icons/star-struck.png"),
		"generic_description": "{effect_name}: Provides delayed Immersion.",
		"description": "{effect_name}: At the start of your turn gain 1 {energy} per stack."\
				+ "then remove all stacks of {effect_name}."
	},
	"disempower": {
		"name": "Confusion",
		"icon": preload("res://assets/icons/misdirection.png"),
		"generic_description": "{effect_name}: Reduces anxiety dealt by Torments by percentage.",
		"description": "{effect_name}: {damage} {damage_verb} by this {entity} is reduced by 30%.\n" \
				+ "Reduce these stacks by 1 at the end of the turn."
	},
	"empower": {
		"name": "Clarity",
		"icon": preload("res://assets/icons/extra-lucid.png"),
		"generic_description": "{effect_name}: Increases interpretation dealt by percentage.",
		"description": "{effect_name}: {damage} {damage_verb} by this {entity} is increased by 30%.\n"\
				+ "Reduce these stacks by 1 at the end of the turn."
	},
	"strengthen": {
		"name": "Focus",
		"icon": preload("res://assets/icons/templar-eye.png"),
		"generic_description": "{effect_name}: Increases interpretation dealt by exact amount.",
		"description": "{effect_name}: {damage} {damage_verb} by this {entity} is increased by {amount} (1 per stack).\n"
	},
	"fortify": {
		"name": "Courage",
		"icon": preload("res://assets/icons/beams-aura.png"),
		"generic_description": "{effect_name}: Prevents from concentration from expiring each turn.",
		"description": "{effect_name}: {defence} is not removed at start of turn.\n"\
				+ "Reduce these stacks by 1 at the start of the turn."
	},
	"impervious": {
		"name": "Untouchable",
		"icon": preload("res://assets/icons/dodging.png"),
		"generic_description": "{effect_name}: Prevents all anxiety from Torment-induced stress.",
		"description": "{effect_name}: No {health} is taken this turn from {opponent_attack}.\n" \
				+ "Reduce these stacks by 1 at the start of the turn."
	},
	"poison": {
		"name": "Doubt",
		"icon": preload("res://assets/icons/coma.png"),
		"generic_description": "{effect_name}: Automatically adds interpretation each turn.",
		"description": "{effect_name}: At the start of this {entity}'s turn it receives"\
				+ " {amount} {health} (1 per stack), then reduce the stacks of {effect_name} by 1."\
				+ "\n({effect_name} bypasses {defence})"
	},
	"vulnerable": {
		"name": "Shaken",
		"icon": preload("res://assets/icons/cracked-shield.png"),
		"generic_description": "{effect_name}: Reduces amount of Perplexity on Torments.",
		"description": "{effect_name}: {defence} added to this {entity} is reduced by 25%.\n" \
				+ "Reduce these stacks by 1 at the end of the turn."
	},
	"outrage": {
		"name": "Outrage",
		"description": "{effect_name}: This {entity} has become more powerful in some fashion.",
		"icon": preload("res://assets/icons/enrage.png"),
	},
	# Below are unique effects. Typically from concentrations
	"laugh_at_danger":  {
		"name": "Laugh at Danger",
		"description": "{effect_name}: After a {enemy} {opponent_attack} the {entity}, it gains 1 Doubt.",
		"icon": preload("res://assets/icons/delighted.png"),
	},
	"nothing_to_fear":  {
		"name": "Nothing to Fear",
		"description": "{effect_name}: Add {amount} {energy} at the start of the turn.\n"\
				+ "All {health} taken is increased by {double_amount}.",
		"icon": preload("res://assets/icons/one-eyed.png"),
	},
	"rubber_eggs":  {
		"name": "Rubber Eggs",
		"description": "{effect_name}: At the end of your turn, Interpret a random Confused {enemy} for 6.",
		"icon": preload("res://assets/icons/egg-defense.png"),
	},
	"nunclucks":  {
		"name": "Nunclucks",
		"description": "{effect_name}: Increase your {damage} by 1, for each stack of Confusion on the {enemy}.",
		"icon": preload("res://assets/icons/nunchaku.png"),
	},
	"unassailable":  {
		"name": "Unassailable",
		"description": "{effect_name}: Whenever you apply Doubt, gain 1 {defence}.",
		"icon": preload("res://assets/icons/psychic-waves.png"),
	},
	"master_of_skies":  {
		"name": "Master of Skies",
		"description": "{effect_name}: Whenever you Gain Untouchable, gain 1 {energy}.",
		"icon": preload("res://assets/icons/wing-cloak.png"),
	},
	"zen_of_flight":  {
		"name": "Zen of Flight",
		"description": "{effect_name}: At the end of each turn, {heal} 1. If Untouchable, {heal} 1 extra.",
		"icon": preload("res://assets/icons/windy-stripes.png"),
	},
	"absurdity_unleashed":  {
		"name": "Absurdity Unleashed",
		"description": "{effect_name}: Whenever you apply Confusion to a Torment, {attack} it for 4",
		"icon": preload("res://assets/icons/absurdity-unleashed.png"),
	},
}


# A way to map generic names to thematic names, so that I can perform
# a rename later if needed
const GENERIC_TAGS := {
	"risky": {
		"name": "Risky",
		"icon": preload("res://assets/icons/tightrope.png"),
		"generic_description": "Risky: Increases Anxiety taken by Dreamer."},
	"relax":  {
		"name": "Relax",
		"icon": preload("res://assets/icons/meditation.png"),
		"generic_description": "Relax: Reduces Dreamer anxiety."},
	"purpose": {
		"name": "Purpose",
		"icon": preload("res://assets/icons/concentration-orb.png"),
		"generic_description": "Purpose: Provides immersion."},
	"chain": {
		"name": "Chain",
		"icon": preload("res://assets/icons/crossed-chains.png"),
		"generic_description": "Chain: Repeatable card effects."},
	"swift": {
		"name": "Swift",
		"icon": preload("res://assets/icons/windy-stripes.png"),
		"generic_description": "Swift: Provides card draw."},
	"fleeting": {
		"name": "Fleeting",
		"icon": preload("res://assets/icons/sand-castle.png"),
		"generic_description": "Fleeting: Easily forgotten."},
}

static func get_effect_entry(thematic_effect_name: String) -> Dictionary:
	for effect in ACTIVE_EFFECTS:
		if ACTIVE_EFFECTS[effect].name == thematic_effect_name:
			return(ACTIVE_EFFECTS[effect])
	return({})

static func get_tag_entry(thematic_tag_name: String) -> Dictionary:
	for tag in GENERIC_TAGS:
		if GENERIC_TAGS[tag].name == thematic_tag_name:
			return(GENERIC_TAGS[tag])
	return({})

static func get_term_entry(thematic_tag_name: String, key: String) -> Dictionary:
	var entry := get_effect_entry(thematic_tag_name)
	if not entry.size():
		entry = get_tag_entry(thematic_tag_name).duplicate(true)
	if key == "generic_description":
		entry[key] = entry[key].format({"effect_name": thematic_tag_name})
	return(entry)

static func get_term_value(thematic_tag_name: String, key: String):
	var entry := get_term_entry(thematic_tag_name, key)
	return(entry.get(key))
