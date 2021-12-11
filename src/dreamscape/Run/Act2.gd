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

const TheLaughingOnes = {
	"journal_description":\
		'I found myself between [url={torment_tag1}]a pair of featureless creeps laughing[/url] at me.',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			}
		],
	},
	"journal_art": preload("res://assets/journal/the_laughing_one.jpeg"),
}


const Fearmonger = {
	"journal_description":\
		'Was that [url={torment_tag1}]a curious owl with three eyes[/url] staring at me?',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"journal_art": preload("res://assets/journal/fearmonger.jpeg"),
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.FEARMONGER,
				"health_modifier": -30,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.FEARMONGER,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.FEARMONGER,
				"health_modifier": -20,
			},
			{
				"definition": EnemyDefinitions.FEARMONGER,
				"health_modifier": -20,
			},
		],
	},
}


const Gaslighter = {
	"journal_description":\
		'I saw [url={torment_tag1}]a strange form with a head like a lamp[/url] moving towards me.',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.GASLIGHTER,
				"health_modifier": -20,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.GASLIGHTER,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.GASLIGHTER,
				"health_modifier": +10,
				"starting_defence": +10,
			},
		],
	},
	"journal_art": preload("res://assets/journal/gaslighter.jpeg"),
}


const UnnamedEnemy1 = {
	"journal_description":\
		'[url={torment_tag1}]<Description to be added>[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.UNNAMED_ENEMY_1,
				"health_modifier": -10,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.UNNAMED_ENEMY_1,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.thorns.name,
						"stacks": 1
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.UNNAMED_ENEMY_1,
				"health_modifier": +30,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.thorns.name,
						"stacks": 3
					}
				]
			},
		],
	},
#		"journal_art": preload("res://assets/journal/the_critic.jpeg"),
}


const TheCritic = {
	"journal_description":\
		'Strange furry animals with massive noses (or were they trunks) [url={torment_tag1}]started sniffing at me, and pointing out my weaknesses[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_CRITIC,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.strengthen.name,
						"stacks": 2
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_CRITIC,
			},
			{
				"definition": EnemyDefinitions.THE_CRITIC,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_CRITIC,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.strengthen.name,
						"stacks": 2
					}
				]
			},
			{
				"definition": EnemyDefinitions.THE_CRITIC,
				"health_modifier": +25,
			},
		],
	},
	"journal_art": preload("res://assets/journal/the_critic.jpeg"),
}


const Clown = {
	"journal_description":\
		'I somehow ended in a peculiar argument [url={torment_tag1}]with a clown[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.CLOWN,
				"health_modifier": -10,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.CLOWN,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.CLOWN,
				"starting_defence": +20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.fortify.name,
						"stacks": 1
					}
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/clown.jpeg"),
}


const Butterfly = {
	"journal_description":\
		'What a [url={torment_tag1}]depressive butterfly[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.BUTTERFLY,
				"health_modifier": -10,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.BUTTERFLY,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.BUTTERFLY,
				"health_modifier": +10,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.strengthen.name,
						"stacks": 2
					}
				]
			},
		],
	},
	"journal_art": preload("res://assets/journal/butterfly.jpeg"),
}


const BrokenMirrors = {
	"journal_description":\
		'Am I cursed [url={torment_tag1}]or is it just bad luck[/url]?',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": -12,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": -12,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": -12,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"starting_defence": +10,
				"health_modifier": +10,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"starting_defence": +10,
				"health_modifier": +10,
			},
		],
	},
	"journal_art": preload("res://assets/journal/broken_mirror.jpg"),
}

const Pialephant = {
	"journal_description":\
		'I heard piano music but its source [url={torment_tag1}]made no sense[/url]!',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"health_modifier": -20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.disempower.name,
						"stacks": 5
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"health_modifier": 0,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"starting_defence": +20,
			},
		],
	},
	"journal_art": preload("res://assets/journal/pialephant.jpg"),
}
const TheLightCalling = {
	"journal_description":\
		'At one point, I felt like I was having [url={torment_tag1}]a near death experience[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_LIGHT_CALLING,
				"health_modifier": -10,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_LIGHT_CALLING,
				"health_modifier": 0,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_LIGHT_CALLING,
				"starting_defence": +12,
			},
		],
	},
	"journal_art": preload("res://assets/journal/the_light_calling.jpeg"),
}
const Squirrel = {
	"journal_description":\
		'I found myself facing off [url={torment_tag1}]with a squirrel giving me the stink-eye[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.quicken.name,
						"stacks": 1
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
				"starting_defence": +7,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.quicken.name,
						"stacks": 2
					}
				],
			},
		],
	},
	"journal_art": preload("res://assets/journal/squirrel.jpg"),
}
const Baby = {
	"journal_description":\
		'I had to take care of [url={torment_tag1}]a fussy baby[/url]. I am responsible enough?',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.BABY,
				"health_modifier": -10,
				"starting_intent": 0
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.BABY,
				"starting_intent": 0,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.BABY,
				"starting_intent": 0,
				"health_modifier": +15,
			},
		],
	},
	"journal_art": preload("res://assets/journal/baby.jpeg"),
}
#	{
#		"journal_description":\
#			'I found myself cowering before [url={torment_tag1}]a three-eyed owl[/url]'\
#			+ ' while someone in the distance was [url={torment_tag2}]laughing at my aprehension.[/url]',
#		"journal_reward":\
#			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
#		"enemies": [
#			{
#				"definition": EnemyDefinitions.FEARMONGER,
#			},
#			{
#				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
#			},
#		]
#	},
#	{
#		"journal_description":\
#			'I discovered that [url={torment_tag1}]the lamps that should not be[/url] were multiplying.',
#		"journal_reward":\
#			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
#		"enemies": [
#			{
#				"definition": EnemyDefinitions.GASLIGHTER,
#			},
#			{
#				"definition": EnemyDefinitions.GASLIGHTER,
#			},
#		],
#		"journal_art": preload("res://assets/journal/gaslighter.jpeg"),
#	},



const ENEMIES = [
	TheLaughingOnes,
	TheCritic,
	Fearmonger,
	UnnamedEnemy1,
	Clown,
	Butterfly,
	BrokenMirrors,
	Pialephant,
	TheLightCalling,
	Baby,
]

const RushElite = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/RushElite.tscn"),
	"journal_description":\
		'I remember walls enclosing me and no obvious way out...',
	"journal_reward":\
		'I finally understood what these infinite twists and turns represented.',
}
const Bully = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/Bully.tscn"),
	"journal_description":\
		'My mind took me back to uncomfortable memories of schoolyard bullying.',
	"journal_reward":\
		'This time, I fortunately knew how to respond.',
}

const ELITES = [
	RushElite,
	Bully
]

const Narcissus = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Bosses/Narcissus.tscn"),
	"journal_description":\
		'I found someone I am sure I know, but I can\'t quite remember who.'\
		+ 'I found them gazing in a mirror, or was it a lake? They turned their attention to me...',
	"journal_reward":\
		'Through the many lies and denials, [url=boss_card_draft]I cornered the truth out of them.[/url]'\
		+ 'and for once felt like [url=boss_artifact]I was getting somewhere[/url].',
}

const BOSSES := {
	"Narcissus": Narcissus
}

const NCE := [
	preload("res://src/dreamscape/Run/NCE/Act1/MonsterTrain.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/SlayTheSpire.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/SleepOfOblivion.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/MultipleOptions.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/PathosForAnxiety.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/TheCandyman.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/Dollmaker.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/Greed.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/PopPsychologist1.gd"),
]

static func get_act_name() -> String:
	return("Deep Sleep")
