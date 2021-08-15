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


const PLAYER_HEALTH := "{anxiety}"
const PLAYER_DAMAGE_DONE := "done"
const ENEMY_HEALTH := "{interpretation}"
const ENEMY_DAMAGE_DONE := "inflicted"
const PLAYER_ACTIONS := "Cards"
const PLAYER_ACTIONS_VERB := "played"
const ENEMY_ACTIONS := "Intents"
const ENEMY_ACTIONS_VERB := "used"
const PLAYER_ATTACK := "{interpretation}"
const ENEMY_ATTACK := "{stress}"


const PLAYER_TERMS := {
	"enemy": "Torment",
	"entity": "Dreamer",
	"damage": ENEMY_HEALTH,
	"damage_verb": PLAYER_DAMAGE_DONE,
	"defence_name": "Confidence",
	"defence": "{confidence}",
	"energy": "{immersion}",
	"health": PLAYER_HEALTH,
	"exhaust": "{forget}",
	"heal": "{relax}",
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
	"defence_name": "Perplexity",
	"defence": "{perplexity}",
	"energy": "{energy}",
	"health": ENEMY_HEALTH,
	"exhaust": "{forget}",
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
		"rich_text_icon": "res://fonts/rich_text_icons/crow-dive.png",
		"description": "{effect_name} ({effect_icon}): The next {amount} "\
				+ "actions doing {damage} by this {entity} are doubled.",
		"upgraded_descriptions": {
			"powerful": "{effect_name}: The next {amount} "\
				+ "actions doing {damage} by this {entity} are tripled.",
		},
	},
	"buffer":  {
		"name": "Fascination",
		"icon": preload("res://assets/icons/star-struck.png"),
		"generic_description": "{effect_name}: Provides delayed Immersion.",
		"rich_text_icon": "res://fonts/rich_text_icons/star-struck.png",
		"description": "{effect_name} ({effect_icon}): At the start of your turn gain 1 {energy} per stack."\
				+ " then remove all stacks of {effect_icon}."
	},
	"disempower": {
		"name": "Confusion",
		"icon": preload("res://assets/icons/misdirection.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/misdirection.png",
		"generic_description": "{effect_name}: Reduces anxiety dealt by Torments by percentage.",
		"description": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is reduced by 30%.\n"\
				+ "Reduce these stacks by 1 at the end of the turn.",
	},
	"empower": {
		"name": "Clarity",
		"icon": preload("res://assets/icons/extra-lucid.png"),
		"generic_description": "{effect_name}: Increases interpretation dealt by percentage.",
		"rich_text_icon": "res://fonts/rich_text_icons/extra-lucid.png",
		"description": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is increased by 30%.\n"\
				+ "Reduce these stacks by 1 at the end of the turn."
	},
	"strengthen": {
		"name": "Focus",
		"icon": preload("res://assets/icons/templar-eye.png"),
		"generic_description": "{effect_name}: Increases interpretation dealt by exact amount.",
		"rich_text_icon": "res://fonts/rich_text_icons/templar-eye.png",
		"description": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is increased by {amount} (1 per stack).\n"
	},
	"fortify": {
		"name": "Courage",
		"icon": preload("res://assets/icons/beams-aura.png"),
		"generic_description": "{effect_name}: Prevents concentration from expiring each turn.",
		"rich_text_icon": "res://fonts/rich_text_icons/beams-aura.png",
		"description": "{effect_name} ({effect_icon}): {defence} is not removed at start of turn.\n"\
				+ "Reduce these stacks by 1 at the start of the turn."
	},
	"impervious": {
		"name": "Untouchable",
		"icon": preload("res://assets/icons/dodging.png"),
		"generic_description": "{effect_name}: Prevents all anxiety from Torment-induced stress.",
		"rich_text_icon": "res://fonts/rich_text_icons/dodging.png",
		"description": "{effect_name} ({effect_icon}): No {health} is taken this turn from {opponent_attack}.\n" \
				+ "Reduce these stacks by 1 at the start of the turn."
	},
	"poison": {
		"name": "Doubt",
		"icon": preload("res://assets/icons/coma.png"),
		"generic_description": "{effect_name}: Automatically adds unpreventable interpretation each turn.",
		"rich_text_icon": "res://fonts/rich_text_icons/coma.png",
		"description": "{effect_name} ({effect_icon}): At the start of this {entity}'s turn it receives"\
				+ " {amount} {health} (1 per stack), then reduce these stacks by 1."\
				+ "\n({effect_icon} bypasses {defence})"
	},
	"burn": {
		"name": "Resentment",
		"icon": preload("res://assets/icons/wrapped-heart.png"),
		"generic_description": "{effect_name}: Automatically adds preventable interpretation each turn.",
		"rich_text_icon": "res://fonts/rich_text_icons/wrapped-heart.png",
		"description": "{effect_name} ({effect_icon}): At the end of this {entity}'s turn it receives"\
				+ " {amount} {health} (1 per stack), then reduce these stacks by 1."\
				+ "\n({defence} can prevent {effect_icon})"
	},
	"vulnerable": {
		"name": "Shaken",
		"icon": preload("res://assets/icons/cracked-shield.png"),
		"generic_description": "{effect_name}: Reduces amount of Perplexity on Torments.",
		"rich_text_icon": "res://fonts/rich_text_icons/cracked-shield.png",
		"description": "{effect_name} ({effect_icon}): {defence} added to this {entity} is reduced by 25%.\n" \
				+ "Reduce these stacks by 1 at the end of the turn."
	},
	"thorns": {
		"name": "Retaliation",
		"icon": preload("res://assets/icons/light-thorny-triskelion.png"),
		"generic_description": "{effect_name}: Interprets torments as they stress the dreamer.",
		"rich_text_icon": "res://fonts/rich_text_icons/light-thorny-triskelion.png",
		"description": "{effect_name} ({effect_icon}): After an {opponent_attack} on this {entity}, "\
				+ "it automatically {attack} for {amount}.\n"\
				+ "Reduce these stacks by 1 at the start of its turn."\
				+ "\n({defence} can prevent {effect_icon})"
	},
	"outrage": {
		"name": "Outrage",
		"description": "{effect_name}: This {entity} has become more powerful in some fashion.",
		"icon": preload("res://assets/icons/enrage.png"),
	},
	"creative_block": {
		"name": "Creative Block",
		"description": "{effect_name}: {entity} cannot upgrade any more cards this encounter.",
		"icon": preload("res://assets/icons/brain-freeze.png"),
	},
	# Below are unique effects. Typically from concentrations
	"laugh_at_danger":  {
		"name": "Laugh at Danger",
		"description": "{effect_name}: After a {enemy} {opponent_attack} the {entity}, it gains 1 {doubt}.",
		"upgraded_descriptions": {
			"roaring": "{effect_name}: After a {enemy} {opponent_attack} the {entity}, it gains 2 {doubt}.",
		},
		"icon": preload("res://assets/icons/delighted.png"),
	},
	"nothing_to_fear":  {
		"name": "Nothing to Fear",
		"description": "{effect_name}: Add {amount} {energy} at the start of the turn.\n"\
				+ "All {health} taken is increased by {double_amount}.",
		"upgraded_descriptions": {
			"absolutely": "{effect_name}: Add {amount} {energy} at the start of the turn.\n"\
					+ "All {health} taken is increased by {amount}.",
		},
		"icon": preload("res://assets/icons/one-eyed.png"),
	},
	"rubber_eggs":  {
		"name": "Rubber Eggs",
		"description": "{effect_name}: At the end of your turn, {attack} a random Confused {enemy} for 6.",
		"upgraded_descriptions": {
			"hard": "{effect_name}: At the end of your turn, {attack} a random Confused {enemy} for 9.",
			"bouncy": "{effect_name}: At the end of your turn, {attack} all Confused {enemy} for 6.",
		},
		"icon": preload("res://assets/icons/egg-defense.png"),
	},
	"nunclucks":  {
		"name": "Nunclucks",
		"description": "{effect_name}: Increase your {damage} by 1, for each stack of {confusion} on the {enemy}.",
		"upgraded_descriptions": {
			"massive": "{effect_name}: Increase your {damage} by 2, for each stack of {confusion} on the {enemy}.",
		},
		"icon": preload("res://assets/icons/nunchaku.png"),
	},
	"unassailable":  {
		"name": "Unassailable",
		"description": "{effect_name}: Whenever you apply {doubt}, gain 2 {defence}.",
		"upgraded_descriptions": {
			"completely": "{effect_name}: Whenever you apply {doubt}, gain 3 {defence}.",
		},
		"icon": preload("res://assets/icons/psychic-waves.png"),
	},
	"master_of_skies":  {
		"name": "Master of Skies",
		"description": "{effect_name}: Whenever you Gain {untouchable}, gain 1 {energy}.",
		"upgraded_descriptions": {
			"glorious": "{effect_name}: Whenever you Gain {untouchable}, gain 2 {energy}.",
		},
		"icon": preload("res://assets/icons/wing-cloak.png"),
	},
	"zen_of_flight":  {
		"name": "Zen of Flight",
		"description": "{effect_name}: At the end of each turn, {heal} 1. If {untouchable}, {heal} 1 extra.",
		"upgraded_descriptions": {
			"masterful": "{effect_name}: At the end of each turn, {heal} 2. If {untouchable}, {heal} 2 extra.",
		},
		"icon": preload("res://assets/icons/windy-stripes.png"),
	},
	"absurdity_unleashed":  {
		"name": "Absurdity Unleashed",
		"description": "{effect_name}: Whenever you apply {confusion} to a Torment, {attack} it for 4",
		"upgraded_descriptions": {
			"total": "{effect_name}: Whenever you apply {confusion} to a Torment, {attack} it for 6",
		},
		"icon": preload("res://assets/icons/absurdity-unleashed.png"),
	},
	"brilliance":  {
		"name": "Brilliance",
		"description": "{effect_name}: Whenever you {shuffle} your deck gain 4 {confidence}",
		"upgraded_descriptions": {
			"blinding": "{effect_name}: Whenever you {shuffle} your deck gain 6 {confidence}",
		},
		"icon": preload("res://assets/icons/mad-scientist.png"),
	},
	"recall":  {
		"name": "Recall",
		"description": "{effect_name}: At the end of your turn, shuffle 1 card from your discard pile into your deck.",
		"upgraded_descriptions": {
			"total": "{effect_name}: At the end of your turn, shuffle 2 cards from your discard pile into your deck.",
		},
		"icon": preload("res://assets/icons/think.png"),
	},
	"eureka":  {
		"name": "Eureka!",
		"description": "{effect_name}: Gain 1 {buffer} every other time you shuffle your deck.",
		"upgraded_descriptions": {
			"inspired": "{effect_name}: Gain 2 {buffer} every other time you shuffle your deck.",
		},
		"icon": preload("res://assets/icons/wisdom.png"),
	},
}


# A way to map generic names to thematic names, so that I can perform
# a rename later if needed
const GENERIC_TAGS := {
	"risky": {
		"name": "Risky",
		"icon": preload("res://assets/icons/tightrope.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/tightrope.png",
		"generic_description": "{effect_name} ({effect_icon}): Increases Anxiety taken by Dreamer."},
	"relax":  {
		"name": "Relax",
		"icon": preload("res://assets/icons/meditation.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/meditation.png",
		"generic_description": "{effect_name} ({effect_icon}): Reduces Dreamer {anxiety}."},
	"purpose": {
		"name": "Purpose",
		"icon": preload("res://assets/icons/concentration-orb.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/concentration-orb.png",
		"generic_description": "{effect_name} ({effect_icon}): Provides immersion."},
	"chain": {
		"name": "Chain",
		"icon": preload("res://assets/icons/crossed-chains.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/crossed-chains.png",
		"generic_description": "{effect_name} ({effect_icon}): Repeatable card effects."},
	"swift": {
		"name": "Swift",
		"icon": preload("res://assets/icons/windy-stripes.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/windy-stripes.png",
		"generic_description": "{effect_name} ({effect_icon}): Provides card draw."},
	"slumber": {
		"name": "Slumber",
		"icon": preload("res://assets/icons/sleepy.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/sleepy.png",
		"generic_description": "{effect_name} ({effect_icon}): A phase of deep sleep which typically causes forgetfulness."},
	"fading": {
		"name": "Fading",
		"icon": preload("res://assets/icons/empty-hourglass.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/empty-hourglass.png",
		"generic_description": "[color=purple]{effect_name} ({effect_icon}): If still in the hand at the end of the turn, it is forgotten.[/color]"},
	"spark": {
		"name": "Spark",
		"icon": preload("res://assets/icons/idea.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/idea.png",
		"generic_description": "{effect_name} ({effect_icon}): Reshuffles the deck."},
	"innate": {
		"name": "Intuition",
		"icon": preload("res://assets/icons/light-bulb.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/light-bulb.png",
		"generic_description": "[color=purple]{effect_name} ({effect_icon}): This card will always be in the starting hand.[/color]"},
}


const GENERIC_CARD_BBCODE := {
	"damage": {
		"name": "Interpretation",
		"rich_text_icon": "res://fonts/rich_text_icons/magnifying-glass.png",
	},
	"defence": {
		"name": "Confidence",
		"rich_text_icon": "res://fonts/rich_text_icons/shield.png",
	},
	"perplexity": {
		"name": "Perplexity",
		"rich_text_icon": "res://fonts/rich_text_icons/shield.png",
	},
	"energy": {
		"name": "Immersion",
		"rich_text_icon": "res://fonts/rich_text_icons/concentration-orb.png",
	},
	"stress": {
		"name": "Stress",
		"rich_text_icon": "res://fonts/rich_text_icons/terror.png",
	},
	"anxiety": {
		"name": "Anxiety",
		"rich_text_icon": "res://fonts/rich_text_icons/heart-beats.png",
	},
	"exhaust": {
		"name": "Forget",
		"rich_text_color": "teal",
	},
	"shuffle": {
		"name": "Shuffle",
		"rich_text_color": "teal",
	},
	"defeated": {
		"name": "Overcome",
		"rich_text_effect": "fade",
	},
	"purge": {
		"name": "Release",
		"rich_text_color": "teal",
	},
	"attack": {
		"name": "Action",
		"rich_text_color": "red",
	},
	"skill": {
		"name": "Control",
		"rich_text_color": "blue",
	},
	"power": {
		"name": "Concentration",
		"rich_text_color": "green",
	},
	"condition": {
		"name": "Perturbation",
		"rich_text_color": "white",
	},
	"understanding": {
		"name": "Understanding",
		"rich_text_color": "purple",
	},
	"discard": {
		"name": "Discard",
		"rich_text_color": "teal",
	},
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


static func get_term_entry(thematic_tag_name: String, key: String, no_icon := false) -> Dictionary:
	var entry := get_effect_entry(thematic_tag_name)
	if not entry.size():
		entry = get_tag_entry(thematic_tag_name).duplicate(true)
	if key == "generic_description":
		var generic_format = {"effect_name": thematic_tag_name}
		if entry.has("rich_text_icon"):
			# I use the no_icon boolean, when the player is explicitly mousing over the icon anyway
			# This way I avoid having to add another RTL
			if not no_icon:
				generic_format["effect_icon"] = "[img=18x18]" + entry["rich_text_icon"] + "[/img]"
			else:
				generic_format["effect_icon"] = ''
		entry[key] = entry[key].format(generic_format)
	return(entry)


static func get_term_value(thematic_tag_name: String, key: String, no_icon := false):
	var entry := get_term_entry(thematic_tag_name, key, no_icon)
	return(entry.get(key))


static func get_bbcode_formats(preset_icon_size = null) -> Dictionary:
	var complete_format_dict := {}
	var icon_size := {}
	if typeof(preset_icon_size) == TYPE_INT:
		icon_size = {"icon_size": str(preset_icon_size) + "x" + str(preset_icon_size)}
	for terms_dict in [ACTIVE_EFFECTS, GENERIC_TAGS, GENERIC_CARD_BBCODE]:
		for entry in terms_dict:
			if terms_dict[entry].has("rich_text_icon"):
				complete_format_dict[entry.to_lower()] =\
						"[img={icon_size}]{rich_text_icon}[/img]".format(terms_dict[entry]).format(icon_size)
				complete_format_dict[terms_dict[entry].name.to_lower()] =\
						"[img={icon_size}]{rich_text_icon}[/img]".format(terms_dict[entry]).format(icon_size)
			elif terms_dict[entry].has("rich_text_color"):
				complete_format_dict[entry.to_lower()] =\
						"[color={rich_text_color}]{name}[/color]".format(terms_dict[entry])
				complete_format_dict[terms_dict[entry].name.to_lower()] =\
						"[color={rich_text_color}]{name}[/color]".format(terms_dict[entry])
			elif terms_dict[entry].has("rich_text_effect"):
				match terms_dict[entry]["rich_text_effect"]:
					"fade":
						complete_format_dict[entry.to_lower()] =\
								"[fade start=2 length=7]{name}[/fade]".format(terms_dict[entry])
						complete_format_dict[terms_dict[entry].name.to_lower()] =\
								"[fade start=2 length=7]{name}[/fade]".format(terms_dict[entry])
	return(complete_format_dict)
