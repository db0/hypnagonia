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

const RUN_ACCUMULATION_NAMES := {
	"enemy": "frustration",
	"rest": "lethargy",
	"nce": "curiosity",
	"shop": "loneliness",
	"elite": "foreboding",
	"artifact": "desire",
	"boss": "closure",
}

# The strings in brackets, are automatically replaced with icons
# in rich text labels
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
const ARTIFACTS := "Curios"


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
	"drain":  {
		"name": "Apathy",
		"icon": preload("res://assets/icons/shrug.png"),
		"generic_description": "{effect_name}: Delayed Immersion loss.",
		"rich_text_icon": "res://fonts/rich_text_icons/shrug.png",
		"description": "{effect_name} ({effect_icon}): At the start of your turn lose 1 {energy} per stack."\
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
		"description": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is increased by {amount} (1 per stack).\n",
		"upgraded_descriptions": {
			"thick": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is increased by {amount} (1 per stack). Remove all stacks when you reshuffle your deck\n",
		},
	},
	"fortify": {
		"name": "Courage",
		"icon": preload("res://assets/icons/beams-aura.png"),
		"generic_description": "{effect_name}: Prevents concentration from expiring each turn.",
		"rich_text_icon": "res://fonts/rich_text_icons/beams-aura.png",
		"description": "{effect_name} ({effect_icon}): {defence} is not removed at start of turn.\n"\
				+ "Halve (rounded down) the amount of these stacks at the start of the turn."
	},
	"impervious": {
		"name": "Untouchable",
		"icon": preload("res://assets/icons/dodging.png"),
		"generic_description": "{effect_name}: Prevents all anxiety from Torment-induced stress.",
		"rich_text_icon": "res://fonts/rich_text_icons/dodging.png",
		"description": "{effect_name} ({effect_icon}): The next {amount} {opponent_attack} does not increase {health}.\n"\
				+ "Remove all stacks at the start of the turn."
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
		"name": "Envy",
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
		"name": "Grudge",
		"icon": preload("res://assets/icons/light-thorny-triskelion.png"),
		"generic_description": "{effect_name}: Interprets torments as they stress the dreamer.",
		"rich_text_icon": "res://fonts/rich_text_icons/light-thorny-triskelion.png",
		"description": "{effect_name} ({effect_icon}): After an {opponent_attack} on this {entity}, "\
				+ "it automatically {attack} for {amount}.\n"\
				+ "Reduce these stacks by 1 at the start of its turn."\
				+ "\n({defence} can prevent {effect_icon})"
	},
	"armor": {
		"name": "Contentment",
		"icon": preload("res://assets/icons/heart-shield.png"),
		"generic_description": "{effect_name}: Prevents damage and degrades per-hit only.",
		"rich_text_icon": "res://fonts/rich_text_icons/heart-shield.png",
		"description": "{effect_name} ({effect_icon}): Reduce {opponent_attack} on this {entity}, "\
				+ "by {amount}, then reduce these stacks by 1.\n"\
				+ "(This reduction happens before {defence})\n"\
				+ "Reduce these stacks by 1 at the start of the turn.",
	},
	"outrage": {
		"name": "Outrage",
		"description": "{effect_name}: This {entity} has become more powerful in some fashion.",
		"icon": preload("res://assets/icons/enrage.png"),
	},
	"enraged": {
		"name": "Meandering Disquietude",
		"description": "{effect_name}: Every time you play a Control card, this {entity} gains {amount} {strengthen}",
		"icon": preload("res://assets/icons/wavy-itinerary.png"),
	},
	"creative_block": {
		"name": "Creative Block",
		"description": "{effect_name}: {entity} cannot upgrade any more cards this encounter.",
		"icon": preload("res://assets/icons/brain-freeze.png"),
	},
	# Below are unique effects. Typically from concentrations
	"laugh_at_danger":  {
		"name": "Laugh at Danger",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/delighted.png"),
	},
	"nothing_to_fear":  {
		"name": "Nothing to Fear",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/one-eyed.png"),
	},
	"rubber_eggs":  {
		"name": "Rubber Eggs",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/egg-defense.png"),
	},
	"nunclucks":  {
		"name": "Nunclucks",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/nunchaku.png"),
	},
	"unassailable":  {
		"name": "Unassailable",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/psychic-waves.png"),
	},
	"master_of_skies":  {
		"name": "Master of Skies",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/wing-cloak.png"),
	},
	"zen_of_flight":  {
		"name": "Zen of Flight",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/windy-stripes.png"),
	},
	"introspection":  {
		"name": "Introspection",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/inner-self.png"),
	},
	"absurdity_unleashed":  {
		"name": "Absurdity Unleashed",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/absurdity-unleashed.png"),
	},
	"brilliance":  {
		"name": "Brilliance",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/mad-scientist.png"),
	},
	"recall":  {
		"name": "Recall",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/think.png"),
	},
	"eureka":  {
		"name": "Eureka!",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/wisdom.png"),
	},
	"the_happy_place":  {
		"name": "The Happy Place",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/oasis.png"),
	},
	"lash_out":  {
		"name": "Lash-out",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/whiplash.png"),
	},
	"excuses":  {
		"name": "Excuses",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/chained-heart.png"),
	},
	"tolerance":  {
		"name": "Tolerance",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/defibrilate.png"),
	},
	"unconventional":  {
		"name": "Unconventional",
		"icon": preload("res://assets/icons/abstract-104.png"),
		"is_card_reference": true
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
	"insomnia": {
		"name": "Insomnia",
		"icon": preload("res://assets/icons/spikeball.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/spikeball.png",
		"generic_description": "{effect_name} ({effect_icon}): Difficult sleeping leads to card discarding."},
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
	"alpha": {
		"name": "Intuition",
		"icon": preload("res://assets/icons/light-bulb.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/light-bulb.png",
		"generic_description": "[color=purple]{effect_name} ({effect_icon}): This card will always be in the starting hand.[/color]"},
	"omega": {
		"name": "Enigma",
		"icon": preload("res://assets/icons/omega.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/omega.png",
		"generic_description": "[color=purple]{effect_name} ({effect_icon}): This card will always start at the bottom of the deck.[/color]"},
	"exert": {
		"name": "Rationalizations",
		"icon": preload("res://assets/icons/skills.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/skills.png",
		"generic_description": "{effect_name} ({effect_icon}): Increases Anxiety when played."},
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
	"attack_card": {
		"name": "Action",
		"rich_text_color": "red",
	},
	"skill_card": {
		"name": "Control",
		"rich_text_color": "blue",
	},
	"power_card": {
		"name": "Concentration",
		"rich_text_color": "green",
	},
	"condition_card": {
		"name": "Perturbation",
		"rich_text_color": "black",
	},
	"understanding_card": {
		"name": "Understanding",
		"rich_text_color": "purple",
	},
	"discard": {
		"name": "Discard",
		"rich_text_color": "teal",
	},
	"unplayable": {
		"name": "Unplayable",
		"rich_text_color": "black",
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
				# Black colour needs a special font which provides text outline
				if terms_dict[entry].get("rich_text_color") == "black":
					complete_format_dict[entry.to_lower()] =\
							"[font=res://fonts/BlackFont.tres][color={rich_text_color}]{name}[/color][/font]".format(terms_dict[entry])
					complete_format_dict[terms_dict[entry].name.to_lower()] =\
							"[font=res://fonts/BlackFont.tres][color={rich_text_color}]{name}[/color][/font]".format(terms_dict[entry])
				else:
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
