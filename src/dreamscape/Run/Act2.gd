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

#Title [Traffic Jam]
#Keywords [torment, surrealism, frustration, cars, infinity, wait, boring, horns, haze, distance]
#Avoid [I woke up, wake up, awaken, I was dreaming]
#Story Summary [I started dreaming about my daily commute traffic jam, but the road seemed to stretch to eternity]
#Conclusion Summary [Through overcoming that weird experience, I felt wiser.]
const TrafficJam = {
	"journal_description": \
"""I was [url={torment_tag1}]stuck in a traffic jam[/url], surrounded by cars that stretched out as far as the eye could see. The air was thick with exhaust fumes and the sound of horns blaring. I felt a sense of frustration and boredom rising up within me. The road ahead of me seemed to stretch out into infinity.
""",
	"journal_reward": \
"""I realized that it was a metaphor for the feeling of being stuck in life, and how frustrating and dull it can be. But I also realized that by overcoming that experience, I felt wiser and more aware of the things that truly matter in life.
""",
	"journal_art": "res://assets/journal/torments/Traffic Jam.jpg",
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
}

# Inspiration taken from StS mods developed by https://github.com/modargo
#Title [Mouse]
#Keywords [torment, surrealism, tea, rodent, philosophy, debate, friendly, exasperating, discussion, change of topics, sophistries, polite, learning]
#Avoid [I woke up, wake up, awaken, I was dreaming]
#Story Summary [I was having tea with a rodent. It was explaining the pitfalls of overpopulation.]
#Conclusion Summary [I realized that there would be no learning from this creature. Through overcoming that weird experience, I felt wiser.]
const Mouse = {
	"journal_description": \
"""I was having tea with [url={torment_tag1}]a rodent[/url]. It explained how overpopulation would eventually lead to the collapse of civilization as we know it. The torment began when it started debating the merits of different philosophies. The discussion was friendly, but the rodent's incessant changing of topics was exasperating. It seemed to enjoy playing with my mind, twisting my words into sophistries. I tried to remain polite, but it was clear that the rodent was enjoying itself at my expense. 	
""",
	"journal_reward": \
"""I realized that there was no point in trying to engage the rodent in a serious discussion. It was content to play with my mind and twist my words into knots. I proceeded feeling wiser for having overcome that experience.
""",
	"journal_art": "res://assets/journal/torments/Mouse.jpg",
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
}

# Inspiration taken from StS mods developed by https://github.com/modargo
#Title [Exam]
#Keywords [torment, surrealism, stressed, teacher, stern, study, forgetting, lacuna, blank, time up, pens scribbling, clock ticking, sweat, party, bell, sitting, nervous]
#Avoid [I woke up, wake up, awaken, I was dreaming]
#Story Summary [The bell rang and I had to get back into class. It was time for the test]
#Conclusion Summary [Through overcoming that weird experience, I felt wiser.]
const TheExam = {
	"journal_description": \
"""The bell rang and I had to get back into class. It was [url={torment_tag1}]time for the test[/url]. My teacher handed out the papers and I could feel my heart racing. I tried to focus on the questions, but all I could think about was failing.

I started sweating and my hands were shaking. The clock seemed like it was ticking louder and slower at the same time. I heard pens scribbling around me, but it felt like everyone else was moving in slow motion.
""",
	"journal_reward": \
"""The test was finally over and I could breathe again. Despite how stressed I was, I somehow managed to finish it.

Looking back, I realize that the whole experience was surreal. It's like my mind was playing tricks on me. But in a way, it was also a good reminder of how important it is to stay calm under pressure.
""",
	"journal_art": "res://assets/journal/torments/Exam.jpg",
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
}

# Inspiration taken from StS mods developed by https://github.com/modargo
#Title [The Victim]
#Keywords [torment, surrealism, confused, hurt, faking, abuse, projection, tactic]
#Avoid [I woke up, wake up, awaken, I was dreaming]
#Story Summary [They claimed I always hurt their feelings. Was I in the wrong? I don't know anymore...]
#Conclusion Summary [Through overcoming that weird experience, I felt wiser.]
const TheVictim = {
	"journal_description":\
"""I hurt [url={torment_tag1}]their feelings once again[/url], they claim. I don't know why, but it seems like everything I do ends up making them cry or withdraw, Maybe I'm just a bad person. I can't tell anymore.

I try to fake being sorry, even though I don't really know what I did wrong. I try to make myself smaller, less noticeable. I don't want to hurt them anymore.
""",	
	"journal_reward":\
"""I realized that I was being abused. They were manipulating me and gaslighting me to make me believe that I was the one at fault.

I'm not going to let them control me anymore. I'm done with faking being sorry for something I didn't do
""",	
	"journal_art": "res://assets/journal/torments/The Victim.jpg",
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
}

# Inspiration taken from StS mods developed by https://github.com/modargo
#Title [Stuffed Toy]
#Keywords [torment, surrealism, absurdity, wrestling, huge, fluffy, lost, smothered, escape, depression, pressure, warmth, heavy]
#Avoid [I woke up, wake up, awaken, I was dreaming]
#Story Summary [I was wrestling in bed with a stuffed toy. Why was this feeling so difficult?]
#Conclusion Summary [Through overcoming that weird experience, I felt wiser.]
const StuffedToy = {
	"journal_description":\
"""I was wrestling in bed with [url={torment_tag1}]a stuffed toy[/url]. Why was this feeling so difficult? I couldn't tell if it was the toy or me that was losing, but eventually, I realized that it didn't matter. We were both lost in the same cycle of pain and pleasure, unable to escape each other's grasp.

The pressure of the toy against my body was suffocating, but at the same time, its warmth was strangely comforting.
""",
	"journal_reward":\
"""It was a heavy burden that felt impossible to escape from, but at the same time, it was something I couldn't bear to part with. That feeling of being suffocated and lost in the moment was strangely familiar, and it made me realize that I needed to find a way to escape from my own cycle of pain and pleasure.
""",
	"journal_art": "res://assets/journal/torments/Stuffed Toy.jpg",
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
}

const ImpossibleConstruction = {
	"journal_description":\
		"I was climbing a staircase somewhere, but somehow "\
			+ "[url={torment_tag1}]I always ended up on the ground floor again.[/url]",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/Impossible Construction.jpg",
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
}

const ClownShow = {
	"journal_description":\
		'[url={torment_tag1}]The Clowns were back[/url], and this time [url={torment_tag2}]they brought the circus[/url]!',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/ClownShow.jpg",
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
}
const GuiltyTreatment = {
	"journal_description":\
		'I was talking to someone. But they were either [url={torment_tag1}]blaming me[/url], or [url={torment_tag2}]giving me the silent treatment[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/Silent Treatment.jpg",
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
}
const Void = {
	"journal_description":\
		"Initially I felt it was dreamless sleep. But it occurred to me [url={torment_tag1}]it was far worse[/url]...",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/The Void.jpg",
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
}
const ENEMIES = {
	"TrafficJam": TrafficJam,
	"Mouse": Mouse,
	"TheExam": TheExam,
	"TheVictim": TheVictim,
	"ClownShow": ClownShow,
	"StuffedToy": StuffedToy,
	"ImpossibleConstruction": ImpossibleConstruction,
	"GuiltyTreatment": GuiltyTreatment,
	"Void":Void,
}

const IndescribableAbsurdity = {
	"name": "Fractalization",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/IndescribableAbsurdity.tscn")],
	"journal_description":\
		'I was surrounded by infinite complexity at all sides.',
	"journal_reward":\
		'In the end, I simply dreamed of something more sane.',
	'journal_art': "res://assets/journal/advanced/Fractalization.jpg",
}
const Dentist = {
	"name": "Dentist",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Dentist.tscn")],
	"journal_description":\
		'I was strapped-in, in a strangely familiar place. White. Sterile. The sound of a rapidly spinning machine started echoing behind me...',
	"journal_reward":\
		'I swear, I will never forget flossing again!',
	'journal_art': "res://assets/journal/advanced/Dentist.jpg",
}
const Jumbletron = {
	"name": "Jumbletron",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Jumbletron.tscn")],
	"journal_description":\
		'I had enterred a room which appeared to be self-rearranging. Walls which were farther than they seemed, '\
		+ "and an almost fractal level of detail.\n"\
		+ "I couldn't find the exit anymore.",
	"journal_reward":\
		'Somehow I figured out the correct organization to make it out.',
	'journal_art': "res://assets/journal/advanced/Jumbletron.jpg",
}

const ELITES = {
	"IndescribableAbsurdity":IndescribableAbsurdity,
	"Dentist":Dentist,
	"Jumbletron":Jumbletron,
}

const SurrealBoss = {
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn")],
	"journal_description":\
		"The next dream was so incomprehensible, just trying to remember it makes my head hurt",
	"journal_reward":\
		"I don't claim to understand what I was seeing, [url=boss_card_draft]but eventually that vision faded.[/url]"\
		+ "but my mind was open to [url=boss_artifact]many new possibilities[/url].",
	'journal_art': 
		[
			"res://assets/journal/advanced/Surreality/Surreality1.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality2.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality3.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality4.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality5.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality6.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality7.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality8.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality9.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality10.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality11.jpg",
			"res://assets/journal/advanced/Surreality/Surreality12.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality13.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality14.jpg", 
			"res://assets/journal/advanced/Surreality/Surreality15.jpg"
		],
}

const BOSSES := {
	"Surreality": SurrealBoss
}


const NCE := {
	"easy": {
		"Griftlands": "res://src/dreamscape/Run/NCE/Act2/Griftlands.gd",
		"BannersOfRuin": "res://src/dreamscape/Run/NCE/Act2/BannersOfRuin.gd",
		"MiniShop": "res://src/dreamscape/Run/NCE/Act2/MiniShop.gd",
		"Subconscious": "res://src/dreamscape/Run/NCE/Act2/Subconscious.gd",
		"AlphaKappaOmega": "res://src/dreamscape/Run/NCE/Act2/AlphaKappaOmega.gd",
		"MultipleScriptMods": "res://src/dreamscape/Run/NCE/Act2/MultipleScriptMods.gd",
		"LoseRandomCurio": "res://src/dreamscape/Run/NCE/Act2/LoseRandomCurio.gd",
		"HangingOn": "res://src/dreamscape/Run/NCE/Act2/HangingOn.gd",
		"Blanket": "res://src/dreamscape/Run/NCE/Act2/Blanket.gd",
	},
	"risky": {
		"RiskyEvent3": "res://src/dreamscape/Run/NCE/Act2/RiskyEvent3.gd",
		"RiskyEvent4": "res://src/dreamscape/Run/NCE/Act2/RiskyEvent4.gd",
	}
}

const LOCKED_NCE := {
	"Griftlands2": {
		"nce": "res://src/dreamscape/Run/NCE/Act2/Griftlands2.gd",
		"chance_multiplier": 1,
	},
	"Griftlands3": {
		"nce": "res://src/dreamscape/Run/NCE/Act2/Griftlands3.gd",
		"chance_multiplier": 1,
	},
	"Recurrence2": {
		"nce": "res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd",
		"chance_multiplier": 4,
	},
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.Act2)

static func get_act_number() -> int:
	return(2)
