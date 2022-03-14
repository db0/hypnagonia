class_name Act2
extends Act

"""
The enemies list, is a list of dictionaries, which define which enemy to spawn
in each encounter. You can also optionally specified starting effects
for each enemy, as well as a specific intent to start with. The intent
Should be a valid index within the intents available for that enemy

As an example:

		"enemies": {
			"hard": [
				{
					"definition": EnemyDefinitions.THE_LAUGHING_ONE,
					"starting_intent": 1
					"health_modifier": -10
					"starting_defence": 10
					"starting_effects": [
						{
							"name": Terms.ACTIVE_EFFECTS.vulnerable.name,
							"stacks": 5
						}
					]
				},
			]
		}
"""

const TrafficJam = {
	"journal_description":\
		'I started dreaming about my [url={torment_tag1}]daily commute traffic jam[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/traffic_jam.jpeg"),
}

# Inspiration taken from StS mods developed by https://github.com/modargo
const Mouse = {
	"journal_description":\
		'I was having tea with [url={torment_tag1}]a rodent[/url]. It was explaining the pitfalls of overpopulation.',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.MOUSE,
				"health_modifier": -10,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 3
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.MOUSE,
				"starting_intent": 1,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 2
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.MOUSE,
				"starting_intent": 1,
				"starting_defence": +12,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 1
					}
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/mouse.jpeg"),
}

# Inspiration taken from StS mods developed by https://github.com/modargo
const TheExam = {
	"journal_description":\
		"The bell rang and I had to get back into class."\
			+ "[url={torment_tag1}]It was time for the test.[/url]",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_EXAM,
				"health_modifier": -20,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 1
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_EXAM,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 2
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_EXAM,
				"starting_intent": 0,
				"health_modifier": 20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 3
					}
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/exam.jpeg"),
}

# Inspiration taken from StS mods developed by https://github.com/modargo
const TheVictim = {
	"journal_description":\
		"[url={torment_tag1}]They claimed I always hurt their feelings.[/url] "\
			+ "Was I in the wrong? I don't know anymore...",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_VICTIM,
				"health_modifier": -10,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.the_victim.name,
						"stacks": 4
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_VICTIM,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.the_victim.name,
						"stacks": 3
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_VICTIM,
				"health_modifier": +15,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.the_victim.name,
						"stacks": 2
					}
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/the_victim.jpeg"),
}
# Inspiration taken from StS mods developed by https://github.com/modargo
const StuffedToy = {
	"journal_description":\
		"[url={torment_tag1}]I was wrestling in bed with a stuffed toy.[/url] "\
			+ "Why was this feeling so hard?",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.STUFFEDTOY,
				"health_modifier": -10,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.stuffed_toy.name,
						"stacks": 1
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.STUFFEDTOY,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.stuffed_toy.name,
						"stacks": 2
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.STUFFEDTOY,
				"rebalancing": {
					"Stress": +1,
				},
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.stuffed_toy.name,
						"stacks": 3
					}
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/stuffed_toy.jpeg"),
}

const ImpossibleConstruction = {
	"journal_description":\
		"I climbing the staircase somewhere, but somehow "\
			+ "[url={torment_tag1}]I always ended up on the ground floor again.[/url]",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.IMPOSSIBLE_CONSTRUCTION,
				"starting_defence": +30,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.protection.name,
						"stacks": 2
					},
					{
						"name": Terms.ACTIVE_EFFECTS.fortify.name,
						"stacks": 1
					},
					{
						"name": Terms.ACTIVE_EFFECTS.effect_resistance.name,
						"stacks": 1,
						"upgrade": Terms.ACTIVE_EFFECTS.poison.name,
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.IMPOSSIBLE_CONSTRUCTION,
				"starting_defence": +40,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.fortify.name,
						"stacks": 3
					},
					{
						"name": Terms.ACTIVE_EFFECTS.impervious.name,
						"stacks": 1
					},
					{
						"name": Terms.ACTIVE_EFFECTS.effect_resistance.name,
						"stacks": 1,
						"upgrade": Terms.ACTIVE_EFFECTS.poison.name,
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.IMPOSSIBLE_CONSTRUCTION,
				"starting_defence": +50,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.protection.name,
						"stacks": 3
					},
					{
						"name": Terms.ACTIVE_EFFECTS.fortify.name,
						"stacks": 1
					},
					{
						"name": Terms.ACTIVE_EFFECTS.effect_resistance.name,
						"stacks": 1,
						"upgrade": Terms.ACTIVE_EFFECTS.poison.name,
					}
				]
			},
		],
	},
#	"journal_art": preload("res://assets/journal/torments/stuffed_toy.jpeg"),
}

const ClownShow = {
	"journal_description":\
		'[url={torment_tag1}]The Clowns were back[/url], and this time [url={torment_tag2}]they brought the circus[/url]!',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.CLOWN,
				"starting_defence": +10,
				"rebalancing": {
					"Stress": -2
				},
			},
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"health_modifier": -10,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.CLOWN,
				"starting_defence": +10,
			},
			{
				"definition": EnemyDefinitions.PIALEPHANT,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.CLOWN,
				"starting_defence": +20,
				"rebalancing": {
					"Perplex": +2
				},
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.fortify.name,
						"stacks": 3
					}
				]
			},
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"starting_defence": +20,
				"rebalancing": {
					"Stress": +2,
					"Perplex": +2
				}
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/pialephant.jpg"),
}
const GuiltyTreatment = {
	"journal_description":\
		'I was talking to someone. But they were either [url={torment_tag1}]blaming me[/url], or [url={torment_tag2}]giving me the silent treatment[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.GUILT,
				"rebalancing": {
					"Stress": -1
				},
			},
			{
				"definition": EnemyDefinitions.SILENT_TREATMENT,
				"health_modifier": -15,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.GUILT,
			},
			{
				"definition": EnemyDefinitions.SILENT_TREATMENT,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.GUILT,
				"rebalancing": {
					"Stress": +1
				},
			},
			{
				"definition": EnemyDefinitions.SILENT_TREATMENT,
				"health_modifier": +15,
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/silent_treatment.jpeg"),
}
const Void = {
	"journal_description":\
		"Initially I felt it was dreamless sleep. But it occurred to me [url={torment_tag1}]it was far worse[/url]...",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.VOID,
				"health_modifier": -20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS["void"].name,
						"stacks": 2
					},
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.VOID,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS["void"].name,
						"stacks": 2
					},
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.VOID,
				"rebalancing": {
					"Stress": +1,
					"Increase Complexity": +1,
				},
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS["void"].name,
						"stacks": 2
					},
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/void.jpeg"),
}
const ENEMIES = [
	TrafficJam,
	Mouse,
	TheExam,
	TheVictim,
	ClownShow,
	StuffedToy,
	ImpossibleConstruction,
	GuiltyTreatment,
	Void,
]

const IndescribableAbsurdity = {
	"name": "Indescribable Absurdity",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/IndescribableAbsurdity.tscn")],
	"journal_description":\
		'I remember dreaming something indescribable.',
	"journal_reward":\
		'In the end, I simply dreamed of something more sane.',
	'journal_art': preload("res://assets/journal/advanced/absurdity.jpeg"),
}
const Dentist = {
	"name": "Dentist",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Dentist.tscn")],
	"journal_description":\
		'I was strapped-in, in a strangely familiar place. White. Sterile. The sound of a rapidly spinning machine started echoing behind me...',
	"journal_reward":\
		'I swear, I will never forget flossing again!',
	'journal_art': preload("res://assets/journal/advanced/dentist.jpeg"),
}
const Jumbletron = {
	"name": "Jumbletron",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Jumbletron.tscn")],
	"journal_description":\
		'I had enterred a room which seemed to be an amalgram of a lot of different encounters I had.\n'\
		+ "I couldn't find the exit anymore.",
	"journal_reward":\
		'Somehow I figured out the correct organization to make it out.',
#	'journal_art': preload("res://assets/journal/advanced/dentist.jpeg"),
}

const ELITES = [
	IndescribableAbsurdity,
	Dentist,
	Jumbletron,
]

const SurrealBoss = {
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn")],
	"journal_description":\
		"The next dream was so incomprehensible, just trying to remember it makes my head hurt",
	"journal_reward":\
		"I don't claim to understand what I was seeing, [url=boss_card_draft]but eventually that vision faded.[/url]"\
		+ "but my mind was open to [url=boss_artifact]many new possibilities[/url].",
	'journal_art': preload("res://assets/journal/advanced/surreality.jpeg"),
}

const BOSSES := {
	"Surreality": SurrealBoss
}


const NCE := {
	"easy": {
		"Griftlands": preload("res://src/dreamscape/Run/NCE/Act2/Griftlands.gd"),
		"BannersOfRuin": preload("res://src/dreamscape/Run/NCE/Act2/BannersOfRuin.gd"),
		"MiniShop": preload("res://src/dreamscape/Run/NCE/Act2/MiniShop.gd"),
		"Subconscious": preload("res://src/dreamscape/Run/NCE/Act2/Subconscious.gd"),
		"AlphaKappaOmega": preload("res://src/dreamscape/Run/NCE/Act2/AlphaKappaOmega.gd"),
		"MultipleScriptMods": preload("res://src/dreamscape/Run/NCE/Act2/MultipleScriptMods.gd"),
		"LoseRandomCurio": preload("res://src/dreamscape/Run/NCE/Act2/LoseRandomCurio.gd"),
		"HangingOn": preload("res://src/dreamscape/Run/NCE/Act2/HangingOn.gd"),
	},
	"risky": {
		"RiskyEvent3": preload("res://src/dreamscape/Run/NCE/Act2/RiskyEvent3.gd"),
		"RiskyEvent4": preload("res://src/dreamscape/Run/NCE/Act2/RiskyEvent4.gd"),
	}
}

const LOCKED_NCE := {
	"Griftlands2": {
		"nce": preload("res://src/dreamscape/Run/NCE/Act2/Griftlands2.gd"),
		"chance_multiplier": 1,
	},
	"Griftlands3": {
		"nce": preload("res://src/dreamscape/Run/NCE/Act2/Griftlands3.gd"),
		"chance_multiplier": 1,
	},
	"Recurrence2": {
		"nce": preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd"),
		"chance_multiplier": 4,
	},
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.Act2)
