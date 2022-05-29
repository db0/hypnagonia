class_name Terms
extends Reference

enum SELF_DECREASE {
	FALSE
	TURN_START
	TURN_END
}

enum DECREASE_TYPE {
	REDUCE
	HALVE
	ZERO
}

enum ALTERANT_PRIORITY {
	ADD
	MULTIPLY
	SET
}


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

const PATHOS_DESCRIPTIONS := {
	RUN_ACCUMULATION_NAMES.enemy: {
		"repressed": "Increases the chance that Torments will appear as encounters. "\
			+ "If the repressed pathos gets too high, it also makes their ordeals harder",
		"released": "Fill the bar to receive a pathos mastery to use in the shop."
	},
	RUN_ACCUMULATION_NAMES.nce: {
		"repressed": "Increases the chance that Non-Ordeal encounters will appear. "\
			+ "If the repressed pathos gets too high, more risky  encounters will be chosen",
		"released": "Fill the bar to receive a pathos mastery to use in the shop."
	},
	RUN_ACCUMULATION_NAMES.shop: {
		"repressed": "Increases the chance that the Shop encounter will appear",
		"released": "Fill the bar to receive a pathos mastery to use in the shop."
	},
	RUN_ACCUMULATION_NAMES.elite: {
		"repressed": "Increases the chance that Elite Torment will appear as encounters. "\
			+ "If the repressed pathos gets too high, it also makes their ordeals harder",
		"released": "Fill the bar to receive 2 pathos masteries to use in the shop."
	},
	RUN_ACCUMULATION_NAMES.artifact: {
		"repressed": "Increases the chance that Curios will appear as encounters. "\
			+ "If the repressed pathos gets too high, there is a better chance for higher rarity curio",
		"released": "Fill the bar to receive a pathos mastery to use in the shop."
	},
	RUN_ACCUMULATION_NAMES.rest: {
		"repressed": "Increases the chance that Rest encounters will appear.",
		"released": "Fill the bar to receive a pathos mastery to use in the shop."
	},
	RUN_ACCUMULATION_NAMES.boss: {
		"repressed": "When this is repressed enough, you will encounter this Act's adversary.",
		"released": "Fill the bar to receive 5 pathos masteries to use in the shop."
	},
}

const RUN_ACCUMULATION_TYPES := {
	RUN_ACCUMULATION_NAMES.enemy: "Normal Torment",
	RUN_ACCUMULATION_NAMES.rest: "Rest",
	RUN_ACCUMULATION_NAMES.nce: "Non-Ordeal Encounter",
	RUN_ACCUMULATION_NAMES.shop: "Shop",
	RUN_ACCUMULATION_NAMES.elite: "Elite Torment",
	RUN_ACCUMULATION_NAMES.artifact: "Curio",
	RUN_ACCUMULATION_NAMES.boss: "Boss",
}
# The strings in brackets, are automatically replaced with icons
# in rich text labels
const PLAYER_HEALTH := "{anxiety}"
const PLAYER_DAMAGE_DONE := "done"
const ENEMY_HEALTH := "{comprehension}"
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
		"type": "Buff",
		"self_decreasing": SELF_DECREASE.FALSE,
		"icon": preload("res://assets/icons/crow-dive.png"),
		"generic_description": "{effect_name}: Doubles {interpretation} done.",
		"rich_text_icon": "res://fonts/rich_text_icons/crow-dive.png",
		"description": "{effect_name} ({effect_icon}): The next {amount} "\
				+ "actions doing {attack} by this {entity} are doubled.",
		"upgraded_descriptions": {
			"powerful": "{effect_name}: The next {amount} "\
				+ "actions doing {attack} by this {entity} are tripled.",
		},
		"linked_terms": [
			"{damage}",
		],
	},
	"buffer":  {
		"name": "Fascination",
		"type": "Buff",
		# This effect only works when assigned to the Dreamer
		"is_dreamer_only": true,
		# This is handled in the code to avoid reducing before the effect fires
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.ZERO,
		"icon": preload("res://assets/icons/star-struck.png"),
		"generic_description": "{effect_name}: Provides delayed {immersion}.",
		"rich_text_icon": "res://fonts/rich_text_icons/star-struck.png",
		"description": "{effect_name} ({effect_icon}): At the start of your turn gain 1 {energy} per stack."\
				+ " then remove all stacks of {effect_icon}.",
		"linked_terms": [
			"energy",
		],
	},
	"drain":  {
		"name": "Disinterest",
		"type": "Debuff",
		# This effect only works when assigned to the Dreamer
		"is_dreamer_only": true,
		# This is handled in the code to avoid reducing before the effect fires
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.ZERO,
		"icon": preload("res://assets/icons/shrug.png"),
		"generic_description": "{effect_name}: Delayed {immersion} loss.",
		"rich_text_icon": "res://fonts/rich_text_icons/shrug.png",
		"description": "{effect_name} ({effect_icon}): At the start of your turn lose 1 {energy} per stack."\
				+ " then remove all stacks of {effect_icon}.",
		"linked_terms": [
			"energy",
		],
	},
	"disempower": {
		"name": "Confusion",
		"type": "Debuff",
		"self_decreasing": SELF_DECREASE.TURN_END,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.MULTIPLY,
		"icon": preload("res://assets/icons/misdirection.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/misdirection.png",
		"generic_description": "{effect_name}: Reduces {stress} dealt by Torments by percentage.",
		"description": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is reduced by 25%.\n"\
				+ "Reduce these stacks by 1 at the end of the turn.",
		"linked_terms": [
			"{attack}",
		],
	},
	"empower": {
		"name": "Clarity",
		"type": "Buff",
		"self_decreasing": SELF_DECREASE.TURN_END,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.MULTIPLY,
		"icon": preload("res://assets/icons/extra-lucid.png"),
		"generic_description": "{effect_name}: Increases interpretation dealt by percentage.",
		"rich_text_icon": "res://fonts/rich_text_icons/extra-lucid.png",
		"description": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is increased by 25%.\n"\
				+ "Reduce these stacks by 1 at the end of the turn.",
		"linked_terms": [
			"{attack}",
		],
	},
	"strengthen": {
		"name": "Focus",
		"type": "Versatile",
		"self_decreasing": SELF_DECREASE.FALSE,
		"icon": preload("res://assets/icons/templar-eye.png"),
		"generic_description": "{effect_name}: Adjusts interpretation dealt by exact amount.",
		"rich_text_icon": "res://fonts/rich_text_icons/templar-eye.png",
		"description": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is adjusted by {amount} (1 per stack).\n",
		"upgraded_descriptions": {
			"thick": "{effect_name} ({effect_icon}): {attack} {damage_verb} by this {entity} is adjusted by {amount} (1 per stack). Remove all stacks when you reshuffle your deck\n",
		},
		"linked_terms": [
			"{attack}",
		],
		"can_go_negative": true,
	},
	"quicken": {
		"name": "Solid",
		"type": "Versatile",
		"self_decreasing": SELF_DECREASE.FALSE,
		"icon": preload("res://assets/icons/white-tower.png"),
		"generic_description": "{effect_name}: Adjusts confidence gained by exact amount.",
		"rich_text_icon": "res://fonts/rich_text_icons/white-tower.png",
		"description": "{effect_name} ({effect_icon}): {defence} gained by this {entity} is adjusted by {amount} (1 per stack).\n",
		"linked_terms": [
			"{defence}",
		],
		"can_go_negative": true,
	},
	"fortify": {
		"name": "Courage",
		"type": "Buff",
		# This is handled in the code to avoid reducing before the effect fires
		"self_decreasing": SELF_DECREASE.FALSE,
		"noscript": true,
		"icon": preload("res://assets/icons/beams-aura.png"),
		"generic_description": "{effect_name}: Prevents concentration from expiring each turn.",
		"rich_text_icon": "res://fonts/rich_text_icons/beams-aura.png",
		"description": "{effect_name} ({effect_icon}): {defence} is not removed at start of turn.\n"\
				+ "Halve (rounded down) the amount of these stacks at the start of the turn.",
		"difficulty_adjusted_description": {
			"permanent_defence": {
				true: "{effect_name} ({effect_icon}): {defence} is increased 10% for each stack at the start of turn.\n"\
				+ "Halve (rounded down) the amount of these stacks at the start of the turn.",
			}
		},
		"linked_terms": [
			"{defence}",
		],
	},
	"impervious": {
		"name": "Untouchable",
		"type": "Buff",
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.HALVE,
		"alterant_priority": ALTERANT_PRIORITY.MULTIPLY,
		"icon": preload("res://assets/icons/dodging.png"),
		"generic_description": "{effect_name}: Each stack reduces {opponent_attack} by 25% to a maximum of 75%",
		"rich_text_icon": "res://fonts/rich_text_icons/dodging.png",
		"description": "{effect_name} ({effect_icon}): The next {opponent_attack} is reduced by {imp_mark_pct}.\n"\
				+ "Halve (rounded down) the amount of these stacks at the start of the turn.\n"\
				+ "(Each stack increases reduction by 25% to a max of 75%. Each {opponent_attack} removes one stack. )",
		"linked_terms": [
			"{opponent_attack}",
		],
	},
	"marked": {
		"name": "Prominent",
		"type": "Debuff",
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.HALVE,
		"alterant_priority": ALTERANT_PRIORITY.MULTIPLY,
		"icon": preload("res://assets/icons/light-projector.png"),
		"generic_description": "{effect_name}: Each stack increases {attack} by 25% on this {entity} to a maximum of 75%",
		"rich_text_icon": "res://fonts/rich_text_icons/light-projector.png",
		"description": "{effect_name} ({effect_icon}): The next {opponent_attack} on this {entity} is increased by {imp_mark_pct}.\n"\
				+ "Halve (rounded down) the amount of these stacks at the start of the turn.\n"\
				+ "(Each stack increases {opponent_attack} by 25% to a max of 75%. Each {opponent_attack} removes one stack.)",
		"linked_terms": [
			"{opponent_attack}",
		],
	},
	"poison": {
		"name": "Doubt",
		"type": "Debuff",
		# This is handled in the code to avoid reducing before the effect fires
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"icon": preload("res://assets/icons/coma.png"),
		"generic_description": "{effect_name}: Automatically adds unpreventable interpretation each turn.",
		"rich_text_icon": "res://fonts/rich_text_icons/coma.png",
		"description": "{effect_name} ({effect_icon}): At the start of this {entity}'s turn it takes"\
				+ " {amount} {health} (1 per stack), then reduce these stacks by 1. "\
				+ "({effect_icon} bypasses {defence})",
		"extra_dreamer_description": "\nOn the dreamer, {effect_icon} leaves them at 1 {anxiety} "\
				+ "but starts burning released pathos",
		"linked_terms": [
			"{health}",
			"{defence}",
		],
	},
	"burn": {
		"name": "Envy",
		"type": "Debuff",
		# This is handled in the code to avoid reducing before the effect fires
		"self_decreasing": SELF_DECREASE.TURN_END,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"icon": preload("res://assets/icons/wrapped-heart.png"),
		"generic_description": "{effect_name}: Automatically adds preventable interpretation each turn.",
		"rich_text_icon": "res://fonts/rich_text_icons/wrapped-heart.png",
		"description": "{effect_name} ({effect_icon}): At the end of this {entity}'s turn it receives"\
				+ " {amount} {health} (1 per stack), then reduce these stacks by 1."\
				+ "\n({defence} can prevent {effect_icon})",
		"linked_terms": [
			"{health}",
			"{defence}",
		],
	},
	"vulnerable": {
		"name": "Shaken",
		"type": "Debuff",
		"self_decreasing": SELF_DECREASE.TURN_END,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.MULTIPLY,
		"icon": preload("res://assets/icons/cracked-shield.png"),
		"generic_description": "{effect_name}: Reduces amount of Perplexity on Torments.",
		"rich_text_icon": "res://fonts/rich_text_icons/cracked-shield.png",
		"description": "{effect_name} ({effect_icon}): {defence} added to this {entity} is reduced by 25%.\n" \
				+ "Reduce these stacks by 1 at the end of the turn.",
		"linked_terms": [
			"{defence}",
		],
	},
	"thorns": {
		"name": "Grudge",
		"type": "Buff",
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"icon": preload("res://assets/icons/light-thorny-triskelion.png"),
		"generic_description": "{effect_name}: Interprets torments as they stress the dreamer.",
		"rich_text_icon": "res://fonts/rich_text_icons/light-thorny-triskelion.png",
		"description": "{effect_name} ({effect_icon}): After an {opponent_attack} on this {entity}, "\
				+ "it automatically {attack} for {amount}.\n"\
				+ "Reduce these stacks by 1 at the start of the turn."\
				+ "\n({defence} can prevent {effect_icon})",
		"linked_terms": [
			"{opponent_attack}",
			"{attack}",
			"{defence}",
		],
	},
	"armor": {
		"name": "Contentment",
		"type": "Buff",
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.ADD,
		"icon": preload("res://assets/icons/heart-shield.png"),
		"generic_description": "{effect_name}: Prevents stress and degrades per-hit.",
		"rich_text_icon": "res://fonts/rich_text_icons/heart-shield.png",
		"description": "{effect_name} ({effect_icon}): Reduce {opponent_attack} on this {entity}, "\
				+ "by {amount}, then reduce these stacks by 1.\n"\
				+ "(This reduction happens before {defence})\n"\
				+ "Reduce these stacks by 1 at the start of the turn.",
		"linked_terms": [
			"{opponent_attack}",
			"{defence}",
		],
	},
	"delighted": {
		"name": "Delighted",
		"type": "Debuff",
		"self_decreasing": SELF_DECREASE.TURN_START,
		"decrease_type": DECREASE_TYPE.ZERO,
		"noscript": true,
		"is_dreamer_only": true,
		"icon": preload("res://assets/icons/smitten.png"),
		"generic_description": "{effect_name}: Prevents interpretation.",
		"rich_text_icon": "res://assets/icons/smitten.png",
		"description": "{effect_name} ({effect_icon}): Dreamer cannot play {action} cards.\n"\
				+ "Remove these stacks at the start of the turn.",
	},
	"protection": {
		"name": "Inscrutable",
		"type": "Buff",
		"self_decreasing": SELF_DECREASE.FALSE,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.SET,
		"icon": preload("res://assets/icons/abstract-025.png"),
		"generic_description": "{effect_name}: Negates debuffs.",
		"rich_text_icon": "res://fonts/rich_text_icons/abstract-025.png",
		"description": "{effect_name} ({effect_icon}): Negates the next {amount} debuffs on this {entity}.",
	},
	"doom": {
		"name": "Evanescent",
		"type": "Special",
		"self_decreasing": SELF_DECREASE.TURN_END,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.ADD,
		"icon": preload("res://assets/icons/dead-eye.png"),
		"generic_description": "{effect_name}: Automatically overcomes when it runs out.",
		"rich_text_icon": "res://fonts/rich_text_icons/dead-eye.png",
		"description": "{effect_name} ({effect_icon}): This torment will be automatically overcome after {amount} turns  (1 per stack). "\
				+ "A Torment overcome in this way, will not provide an {understanding} card as a draft reward.",
		"linked_terms": [
			"overcome",
		],
	},
	# TODO Idea
	"boon": {
		"name": "Boon",
		"type": "Special",
		"self_decreasing": SELF_DECREASE.TURN_END,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.ADD,
		"icon": preload("res://assets/icons/dead-eye.png"),
		"generic_description": "{effect_name}: At the start of your turn, this provides a random benefit based on how many you have.",
		"rich_text_icon": "res://fonts/rich_text_icons/dead-eye.png",
		"description": "{effect_name} ({effect_icon}): TODO",
	},
	"outrage": {
		"name": "Outrage",
		"type": "Special",
		"description": "{effect_name}: This {entity} has become more powerful in some fashion.",
		"noscript": true,
		"icon": preload("res://assets/icons/enrage.png"),
	},
	"rebalance": {
		"name": "Rebalance",
		"type": "Special",
		"description": "{effect_name}: This {entity} has been rebalanced.",
		"noscript": true,
		"is_invisible": true,
		"icon": preload("res://assets/icons/triple-yin.png"),
	},
	"creative_block": {
		"name": "Creative Block",
		"type": "Special",
		"description": "{effect_name}: {entity} cannot upgrade any more cards this encounter.",
		"noscript": true,
		"icon": preload("res://assets/icons/brain-freeze.png"),
	},
	"effect_immunity": {
		"name": "Immunity",
		"type": "Special",
		"description": "{effect_name}: {entity} is not affected by {upgrade}.",
		"icon": preload("res://assets/icons/antibody.png"),
	},
	"effect_resistance": {
		"name": "Resistance",
		"type": "Special",
		"description": "{effect_name}: {entity} receives only half the amount of {upgrade}.",
		"icon": preload("res://assets/icons/armor-upgrade.png"),
	},
	"effect_vulnerability": {
		"name": "Vulnerability",
		"type": "Special",
		"description": "{effect_name}: {entity} receives double the amount of {upgrade}.",
		"icon": preload("res://assets/icons/armor-downgrade.png"),
	},
	# Below are unique effects. Typically from concentrations
	"laugh_at_danger":  {
		"name": "Laugh at Danger",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/delighted.png"),
		"linked_terms": [
			"poison",
			"stress",
		],
	},
	"nothing_to_fear":  {
		"name": "Nothing to Fear",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/one-eyed.png"),
		"linked_terms": [
			"{energy}",
			"stress",
		],
	},
	"rubber_eggs":  {
		"name": "Rubber Eggs",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/egg-defense.png"),
		"linked_terms": [
			"disempower",
			"damage",
		],
	},
	"nunclucks":  {
		"name": "Nunclucks",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/nunchaku.png"),
		"linked_terms": [
			"disempower",
			"damage",
		],
	},
	"unassailable":  {
		"name": "Unassailable",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/psychic-waves.png"),
		"linked_terms": [
			"poison",
			"defence",
		],
	},
	"master_of_skies":  {
		"name": "Master of Skies",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/wing-cloak.png"),
		"linked_terms": [
			"impervious",
			"buffer",
		],
	},
	"zen_of_flight":  {
		"name": "Zen of Flight",
		"type": "Concentration",
		"is_card_reference": true,
		"format_key_to_replace_with_amount": "turns_amount",
		"icon": preload("res://assets/icons/windy-stripes.png"),
		"linked_terms": [
			"impervious",
			"relax",
		],
	},
	"introspection":  {
		"name": "Introspection",
		"type": "Concentration",
		"is_card_reference": true,
		"format_key_to_replace_with_amount": "turns_amount",
		"icon": preload("res://assets/icons/inner-self.png"),
		"linked_terms": [
			"relax",
		],
	},
	"absurdity_unleashed":  {
		"name": "Absurdity Unleashed",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/absurdity-unleashed.png"),
		"linked_terms": [
			"disempower",
			"damage",
		],
	},
	"brilliance":  {
		"name": "Brilliance",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/mad-scientist.png"),
		"linked_terms": [
			"defence",
		],
	},
	"recall":  {
		"name": "Recall",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/think.png"),
	},
	"eureka":  {
		"name": "Eureka!",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/wisdom.png"),
		"linked_terms": [
			"buffer",
		],
	},
	"the_happy_place":  {
		"name": "The Happy Place",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/oasis.png"),
		"linked_terms": [
			"player_health",
			"armor",
		],
	},
	"lash_out":  {
		"name": "Lash-out",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/whiplash.png"),
		"linked_terms": [
			"damage",
			"player_health",
		],
	},
	"excuses":  {
		"name": "Excuses",
		"type": "Concentration",
		"is_card_reference": true,
		"alterant_priority": ALTERANT_PRIORITY.SET,
		"icon": preload("res://assets/icons/chained-heart.png"),
		"linked_terms": [
			"player_health",
		],
	},
	"tolerance":  {
		"name": "Tolerance",
		"type": "Concentration",
		"is_card_reference": true,
		"icon": preload("res://assets/icons/defibrilate.png"),
		"linked_terms": [
			"player_health",
		],
	},
	"unconventional":  {
		"name": "Unconventional",
		"type": "Concentration",
		"icon": preload("res://assets/icons/abstract-104.png"),
		"is_card_reference": true
	},
	"sneaky_beaky":  {
		"name": "Sneaky-Beaky",
		"type": "Concentration",
		"icon": preload("res://assets/icons/kenku-head.png"),
		"is_card_reference": true,
		"linked_terms": [
			"damage",
		],
	},
	"tenacity":  {
		"name": "Tenacity",
		"type": "Concentration",
		"icon": preload("res://assets/icons/eyepatch.png"),
		"is_card_reference": true,
		"linked_terms": [
			"defence",
		],
	},
	"panicked_takeoff":  {
		"name": "Panicked Takeoff",
		"type": "Concentration",
		"icon": preload("res://assets/icons/flying-trout.png"),
		"is_card_reference": true,
		"linked_terms": [
			"player_health",
			"impervious",
		],
	},
	"spare_lens":  {
		"name": "Spare Lens",
		"type": "Concentration",
		"icon": preload("res://assets/icons/microscope-lens.png"),
		"is_card_reference": true,
	},
	"heat_venting":  {
		"name": "Heat Venting",
		"type": "Concentration",
		"icon": preload("res://assets/icons/heat-haze.png"),
		"is_card_reference": true,
		"linked_terms": [
			"defence",
		],
	},
	"streamlining":  {
		"name": "Streamlining",
		"type": "Concentration",
		"icon": preload("res://assets/icons/abstract-070.png"),
		"is_card_reference": true,
	},
	"focus_calibration":  {
		"name": "Focus Calibration",
		"type": "Concentration",
		"icon": preload("res://assets/icons/double-diaphragm.png"),
		"is_card_reference": true,
		"linked_terms": [
			"energy",
			"forget",
		],
	},
	"vestige_of_warmth":  {
		"name": "Vestige of Warmth",
		"type": "Concentration",
		"icon": preload("res://assets/icons/incubator.png"),
		"is_card_reference": true,
		"linked_terms": [
			"defence",
		],
	},
	"nothing_forgotten":  {
		"name": "Nothing Forgotten",
		"type": "Concentration",
		"icon": preload("res://assets/icons/elephant.png"),
		"is_card_reference": true,
		"linked_terms": [
			"frozen",
		],
	},
	"note_taking":  {
		"name": "Note-Taking",
		"type": "Concentration",
		"icon": preload("res://assets/icons/notebook.png"),
		"is_card_reference": true,
		"linked_terms": [
			"thorns",
		],
	},
	"schadenfreude":  {
		"name": "Schadenfreude",
		"type": "Concentration",
		"icon": preload("res://assets/icons/imp-laugh.png"),
		"is_card_reference": true,
		"linked_terms": [
			"armor",
			"damage",
		],
	},
	# These effects are usually starting on top of special enemies
	# but might also be given to the player as Understanding concentrations
	"enraged": {
		"name": "Meandering Disquietude",
		"type": "Special",
		"description": "{effect_name}: Every time you play a Control card, this {entity} gains {amount} {strengthen}",
		"icon": preload("res://assets/icons/wavy-itinerary.png"),
	},
	"stuffed_toy": {
		"name": "Plushyness",
		"type": "Concentration",
		"icon": preload("res://assets/icons/growth.png"),
		"description": "{effect_name}: After every {damage_taken} {damage_taken_verb} on this {entity} through {opponent_attack}, "\
				+ "it gains {amount} {defence}. The amount gained increases by 1 after each {damage_taken}.\n"\
				+ "This resets to 0 at the start of the turn\n",
		"linked_terms": [
			"opponent_attack",
			"defence",
		],
	},
	"mouse": {
		"name": "Mouse Debate Skills",
		"type": "Concentration",
		"icon": preload("res://assets/icons/seated-mouse.png"),
		"description": "{effect_name}: Gain 1 {energy} per turn. "\
				+ "Lose 2 {focus} every time you shuffle your deck",
		"blocked_by_protection": true,
		"linked_terms": [
			"energy",
			"strengthen",
		],
	},
	"the_exam": {
		"name": "Exam Time",
		"type": "Concentration",
		"icon": preload("res://assets/icons/pencil.png"),
		"description": "{effect_name}: Every time you {forget} a card, take {amount} {player_health}.",
		"blocked_by_protection": true,
		"linked_terms": [
			"forget",
			"player_health",
		],
	},
	"the_victim": {
		"name": "Discern",
		"type": "Concentration",
		"icon": preload("res://assets/icons/think.png"),
		"description": "{effect_name}: The first time each turn this {entity} takes "\
				+ "9 or more {damage} from one source, reduce its {focus} by {amount} for this turn.",
		"blocked_by_protection": true,
		"linked_terms": [
			"damage",
			"strengthen",
		],
	},
	# Effect doesn't do anything. The scripting happens in the boss
	# Assigning this to any torment won't help
	"surreal_boss": {
		"name": "Incomprehensibility",
		"type": "Special",
		"icon": preload("res://assets/icons/abstract-053.png"),
		"noscript": true,
		"description": "{effect_name}: Whenever this {entity}'s {stress} does not increase anxiety it gains 1 {strengthen}.\n"\
				+ "The first time each turn this {entity}'s is {opponent_attack} for 12+ from one source, it gains 1 {strengthen}.\n"\
				+ "When this {entity} has 7+ focus, it performs a powerful {stress}, then resets its {strengthen} to 0.",
		"linked_terms": [
			"attack",
			"strengthen",
			"opponent_attack",
		],
	},
	"self_cleaning": {
		"name": "Self Cleaning",
		"type": "Special",
		"icon": preload("res://assets/icons/soap.png"),
		"description": "{effect_name}: At the end of each turn, reduce the highest debuff on this {entity} by {amount}.",
	},
	"jumbletron": {
		"name": "The Rumble-Jumble",
		"type": "Special",
		"icon": preload("res://assets/icons/abstract-024.png"),
		"description": "{effect_name}: Any time an {understanding} card is played, it is permanently scarred.",
		"linked_terms": [
			"scar",
		],
	},
	# If I put just 'void', it breaks Godot...
	"void": {
		"name": "The edge of nothingness",
		"type": "Special",
		"icon": preload("res://assets/icons/circle.png"),
		"description": "{effect_name}: Any time an {understanding} card is played, add {amount} temporary Lacuna {perturbation}s to the discard.",
	},
	# This should only appear with an upgrade
	"life_path": {
		"name": "Life Path",
		"type": "Special",
		"icon": preload("res://assets/icons/crossroad.png"),
		"description": "{effect_name}: Any time an {upgrade} card is played, something bad happens.",
	},
	"coat_of_cringe": {
		"name": "Coat of Cringe",
		"type": "Special",
		"icon": preload("res://assets/icons/pirate-coat.png"),
		"description": "{effect_name}: After {opponent_attack} on this torment. add 1 Cringeworthy Memory to your deck.",
		"linked_terms": [
			"opponent_attack",
		],
	},
	"disruption": {
		"name": "Torpor",
		"type": "Special",
		"icon": preload("res://assets/icons/lightning-mask.png"),
		"description": "{effect_name}: You draw {amount} less cards per turn. If you have 3 or more stacks, you do not discard cards at the end of each turn.",
	},
	"act_length": {
		"name": "Act Length",
		"type": "Special",
		"self_decreasing": SELF_DECREASE.TURN_END,
		"decrease_type": DECREASE_TYPE.REDUCE,
		"alterant_priority": ALTERANT_PRIORITY.SET,
		"icon": preload("res://assets/icons/pocket-watch.png"),
		"description": "{effect_name}: This torment will be automatically overcome after {amount} turns (1 per stack). "\
				+ "At the end of those turns, the dreamer will take {attack} based on the remaining interpretation on this Torment.\n\n"\
				+ "This torment only receives 1 {opponent_attack} per {opponent_attack}.\n\n"\
				+ "When this torment is {overcome} through {opponent_attack}, the Theatre Play {opponent_attack} is increased.",
		"linked_terms": [
			"attack",
			"opponent_attack",
			"overcome",
		],
	},
	"clawing_for_air": {
		"name": "Clawing for Air",
		"type": "Special",
		"icon": preload("res://assets/icons/drowning.png"),
		"description": "{effect_name}: At the end of its turn, this Torment gains {amount} {strengthen}.",
		"linked_terms": [
			"strengthen",
		],
	},
	"cheek_pinching": {
		"name": "Cheek Pinching",
		"type": "Special",
		"icon": preload("res://assets/icons/pincers.png"),
		"description": "{effect_name}: Any time the {enemy} gains {immersion} during their turn, this {entity} gains 10 {defence} per {energy} gained, and {amount} {strengthen}",
		"linked_terms": [
			"strengthen",
			"energy",
			"defence",
		],
	},
	"infinite_tedium": {
		"name": "Infinite Tedium",
		"type": "Special",
		"icon": preload("res://assets/icons/over-infinity.png"),
		"description": "{effect_name}: You cannot play the same non-Basic card (or its upgrades) in the same turn.",
	},
}


# A way to map generic names to thematic names, so that I can perform
# a rename later if needed
const GENERIC_TAGS := {
	"energy": {
		"name": "Immersion",
		"icon": preload("res://assets/icons/concentration-orb.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/concentration-orb.png",
		"generic_description": "{effect_name} ({effect_icon}): Required cost to play most cards.",
	},
	"defence": {
		"name": "Confidence",
		"icon": preload("res://assets/icons/shield.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/shield.png",
		"generic_description": "{effect_name} ({effect_icon}): Prevents Dreamer from taking {anxiety} from {stress}.",
		"linked_terms": [
			"player_health",
			"stress",
		],
	},
	"attack": {
		"name": "Interpretation",
		"icon": preload("res://assets/icons/magnifying-glass.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/magnifying-glass.png",
		"generic_description": "{effect_name} ({effect_icon}): Increases {enemy_health} on Torments",
		"linked_terms": [
			"enemy_health",
		],
	},
	"enemy_attack": {
		"name": "Stress",
		"icon": preload("res://assets/icons/terror.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/terror.png",
		"generic_description": "{effect_name} ({effect_icon}): Increases {player_health} on the Dreamer by the specified amount.",
		"linked_terms": [
			"player_health",
		],
	},
	"player_health": {
		"name": "Anxiety",
		"icon": preload("res://assets/icons/heart-beats.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/heart-beats.png",
		"generic_description": "{effect_name} ({effect_icon}): When full, the dreamer wakes up and you lose the game.",
	},
	"enemy_health": {
		"name": "Comprehension",
		"icon": preload("res://assets/icons/inspiration.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/inspiration.png",
		"generic_description": "{effect_name} ({effect_icon}): When full, the Torment's is overcome and removed from the ordeal.",
	},
	"risky": {
		"name": "Risky",
		"icon": preload("res://assets/icons/tightrope.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/tightrope.png",
		"generic_description": "{effect_name} ({effect_icon}): Increases {anxiety} taken by Dreamer.",
		"linked_terms": [
			"player_health",
		],
	},
	"relax":  {
		"name": "Relax",
		"icon": preload("res://assets/icons/meditation.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/meditation.png",
		"generic_description": "{effect_name} ({effect_icon}): Reduces Dreamer {anxiety}.",
		"linked_terms": [
			"player_health",
		],
	},
	"purpose": {
		"name": "Immersion",
		"icon": preload("res://assets/icons/concentration-orb.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/concentration-orb.png",
		"generic_description": "{effect_name} ({effect_icon}): Used for playing cards.",
	},
	"chain": {
		"name": "Chain",
		"icon": preload("res://assets/icons/crossed-chains.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/crossed-chains.png",
		"generic_description": "{effect_name} ({effect_icon}): Repeatable card effects.",
	},
	"swift": {
		"name": "Swift",
		"icon": preload("res://assets/icons/windy-stripes.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/windy-stripes.png",
		"generic_description": "{effect_name} ({effect_icon}): Provides card draw.",
	},
	"slumber": {
		"name": "Slumber",
		"icon": preload("res://assets/icons/sleepy.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/sleepy.png",
		"generic_description": "{effect_name} ({effect_icon}): A phase of deep sleep which typically causes forgetfulness.",
	},
	"insomnia": {
		"name": "Insomnia",
		"icon": preload("res://assets/icons/spikeball.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/spikeball.png",
		"generic_description": "{effect_name} ({effect_icon}): Difficult sleeping leads to card discarding.",
	},
	"fading": {
		"name": "Fading",
		"icon": preload("res://assets/icons/empty-hourglass.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/empty-hourglass.png",
		"generic_description": "[color=#A020F0]{effect_name} ({effect_icon}): If still in the hand at the end of the turn, it is forgotten.[/color]",
		"linked_terms": [
			"Forget",
		],
	},
	"spark": {
		"name": "Spark",
		"icon": preload("res://assets/icons/idea.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/idea.png",
		"generic_description": "{effect_name} ({effect_icon}): Reshuffles the deck.",
	},
	"scry": {
		"name": "Scry",
		"icon": preload("res://assets/icons/crystal-ball.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/crystal-ball.png",
		"generic_description": "{effect_name} ({effect_icon}): Looks into the top X cards of the draw pile.",
	},
	"alpha": {
		"name": "Intuition",
		"icon": preload("res://assets/icons/light-bulb.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/light-bulb.png",
		"generic_description": "[color=#A020F0]{effect_name} ({effect_icon}): This card will always be in the starting hand.[/color]",
	},
	"omega": {
		"name": "Enigma",
		"icon": preload("res://assets/icons/omega.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/omega.png",
		"generic_description": "[color=#A020F0]{effect_name} ({effect_icon}): This card will always start at the bottom of the deck.[/color]",
	},
	"frozen": {
		"name": "Cherish",
		"icon": preload("res://assets/icons/wind-hole.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/wind-hole.png",
		"generic_description": "[color=#A020F0]{effect_name} ({effect_icon}): This card will not be discarded from hand at the end of the turn.[/color]",
	},
	"exert": {
		"name": "Rationalizations",
		"icon": preload("res://assets/icons/skills.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/skills.png",
		"generic_description": "{effect_name} ({effect_icon}): Increases {anxiety} when played.",
		"linked_terms": [
			"player_health",
		],
	},
	"pathos": {
		"name": "Pathos",
		"icon": preload("res://assets/icons/drama-masks.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/drama-masks.png",
		"generic_description": "{effect_name} ({effect_icon}): Modifies Pathos when played.",
	},
	"fusion": {
		"name": "Fusion",
		"icon": preload("res://assets/icons/molecule.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/molecule.png",
		"generic_description": "{effect_name} ({effect_icon}): Cards which combine into a stronger card.",
	},
	"init": {
		"name": "Init",
		"icon": preload("res://assets/icons/power-button.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/power-button.png",
		"generic_description": "[color=#A020F0]{effect_name} ({effect_icon}): This card can only be played as the first one in the turn.[/color]",
	},
	"end_turn": {
		"name": "Close",
		"icon": preload("res://assets/icons/stop-sign.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/stop-sign.png",
		"generic_description": "[color=#A020F0]{effect_name} ({effect_icon}): After this card is played, your turn immediately ends.[/color]",
	},
	"startup": {
		"name": "Vivification",
		"icon": preload("res://assets/icons/star-pupil.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/star-pupil.png",
		"generic_description": "{effect_name} ({effect_icon}): This card has an effect which is triggered as soon as an Ordeal starts",
	},
	"once_off": {
		"name": "Burnout",
		"icon": preload("res://assets/icons/burning-passion.png"),
		"rich_text_icon": "res://fonts/rich_text_icons/burning-passion.png",
		"generic_description": "[color=#A020F0]{effect_name} ({effect_icon}): This card cannot be played, if another card with the same name (including upgrades) has been played this turn.[/color]",
	},
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
	"damage_up": {
		"name": "anxiety_up",
		"rich_text_icon": "res://fonts/rich_text_icons/anxiety_up.png",
	},
	"damage_down": {
		"name": "anxiety_down",
		"rich_text_icon": "res://fonts/rich_text_icons/anxiety_down.png",
	},
	"scry": {
		"name": "Scry",
		"rich_text_icon": "res://fonts/rich_text_icons/crystal-ball.png",
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
		"rich_text_effect": "shake",
	},
	"understanding_card": {
		"name": "Understanding",
		"rich_text_color": "#A020F0",
#		"rich_text_color": "purple",
	},
	"discard": {
		"name": "Discard",
		"rich_text_color": "teal",
	},
	"unplayable": {
		"name": "Unplayable",
		"rich_text_effect": "ghost",
	},
	"pierce": {
		"name": "Pierce",
		"rich_text_color": "teal",
	},
	"end_turn": {
		"name": "End Turn",
		"rich_text_color": "teal",
	},
}


# Returns the canonical name (i.e. the dictionary key) of an effect based on its thematic name
static func get_effect_key(thematic_effect_name: String) -> String:
	for effect in ACTIVE_EFFECTS:
		if ACTIVE_EFFECTS[effect].name == thematic_effect_name:
			return(effect)
	return('')


# Returns the dictionary describing an effect based on its mechanical or thematic name
static func get_effect_entry(effect_name: String) -> Dictionary:
	var effect_entry: Dictionary
	if ACTIVE_EFFECTS.has(effect_name):
		effect_entry = ACTIVE_EFFECTS[effect_name]
	else:
		effect_entry = ACTIVE_EFFECTS.get(get_effect_key(effect_name), {})
	return(effect_entry)


# Returns the dictionary describing a generic based on its mechanical or thematic name
static func get_tag_entry(tag_name: String) -> Dictionary:
	var tag_entry := {}
	if GENERIC_TAGS.has(tag_name):
		tag_entry = GENERIC_TAGS[tag_name]
	else:
		for tag in GENERIC_TAGS:
			if GENERIC_TAGS[tag].name == tag_name:
				tag_entry = GENERIC_TAGS[tag]
	return(tag_entry)


# Returns the dictionary describing an effect or tag based on its mechanical or thematic name
static func get_term_entry(term_name: String, key: String, no_icon := false) -> Dictionary:
	var entry := get_effect_entry(term_name)
	if not entry.size():
		entry = get_tag_entry(term_name).duplicate(true)
	if key == "generic_description":
		var generic_format = {"effect_name": term_name}
		if entry.has("rich_text_icon"):
			# I use the no_icon boolean, when the player is explicitly mousing over the icon anyway
			# This way I avoid having to add another RTL
			if not no_icon:
				generic_format["effect_icon"] = "[img=18x18]" + entry["rich_text_icon"] + "[/img]"
			else:
				generic_format["effect_icon"] = ''
		entry[key] = entry[key].format(generic_format)
	return(entry)


# Returns an array of all effects thematic names, matching a specific type
# such as 'Buff', 'Debuff', 'Condition' etc.
static func get_all_effect_types(effect_type: String, exclude_dreamer_only:= false) -> Array:
	var discovered_effects := []
	for effect in ACTIVE_EFFECTS:
		if exclude_dreamer_only and ACTIVE_EFFECTS[effect].get("is_dreamer_only", false):
			continue
		if ACTIVE_EFFECTS[effect].type == effect_type:
			discovered_effects.append(ACTIVE_EFFECTS[effect].name)
	return(discovered_effects)


# Returns the value of a key inside a specified effect
static func get_term_value(thematic_tag_name: String, key: String, no_icon := false):
	var entry := get_term_entry(thematic_tag_name, key, no_icon)
	return(entry.get(key))

static func get_term_thematic_name(term_mechanical_name: String) -> String:
	var entry := get_term_entry(term_mechanical_name, '')
	return(entry.get("name", ''))


# Returns an array containing all the names that can be set as tags
static func get_all_tag_names() -> Array:
	var tag_names := []
	for effect in ACTIVE_EFFECTS:
		tag_names.append(ACTIVE_EFFECTS[effect].name)
	for tag in GENERIC_TAGS:
		tag_names.append(GENERIC_TAGS[tag].name)
	return(tag_names)

# Returns a string format dictionary with all the known formatting for RichTextLabels
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
					"wave":
						complete_format_dict[entry.to_lower()] =\
								"[wave amp=25 freq=2]{name}[/wave]".format(terms_dict[entry])
						complete_format_dict[terms_dict[entry].name.to_lower()] =\
								"[wave amp=25 freq=2]{name}[/wave]".format(terms_dict[entry])
					"shake":
						complete_format_dict[entry.to_lower()] =\
								"[shake rate=3 level=10]{name}[/shake]".format(terms_dict[entry])
						complete_format_dict[terms_dict[entry].name.to_lower()] =\
								"[shake rate=3 level=10]{name}[/shake]".format(terms_dict[entry])
					"rainbow":
						complete_format_dict[entry.to_lower()] =\
								"[rainbow freq=0.2 sat=1 val=20]{name}[/rainbow]".format(terms_dict[entry])
						complete_format_dict[terms_dict[entry].name.to_lower()] =\
								"[rainbow freq=0.2 sat=1 val=20]{name}[/rainbow]".format(terms_dict[entry])
					"ghost":
						complete_format_dict[entry.to_lower()] =\
								"[ghost freq=2.0 span=7.0]{name}[/ghost]".format(terms_dict[entry])
						complete_format_dict[terms_dict[entry].name.to_lower()] =\
								"[ghost freq=2.0 span=7.0]{name}[/ghost]".format(terms_dict[entry])
	return(complete_format_dict)

static func get_pathos_descriptions_bbcode() -> Dictionary:
	var pathos_bbcode_urls := {}
	for key in RUN_ACCUMULATION_NAMES.keys() + RUN_ACCUMULATION_NAMES.values():
		var type = key
		if key in RUN_ACCUMULATION_NAMES.keys():
			type = RUN_ACCUMULATION_NAMES[key]
		for state in ['repressed', 'released']:
			var fmt = {
				"url_meta": JSON.print({"definition": state + '_' + key, "meta_type": "definition"}),
				"pathos_state": state + ' ' + type,
			}
			pathos_bbcode_urls[state + '_' + key] = "[url={url_meta}]{pathos_state}[/url]".format(fmt)
	return(pathos_bbcode_urls)

static func get_pathos_descriptions_formats() -> Dictionary:
	var pathos_bbcode_formats := {}
	# Need to put the boss threshold.
	var fmt_fmt = {
		"boss_threshold": globals.player.pathos.get_boss_threshold()
	}
	for type in PATHOS_DESCRIPTIONS:
		for state in ['repressed', 'released']:
			pathos_bbcode_formats[state + '_' + type] = PATHOS_DESCRIPTIONS[type][state].format(fmt_fmt)
	# We also want to allow the developer to specify the pathos by its functinal name
	# instead of the thematic name
	# For example {repressed_enemy} should also work along with {repressed_frustration}
	for key in RUN_ACCUMULATION_NAMES.keys():
		var type = RUN_ACCUMULATION_NAMES[key]
		for state in ['repressed', 'released']:
			pathos_bbcode_formats[state + '_' + key] = PATHOS_DESCRIPTIONS[type][state].format(fmt_fmt)
	return(pathos_bbcode_formats)
