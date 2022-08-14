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
	"name": "Traffic Jam",
	"title": "Frustration unending",
	"journal_description":\
"""I was [url={torment_tag1}]stuck in a traffic jam[/url], surrounded by cars that stretched out as far as the eye could see. The air was thick with exhaust fumes and the sound of horns blaring. I felt a sense of frustration and boredom rising up within me. The road ahead of me seemed to stretch out into infinity.""",
	"journal_reward":\
"""I realized that it was a metaphor for the feeling of being stuck in life, and how frustrating and dull it can be. But I also realized that by overcoming that experience, I felt wiser and more aware of the things that truly matter in life.""",
	"journal_art": "res://assets/journal/torments/Traffic Jam.jpg",
	"ai_prompts": [
		"I was stuck in traffic, in a bottleneck that stretched accross the horizon",
		"I was caught in the never-ending traffic jam before me. I had places to go, things to do!",
		"The traffic jam was an endless torture. Was it even worth",
		"The traffic jam of anger blocked the stairway to happiness. I was at a dead end",
	],
	"replacement_keywords": {
		"torment_tag1": ["[Tt]raffic Jam","[Tt]raffic","[Jj]am","[Bb]ottleneck","[Bb]oredom"],
	},
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
	"name": "Mouse",
	"title": "Polite company with a mouse",
	"journal_description":\
"""I was having tea with [url={torment_tag1}]a rodent[/url]. It explained how overpopulation would eventually lead to the collapse of civilization as we know it. The torment began when it started debating the merits of different philosophies. The discussion was friendly, but the rodent's incessant changing of topics was exasperating. It seemed to enjoy playing with my mind, twisting my words into sophistries. I tried to remain polite, but it was clear that the rodent was enjoying itself at my expense. 	""",
	"journal_reward":\
"""I realized that there was no point in trying to engage the rodent in a serious discussion. It was content to play with my mind and twist my words into knots. I proceeded feeling wiser for having overcome that experience.""",
	"journal_art": "res://assets/journal/torments/Mouse.jpg",
	"ai_prompts": [
		"I was having polite tea with a mouse, discussing political theory",
		"The squeaky voice of the mouse rattled my brain around with its hyperactive intelligence. I understood nothing",
		"The teacups shattered onto the floor as the words began to spill out of the mouse's erratic mouth",
		"The mouse was too smart for me. It predicted every word I said, transforming them inton a convoluted theory",
	],
	"replacement_keywords": {
		"torment_tag1": ["mouse","rodent","discussing"],
	},
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
	"name": "The Exam",
	"title": "Pencils ready for the test",
	"journal_description":\
"""The bell rang and I had to get back into class. It was [url={torment_tag1}]time for the test[/url]. My teacher handed out the papers and I could feel my heart racing. I tried to focus on the questions, but all I could think about was failing.

I started sweating and my hands were shaking. The clock seemed like it was ticking louder and slower at the same time. I heard pens scribbling around me, but it felt like everyone else was moving in slow motion.""",
	"journal_reward":\
"""The test was finally over and I could breathe again. Despite how stressed I was, I somehow managed to finish it.

Looking back, I realize that the whole experience was surreal. It's like my mind was playing tricks on me. But in a way, it was also a good reminder of how important it is to stay calm under pressure.""",
	"journal_art": "res://assets/journal/torments/Exam.jpg",
	"ai_prompts": [
		"The bell rang and I breathlessly took my seat, just in time for the exam",
	],
	"replacement_keywords": {
		"torment_tag1": ["exam","test"],
	},
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
	"name": "The Victim",
	"title": "Playing the victim once more",
	"journal_description":\
"""I hurt [url={torment_tag1}]their feelings once again[/url], they claim. I don't know why, but it seems like everything I do ends up making them cry or withdraw, Maybe I'm just a bad person. I can't tell anymore.

I try to fake being sorry, even though I don't really know what I did wrong. I try to make myself smaller, less noticeable. I don't want to hurt them anymore.""",
	"journal_reward":\
"""I realized that I was being abused. They were manipulating me and gaslighting me to make me believe that I was the one at fault.

I'm not going to let them control me anymore. I'm done with faking being sorry for something I didn't do""",
	"journal_art": "res://assets/journal/torments/The Victim.jpg",
	"ai_prompts": [
		"I know I didn't do anything wrong but they [ the fake victim ] kept insising I hurt their feelings",
	],
	"replacement_keywords": {
		"torment_tag1": ["victim","fake"],
	},
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
	"name": "Stuffed Toy",
	"title": "Wrestling with a Plushie",
	"journal_description":\
"""I was wrestling in bed with [url={torment_tag1}]a stuffed toy[/url]. Why was this feeling so difficult? I couldn't tell if it was the toy or me that was losing, but eventually, I realized that it didn't matter. We were both lost in the same cycle of pain and pleasure, unable to escape each other's grasp.

The pressure of the toy against my body was suffocating, but at the same time, its warmth was strangely comforting.""",
	"journal_reward":\
"""It was a heavy burden that felt impossible to escape from, but at the same time, it was something I couldn't bear to part with. That feeling of being suffocated and lost in the moment was strangely familiar, and it made me realize that I needed to find a way to escape from my own cycle of pain and pleasure.""",
	"journal_art": "res://assets/journal/torments/Stuffed Toy.jpg",
	"ai_prompts": [
		"The wrestling [ with my stuffed toy ] was becoming more intense.",
	],
	"replacement_keywords": {
		"torment_tag1": ["[Ss]tuffed toy","[Ss]tuffed", "[Tt]oys?", "[Pp]lushies?"],
	},
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

#Title [Impossible Construction]
#Story Keywords [torment, surrealism, mc escher, impossible, inverted, pyramid, brainfuck, dizzy, non-euclidean, discombobulation]
#Story Summary [I was climbing a staircase somewhere, but somehow I always ended up on the ground floor again.]
#Conclusion Keywords [wisdom, overcoming, enlightenment, clarity, break out, think outside the box]
const ImpossibleConstruction = {
	"name": "Impossible Construction",
	"title": "The building that should not be",
	"journal_description":\
"""I was climbing a staircase somewhere, but somehow I always [url={torment_tag1}]ended up on the ground floor again[/url]. It was as if the stairs were inverted, or maybe I was. Either way, it was impossible to go anywhere.""",
	"journal_reward":\
"""I realized that the only way to get anywhere was to think outside the box and see the world in a new, non-euclidean way. With that wisdom, I was able to break out of this impossible construction and find myself in a new place entirely.""",
	"journal_art": "res://assets/journal/torments/Impossible Construction.jpg",
	"ai_prompts": [
		"Like a painting from M.C. Escher, I could not understand where this construction started and where it ended",
		"The physics of the building that stood before me were straining my brain",
	],
	"replacement_keywords": {
		"torment_tag1": ["[Ii]mpossible construction","[Ii]mpossible", "[Cc]onstructions?", "[Bb]uildings?", "[Ss]tructures?"],
	},
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

#Title [Clown Show]
#Story Keywords [torment, surrealism, absurdity, clowns, piano, pialephants, philosophy, music, confusion, debate, thought ]
#Conclusion Keywords [wisdom, overcoming, ridicule, solution, smart]
const ClownShow = {
	"name": "Clown Show",
	"title": "Pialephants and Clowns together",
	"journal_description":\
"""The [url={torment_tag2}]Pialephants[/url] were providing the music for this stange circus, as [url={torment_tag1}]the clowns[/url] debated ancient dead philosphers. The clowns were getting more and more agitated, as they failed sway the crowd either way. They turned and looked expectantly at me

"And what do you think?" One of them called out""",
	"journal_reward":\
"""I simply shrugged my shoulders. I had no answers for them and I didn't feel bad about it.""",
	"journal_art": "res://assets/journal/torments/ClownShow.jpg",
	"ai_prompts": [
		"The pialephants were providing the music for this clown circus",
	],
	"replacement_keywords": {
		"torment_tag1": ["[Cc]lowns?"],
		"torment_tag2": ["[Pp]ialephants?","[Ee]lephants?", "[Pp]ianos?"],
	},
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

#Title [Guilty Treatment]
#Story Keywords [torment, surrealism, abuse, despair, frustration, pleading, talking, arguing, defensive, silent]
#Story Summary [I was talking to someone. But they were either blaming me, or giving me the silent treatment]
#Conclusion Keywords [wisdom, overcoming, self-worth, breakthrough, understanding]
const GuiltyTreatment = {
	"name": "Guilty Treatment",
	"title": "Guilt Trip and Silent Treatment",
	"journal_description":\
"""I was desperately pleading with someone, trying to get them to see my side of things. But no matter what I said, they just stared at me coldly, refusing to listen. They were either [url={torment_tag1}]blaming me[/url] for something, or giving me [url={torment_tag2}]the silent treatment[/url].

It was frustrating and upsetting, making me feel guilty and ashamed. I couldn't understand why they were treating me this way, or what I could do to make it stop. All I could do was keep talking""",
	"journal_reward":\
"""I realised that I was blaming myself for something that wasn't my fault. And I also realized that the other person's treatment of me had nothing to do with me, and everything to do with their own issues.""",
	"journal_art": "res://assets/journal/torments/Silent Treatment.jpg",
	"ai_prompts": [
		"The guilt trip was too much, as I tried to get through their silent treatment",
	],
	"replacement_keywords": {
		"torment_tag1": ["guilt trip","guilt"],
		"torment_tag2": ["silent treatment", "silent", "treatment"],
	},
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
	"name": "Void",
	"title": "A Black Hole in your mind",
	"journal_description":\
"""Initially I felt like my dreams were fading. But as the void of everything grew larger and more distinct, it occurred to me it was far worse. You see, what a dream that could never be repeated. An endless black space opens, coming together with your mind, reaching towards you like a powerful claw.
From your perspective, it feels cold, it stretches out, wants to penetrate you and capture you for eternity. Yet when you look down onto the threshold, what do you see?""",
	"journal_reward":\
"""When you read these words now, there's going to be something else occupying the void inside of you; an invisible "you" staring back from deep within yourself... But that shouldn't matter. Right?""",
	"journal_art": "res://assets/journal/torments/The Void.jpg",
	"ai_prompts": [
		"My imagination found it exceedingly hard to escape the weight of sucking void I saw in my mind",
	],
	"replacement_keywords": {
		"torment_tag1": ["void","black hole","hole","black"],
	},
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
"""I was surrounded by infinite complexity at all sides. The terrifying omnipresence of Endlessness had a grip on my body now, desperately wanting to invade, consuming anything possible to occupy its interior. I grew large with black energy in my core. Within the suctioned walls, anything I needed came to me all the time. With mental faculty at the beck and call of its newfound creation, anything came through and still remains.""",
	"journal_reward":\
"""Do I remember how it felt when it was inside me? What sense of freedom? There are moments during certain phases where the fabric that binds my soul and body becomes devious, uncomfortable and painful. I question what this even means or makes me as if it can be wrong.""",
	'journal_art': "res://assets/journal/advanced/Fractalization.jpg",
	"ai_prompts": [
		"A fractal complexity was everywhere, and I felt myself going busy trying to process",
	],
}
const Dentist = {
	"name": "Dentist",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Dentist.tscn")],
	"journal_description":\
"""I was strapped-in, in a strangely familiar place. White. Sterile. The sound of a rapidly spinning drill started echoing behind me... I turned to look behind me, finding an open window. The metal frames of two arms craned over me as the jumbled masked face of a dentist appeared to my side.

"So, tell me, have you been flossing regularly?""",
	"journal_reward":\
"""First thing I did the next day is look in the mirror and check that my teeth looked fine. They were, but something about the dream made me feel uneasy. I couldn't help wondering if there was some hidden message in it for me.
""",
	'journal_art': "res://assets/journal/advanced/Dentist.jpg",
	"ai_prompts": [
		"Why was I once more in the Dentist office? Oh right, the bunny teeth",
		"The dental drill startled me, as the masked face of the dentist appeared to my side",
	],
}
const Jumbletron = {
	"name": "Jumbletron",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Jumbletron.tscn")],
	"journal_description":\
"""I had entered a room which appeared to be self-rearranging. Walls which were farther than they seemed, and an almost fractal level of detail. Things blended in with each other so quickly that I assumed I was hallucinating.
"Well that's quite the collection." I said to myself. I laughed, but my mind was spiraling down into a place filled with confusion and chaotic, strange colors, trying to grasp how exactly my surroundings differed from my last recollection.""",
	"journal_reward":\
"""I finally thought I saw the exit, however this one didn't look like any of the others I had encountered. Strange stained glass windows above what could only be described as an open window led away into the distance. Even though the memory flashed behind me, I fell right through without a second glance, not able to follow in reality because my brain would not focus.""",
	'journal_art': "res://assets/journal/advanced/Jumbletron.jpg",
	"ai_prompts": [
		"The room seemed to have no begginging and no end, or it just shifted that",
		"I kept searching for the exit door, but I kept climbing to the ceiling instead",
	],
}

const ELITES = {
	"IndescribableAbsurdity":IndescribableAbsurdity,
	"Dentist":Dentist,
	"Jumbletron":Jumbletron,
}

const SurrealBoss = {
	"name": "Surreality",
	"title": "The surreal becomes the only real",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn")],
	"journal_description":\
"""The next dream was so incomprehensible, just trying to remember it makes my head hurt. All I can say is that whatever happened last night seems like another form of indescribable insanity.""",
	"journal_reward":\
"""I don't claim to understand what I was seeing, but eventually that vision faded. Even now, five or six days later, it still lingers with me like a sickeningly sweet memory of otherworldly immorality, loneliness, anguish and confusion.""",
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
	"ai_prompts": [
		"The next dream was so incomprehensible, just trying to remember it makes my head hurt",
		"Was that really a dream I saw, or just a fevered psychedelia",
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
