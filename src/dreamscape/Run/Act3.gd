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

const Administration = {
	"journal_description":\
		'My vision blurred as day turned to night. [url={torment_tag1}]My boss raised his voice[/url] before I even spoke.\n'\
		+ "The dilemma was between my career or my sanity.",
	"journal_reward":\
		'The extra headspace granted to me allowed me to reflect more.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.ADMINISTRATION,
				"health_modifier": -40,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.ADMINISTRATION,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.ADMINISTRATION,
				"health_modifier": +20,
			},
		],
	},
	"journal_art": "res://assets/journal/torments/administration.jpeg",
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
	"journal_art": "res://assets/journal/torments/life_path.jpeg",
}

const Cringelord = {
	"journal_description":\
		'I think I had seen [url={torment_tag1}]this creature before[/url]. Did it always have so many eyes?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/cringelord.jpeg",
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
	"journal_art": "res://assets/journal/torments/nightmare.jpeg",
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
const Submerged = {
	"journal_description":\
		"I had gone too deep. [url={torment_tag1}]The blue surrounded me[/url] and I was running out of air.",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/submerged.jpg",
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.SUBMERGED,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.clawing_for_air.name,
						"stacks": 2,
					},
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.SUBMERGED,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.clawing_for_air.name,
						"stacks": 3,
					},
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.SUBMERGED,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.clawing_for_air.name,
						"stacks": 4,
					},
				]
			},
		],
	},
}
const HandsyAunt = {
	"journal_description":\
		"I could hear the overly-loud laughter in the other room. [url={torment_tag1}]My aunt had come for a visit[/url]"\
				+  "I heard the dreaded call from inside: [i]Come, come, let me take a good look at you![/i].",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/handsy_aunt.jpeg",
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.HANDSY_AUNT,
				"rebalancing": {
					"Stress": -2,
				},
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.cheek_pinching.name,
						"stacks": 1,
					},
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.HANDSY_AUNT,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.cheek_pinching.name,
						"stacks": 1,
					},
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.HANDSY_AUNT,
				"rebalancing": {
					"Stress": +1,
				},
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.cheek_pinching.name,
						"stacks": 2,
					},
				]
			},
		],
	},
}
const Circular_Arguments = {
	"journal_description":\
		'Again and again [url={torment_tag1}]we had to repeat the same arguments[/url].\n'\
		+ "I felt we had just resolved it just a minute ago, and yet, here we are discussing it again.",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
			{
				"definition": EnemyDefinitions.CIRCULAR_ARGUMENTS,
				"starting_intent": 0
			},
		],
	},
#	"journal_art": "res://assets/journal/torments/life_path.jpeg"),
}
const Influencer = {
	"journal_description":\
		"I was checking Instagram, TikTok, Reddit, just constantly doom-scrolling [url={torment_tag1}]through perfect lives[/url]. "\
				+  "Was I even really dreaming?",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
#	"journal_art": "res://assets/journal/torments/handsy_aunt.jpeg"),
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.INFLUENCER,
				"starting_intent": 0,
				"rebalancing": {
					"Perplex": -1,
				},
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.INFLUENCER,
				"starting_intent": 0,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": +5,
				"starting_defence": +15,
				"starting_intent": 2,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.INFLUENCER,
				"starting_intent": 0,
				"rebalancing": {
					"Perplex": +1,
				},
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": +5,
				"starting_defence": +15,
				"starting_intent": 2,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": +5,
				"starting_defence": +15,
				"starting_intent": 2,
			},
		],
	},
}

const ENEMIES = {
	"Administration":Administration,
	"Life_Paths":Life_Paths,
	"Cringelord":Cringelord,
	"Nightmare":Nightmare,
	"Submerged":Submerged,
	"HandsyAunt":HandsyAunt,
	"Circular_Arguments":Circular_Arguments,
	"Influencer":Influencer,
}

const TheGatherer = {
	"name": "The Gatherer",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/TheGatherer.tscn")],
	"journal_description":\
		'My next few dreams are extremely difficult to remember. It feels like I was '\
		+ "doing things almost randomly.",
	"journal_reward":\
		'Finally I put my thoughts in order.',
	'journal_art': "res://assets/journal/advanced/the_gatherer.jpeg",
}

const TheatrePlay = {
	"name": "Theatre Play",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/TheatrePlay.tscn")],
	"journal_description":\
		'I was in a theatre troupe and part of a hyped new play. '\
		+ "It was my first show, I had a protagonist role, and nothing was ready.",
	"journal_reward":\
		"I don't know how we pulled it through, but as the curtain fell, I felt relieved.",
	'journal_art': "res://assets/journal/advanced/theatre.jpeg",
}

const ELITES = {
	"TheGatherer": TheGatherer,
	"TheatrePlay": TheatrePlay,
}

const FearAndPhobia = {
	"scenes": [
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/FearBoss.tscn"),
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/PhobiaBoss.tscn"),
	],
	"journal_description":\
		"I barely dare to even recall what I dreamt next. Imagine your worst phobia in the scene of your greatest fear...",
	"journal_reward":\
		"That was finally it! When I opened my eyes, I felt the most relieved I've ever been.",
	'journal_art': "res://assets/journal/advanced/phobia.jpeg",
}

const BOSSES := {
	"Fear_and_Phobia": FearAndPhobia
}


const NCE := {
	"easy": {
		"ArtifactReward": "res://src/dreamscape/Run/NCE/Act3/ArtifactReward.gd",
		"BeastMirror": "res://src/dreamscape/Run/NCE/Act3/BeastMirror.gd",
		"Experience": "res://src/dreamscape/Run/NCE/Act3/Experience.gd",
		"MultipleProgress": "res://src/dreamscape/Run/NCE/Act3/MultipleProgress.gd",
		"Cockroaches": "res://src/dreamscape/Run/NCE/Act3/Cockroaches.gd",
		"TheCake": "res://src/dreamscape/Run/NCE/Act3/TheCake.gd",
		"Cucumbers": "res://src/dreamscape/Run/NCE/Act3/Cucumbers.gd",
	},
	"risky": {
		"MultipleDestroys": "res://src/dreamscape/Run/NCE/Act3/MultipleDestroys.gd",
		"UnderwaterCave": "res://src/dreamscape/Run/NCE/Act3/UnderwaterCave.gd",
	}
}

const LOCKED_NCE := {
	"Recurrence3": {
		"nce": "res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd",
		"chance_multiplier": 4,
	},
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.Act3)

static func get_act_number() -> int:
	return(3)
