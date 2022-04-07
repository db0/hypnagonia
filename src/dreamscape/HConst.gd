# Various Hypnagonia related constants
class_name HConst
extends Reference

enum AlterantTypes {
	CARD_UNCOMMON_CHANCE
	CARD_RARE_CHANCE
	CARD_DRAFT_AMOUNT
	ARTIFACT_UNCOMMON_CHANCE
	ARTIFACT_RARE_CHANCE
	CARD_UPGRADE_CHANCE
}

const COLOUR_MAP := {
	'Black': 'Perturbation',
	'Red': 'Action',
	'Green': 'Concentration',
	'Blue': 'Control',
	'Purple': 'Understanding',
}

const COLOUR_MAP2 := {
	'Obsidian': 'Perturbation',
	'Carmine': 'Action',
	'Viridian': 'Concentration',
	'Indigo': 'Control',
	'Periwinkle': 'Understanding'
}

const COLOR2_CODES := {
	'Obsidian': '#445055',
	'Carmine': '#960018',
	'Viridian': '#40826D',
	'Indigo': '#00416A',
	'Periwinkle': '#9457EB',
}

# The below are used in CardModifications and it would make most sense to leave 
# Then in there, but this causes circular reference as I need to access these consts
# in HUtils

# Duplicates to increase chances
const BENEFICIAL_INTEGERS := [
	"beneficial_integer",
	"beneficial_integer2",
	"beneficial_integer3",
	"chain_amount",
	"draw_amount",
	"draw_amount2",
	"scry_amount",
	"effect_stacks",
	"effect_stacks2",
	"effect_stacks3",
	"steal_amount",
	"increase_amount",
	"turns_amount",
	"multiplier_amount",
	"immersion_amount",
	"max_requirements_amount",
]

const DETRIMENTAL_INTEGERS := [
	"detrimental_integer",
	"detrimental_integer2",
	"detrimental_integer3",
	"forget_amount",
	"discard_amount",
	"perturb_amount",
	"detriment_stacks",
	"exert_amount",
	"min_requirements_amount",
]

# This doesn't mean that these amounts are float, but rather that they're multiplied by floats
# This allows us more percentage-based increases.
# For example increasing a value from 4 to 5 is significant, but from 30 to 31 is not
# however by increasing it by 1.1 and rounding up, we make the change significant in both cases.
# Duplicates to increase chances
const BENEFICIAL_FLOATS := [
	"beneficial_float",
	"beneficial_float2",
	"beneficial_float3",
	"beneficial_percentage",
	"damage_amount",
	"damage_amount",
	"damage_amount2",
	"defence_amount",
	"defence_amount",
	"defence_amount2",
	"healing_amount",
]
const DETRIMENTAL_FLOATS := [
	"detrimental_float",
	"detrimental_float2",
	"detrimental_float3",
	"detrimental_percentage",
]
const BENEFICIAL_TAGS := [
	Terms.GENERIC_TAGS.alpha.name,
	Terms.GENERIC_TAGS.frozen.name,
]
const DETRIMENTAL_TAGS := [
	Terms.GENERIC_TAGS.omega.name,
	Terms.GENERIC_TAGS.end_turn.name,
	Terms.GENERIC_TAGS.init.name,
]
const SPECIAL_MODS := {
	"scar": [
		Terms.GENERIC_TAGS.slumber.name,
	],
	"enhancement": [
	]
}
const ALL_NUMERICALS =\
		BENEFICIAL_INTEGERS +\
		DETRIMENTAL_INTEGERS +\
		BENEFICIAL_FLOATS +\
		DETRIMENTAL_FLOATS

const ALL_MODIFIERS =\
		BENEFICIAL_INTEGERS +\
		DETRIMENTAL_INTEGERS +\
		BENEFICIAL_FLOATS +\
		DETRIMENTAL_FLOATS +\
		BENEFICIAL_TAGS +\
		DETRIMENTAL_TAGS

# These tags should never be applied at the same time
const OPPOSITE_TAGS := {
	Terms.GENERIC_TAGS.alpha.name: Terms.GENERIC_TAGS.omega.name,
	Terms.GENERIC_TAGS.omega.name: Terms.GENERIC_TAGS.alpha.name,
	Terms.GENERIC_TAGS.init.name: Terms.GENERIC_TAGS.end_turn.name,
	Terms.GENERIC_TAGS.end_turn.name: Terms.GENERIC_TAGS.init.name,
}
