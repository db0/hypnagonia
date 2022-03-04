class_name Act3
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

const Unnamed1 = {
	"journal_description":\
		'flavour [url={torment_tag1}]TBD[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.UNNAMED1,
				"health_modifier": -40,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.UNNAMED1,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.UNNAMED1,
				"health_modifier": +20,
			},
		],
	},
#	"journal_art": preload("res://assets/journal/torments/traffic_jam.jpeg"),
}
const Life_Paths = {
	"journal_description":\
		'I could see  [url={torment_tag1}]mutliple version of myself[/url] as if in a mirror.\n'\
		+ "I had to figure out which version of me was the one I wanted to become.",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"health_modifier": -20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 1,
						"upgrade": "Active",
					},
				]
			},
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"health_modifier": -20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 1,
						"upgrade": "Controlling",
					},
				]
			},
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"health_modifier": -20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 1,
						"upgrade": "Focused",
					},
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 1,
						"upgrade": "Active",
					},
				]
			},
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 1,
						"upgrade": "Controlling",
					},
				]
			},
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 1,
						"upgrade": "Focused",
					},
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"health_modifier": +5,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 2,
						"upgrade": "Active",
					},
				]
			},
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"health_modifier": +30,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 1,
						"upgrade": "Controlling",
					},
				]
			},
			{
				"definition": EnemyDefinitions.LIFE_PATH,
				"health_modifier": +20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.life_path.name,
						"stacks": 2,
						"upgrade": "Focused",
					},
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/life_path.jpeg"),
}

const Cringelord = {
	"journal_description":\
		'I think I had seen [url={torment_tag1}]this creature before[/url]. Did it always have so many eyes?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": preload("res://assets/journal/torments/cringelord.jpeg"),
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.CRINGELORD,
				"health_modifier": -30,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.coat_of_cringe.name,
						"stacks": 1,
					},
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.CRINGELORD,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.coat_of_cringe.name,
						"stacks": 1,
					},
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.CRINGELORD,
				"health_modifier": -10,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.coat_of_cringe.name,
						"stacks": 1,
					},
				]
			},
			{
				"definition": EnemyDefinitions.FEARMONGER,
				"health_modifier": -20,
			},
		],
	},
}
const Nightmare = {
	"journal_description":\
		"I cannot quite remember what I dreamed next [url={torment_tag1}]but it was staight out of a horror film[/url].\n"\
				+ "Whatever I was watching last night must have affected me more than I think.",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": preload("res://assets/journal/torments/nightmare.jpeg"),
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.NIGHTMARE,
				"rebalancing": {
					"Stress": -2,
				},
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.doom.name,
						"stacks": 3,
					},
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.NIGHTMARE,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.doom.name,
						"stacks": 3,
					},
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.NIGHTMARE,
				"rebalancing": {
					"Stress": +2,
				},
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.doom.name,
						"stacks": 3,
					},
				]
			},
		],
	},
}
const ENEMIES = [
	Unnamed1,
	Life_Paths,
	Cringelord,
	Nightmare,
]

const TheGatherer = {
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/TheGatherer.tscn")],
	"journal_description":\
		'My next few dreams are extremely difficult to remember. It feels like I was '\
		+ "doing things almost randomly.",
	"journal_reward":\
		'Finally I put my thoughts in order.',
#	'journal_art': preload("res://assets/journal/advanced/dentist.jpeg"),
}

const TheatrePlay = {
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/TheatrePlay.tscn")],
	"journal_description":\
		'I was in a theatre troupe and part of a hyped new play. '\
		+ "It was my first show and I had a protagonist role and nothing was ready.",
	"journal_reward":\
		"I don't know how we pulled it through, but as the curtain fell, I felt relieved.",
	'journal_art': preload("res://assets/journal/advanced/theatre.jpeg"),
}

const ELITES = [
	TheGatherer,
	TheatrePlay,
]

const FearAndPhobia = {
	"scenes": [
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/FearBoss.tscn"),
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/PhobiaBoss.tscn"),
	],
	"journal_description":\
		"I barely dare to even recall what I dreamt next. Imagine your worst phobia in the scene of your greatest fear...",
	"journal_reward":\
		"That was finally it! When I opened my eyes, I felt the most relieved I've ever been.",
#	'journal_art': preload("res://assets/journal/advanced/surreality.jpeg"),
}

const BOSSES := {
	"Fear_and_Phobia": FearAndPhobia
}


const NCE := {
	"easy": {
		"ArtifactReward": preload("res://src/dreamscape/Run/NCE/Act3/ArtifactReward.gd"),
	},
	"risky": {
		"MultipleDestroys": preload("res://src/dreamscape/Run/NCE/Act3/MultipleDestroys.gd"),
	}
}

const LOCKED_NCE := {
	"Recurrence3": {
		"nce": preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd"),
		"chance_multiplier": 4,
	},
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.Act3)
