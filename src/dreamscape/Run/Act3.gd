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
	"name": "Admninistration",
	"title": "Bureaucracy like no other",
	"journal_description":\
"""My vision blurred as day turned to night. [url={torment_tag1}]My boss[/url] raised his voice before I even spoke. The dilemma was between my career or my sanity. He wanted me to return to work, even though I had done nothing wrong. My mental stability had little meaning these days. Oh, if he could read my thoughts! His words reverberated in my head for another excruciating moment. He shook his head disgustedly. 'Your mental state must be in trouble if you can't recall this nightmare!' he chided me, as though there wasn't any possibility that I'd imagined the event. At least that's how it felt.
""",
	"journal_reward":\
"""I decided to take the absurd step of confronting my boss in the dream. I told him that I remembered everything and that it was all true. He looked taken aback but recovered quickly. With a smirk, he leaned back in his chair and gave me a long, slow clap. 'Bravo!' he exclaimed. 'You're finally revealing your true self.'
""",
	"journal_art": "res://assets/journal/torments/administration.jpg",
	"ai_prompts": [
		"The office colours appeared even more drab than usual, as the administrator called me into the office. The",
	],
	"replacement_keywords": {
		"torment_tag1": ["administrations?", "administrators?", "bureaucracy", "offices?"],
	},
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
}
const Life_Paths = {
	"name": "Life Paths",
	"title": "Analysis Paralysis",
	"journal_description":\
"""I could see multiple version of myself as if in a mirror. I had to figure out which version of me was the one I wanted to become. The only way I could do this was by exploring each possible reality and deciding which one would best suit me. It seemed like a lot of work but I didn't want to lose my chance at happiness. I kept telling myself that there was no need to worry because I could always go back and change things if I didn't like how it turned out.
""",
	"journal_reward":\
"""I don't know what the future holds for me now but I hope I'm able to live up to the potential that I've seen within me. I don't know why I even care about all of this, but I guess it's just a part of who I am. If I don't follow my heart then I'll regret it later.
""",
	"journal_art": "res://assets/journal/torments/Life Path.jpg",
	"ai_prompts": [
		"Of all the many life directions I can choose, which one would lead me to happiness, and which one had the potential to destroy me? Every choice would create another universe of chances, or yet another day in living hell.",
		"Lingering shadows left and right of my life path try to influence me to change my decisions, opening new crossroads to even more possible betterment, or worsening, of my life. How can I resist giving in to my doubts?",
		"My doubts keep whispering to me, trying to make me change my every decision and thus my life path, to unknown and dire consequences.",
	],
	"replacement_keywords": {
		"torment_tag1": ["life paths?","paths?","life","choices?","directions?"],
	},
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
}

const Cringelord = {
	"name": "Cringelord",
	"title": "The cringe is real",
	"journal_description":\
"""The creature before me observed me silently. I could feel its sight poring over my most embarrassing memories, every single one of them. I wanted to look away, to hide my face in shame, but I couldn't. [url={torment_tag1}]The Cringelord[/url] had me transfixed.

It was as if all the times I had ever been embarrassed, all the times I had ever made a fool of myself, were being played back on a loop in my mind. And there was nothing I could do to stop it. The more I tried to block it out, the louder and clearer the memories became
""",
	"journal_reward":\
"""Cringe could only affect me so much when I was dreaming. After all, in my dreams, I was the one in control. I gathered my wits and managed to instead retrieve a lesson back from those uncomfortable memories.
""",
	"journal_art": "res://assets/journal/torments/Cringelord.jpg",
	"ai_prompts": [
		"Like a twisted carnival of horror my most degrading and embarrassing moments are invading my conscious mind all at once, as",
	],
	"replacement_keywords": {
		"torment_tag1": ["cringelords?","cringe","embarassment"],
	},
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
	"name": "Nightmare",
	"title": "Out of your deepest horror",
	"journal_description":\
"""I cannot quite remember what I dreamed next but it was [url={torment_tag1}]straight out of a horror film[/url]. A small figure wearing a long cloak was walking around in my bedroom, whispering things to me that were impossible to make sense of. He told me he was a messenger from an evil force, which I dismissed as just another delusion until he reached out his hand and tried to touch me.
""",
	"journal_reward":\
"""Though I don't remember how, I somehow managed to overcome the fear that was paralyzing me in my dream. Maybe it was because I realized that this figure wasn't really a messenger from an evil force, but just a product of my own fears and imagination.
""",
	"journal_art": "res://assets/journal/torments/Nightmare.jpg",
	"ai_prompts": [
		"I felt I was living in something from a [ nightmare ] horror film",
		"It was a nightmare as pure to the word as can be",
	],
	"replacement_keywords": {
		"torment_tag1": ["nightmares?", "horrors?", "terrors?"],
	},
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
	"name": "Submerged",
	"title": "A Primal Fear of Drowning",
	"journal_description":\
"""With a panicked start I realized: [url={torment_tag1}]I had gone too deep[/url]. The blue surrounded me and I was running out of air.
I started gasping for breath. It wasn't just the cold water that was taking my breath away. The chill from the ocean's depths had crept into my body, numbing every inch of me. My hands were shaking uncontrollably. My feet were numb and tingly. My mind was screaming at me to wake up, but my body refused to move.
""",
	"journal_reward":\
"""The oppressive water turned into mist around me, along with my anxiety as the torment dissipated.
""",
	"journal_art": "res://assets/journal/torments/submerged.jpg",
	"ai_prompts": [
		"My lungs were starting to hurt, and the surface of the water was still too far away",
	],
	"replacement_keywords": {
		"torment_tag1": ["submerged", "drowning", "water"],
	},
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
	"name": "Handy Aunt",
	"title": "Running away from the Pinch",
	"journal_description":\
"""I could hear the overly-loud laughter in the other room. [url={torment_tag1}]My aunt had come for a visit[/url]. I heard the dreaded call: "Come, come, let me take a good look at you!" And she came, pushing me towards her, squeezing my shoulders. She smelled like garlic, and it was quite nauseating. But she seemed so happy. So...
""",
	"journal_reward":\
"""I fought back, pushing her away. I didn't want her to touch me. I didn't want anyone to touch me ever again without my consent. 
""",
	"journal_art": "res://assets/journal/torments/Handsy Aunt.jpg",
	"ai_prompts": [
		"It wasn't the [ Handsy Aunt's ] pinching of my cheeks that annoyed me most, it was the slobbering kisses",
	],
	"replacement_keywords": {
		"torment_tag1": ["handsy aunt", "handsy", "aunt", "uncle"],
	},
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
	"name": "Circular Arguments",
	"title": "The Back and Forth of Fallacy",
	"journal_description":\
"""Again and again [url={torment_tag1}]we had to repeat the same arguments[/url] I felt we had just resolved it just a minute ago, and yet, here we are discussing it again. My thoughts are not exactly coherent, and I feel like my brain is in a permanent state of disarray. But there's nothing else for me to do, so I try to keep up.
""",
	"journal_reward":\
"""I cut through the fallacies as if they were the legendary gordian knot and the broken pieces of bad reasoning dissipated in the air
""",
	"journal_art": "res://assets/journal/torments/Circular Arguments.jpg",
	"ai_prompts": [
		"Again and again we had the same [ circular ] arguments",
	],
	"replacement_keywords": {
		"torment_tag1": ["circular arguments?", "circular", "arguments?", "debates?"],
	},
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
}
const Influencer = {
	"name": "Influencer",
	"title": "Always Better than Me",
	"journal_description":\
"""I was checking Instagram, TikTok, Reddit, just constantly doom-scrolling [url={torment_tag1}]through perfect lives[/url]. It was really hard to find content that didn't make me feel inadequate or angry at my own existence. I couldn't focus on anything anymore, and it felt like my mind was a pile of mud that kept getting thrown back at me.
""",
	"journal_reward":\
"""I reinforced to myself that it was all fake, and the feelings of envy slowly subdued.  I remember furiously unfollowing on social media as the dream shifted
""",
	"journal_art": "res://assets/journal/torments/influencer.jpg",
	"ai_prompts": [
		"Why couldn't my life be as glamorous as the influencer I was following",
	],
	"replacement_keywords": {
		"torment_tag1": ["influencers?", "glamour", "social media", "envy"],
	},
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
const Shamelings = {
	"name": "Shamelings",
	"title": "No Secret Stash is Safe",
	"journal_description":\
"""They were all over my bedroom, going through all my stuff and laughing to each other cruelly about all my secrets. [url={torment_tag1}]Too many to stop![/url]! I screamed at them, but they just laughed louder. They said it was funny that I thought I could hide anything from them.
""",
	"journal_reward":\
"""The only way out of this predicament was to acknowledge my own self and stop feeling ashamed of who I am. That meant that I had to tell them everything, and there was no point hiding things anymore. So I told them all my deepest, darkest secrets, even the ones I'd never shared with anyone else. It felt like I was losing myself when I did that, but it was also liberating. And it worked!
""",
	"journal_art": "res://assets/journal/torments/Shamelings.jpg",
	"ai_prompts": [
		"They [ the shamelings ] we all over my bedroom, going through my things and looking for my most cherised possessions",
	],
	"replacement_keywords": {
		"torment_tag1": ["shamelins?", "shame"],
	},
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.SHAMELING,
				"starting_defence": +15,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
				"starting_defence": +15,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
				"starting_defence": +15,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
				"starting_defence": +15,
			},
			{
				"definition": EnemyDefinitions.SHAMELING,
				"starting_defence": +15,
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
	"Shamelings":Shamelings,
}

const TheGatherer = {
	"name": "The Gatherer",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/TheGatherer.tscn")],
	"journal_description":\
"""I felt my dreams being drained from me, at the same time I noticed an misty figure in a white robe at the edge of my vision. It slowly approached me but I could still only see it from my peripheral sight, like one those spots in your eyes which move as you try to focus on them. I realized it wasn't my vision failing, it was my imagination!
""",
	"journal_reward":\
"""It took all my effort to piece my dream fragments back together into something coherent enough to understand. But as soon as I could distinguish the Gatherer's true form, it fled as quickly as it appeared.
""",
	'journal_art': "res://assets/journal/advanced/The Gatherer.jpg",
	"ai_prompts": [
		"My dreams were draining from me while the misty figure [ of the gatherer ] stood motionless",
	],
}

const TheatrePlay = {
	"name": "Theatre Play",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/TheatrePlay.tscn")],
	"journal_description":\
""" I was in a theatre troupe and part of a hyped new play. It was my first show, I had a protagonist role, and nothing was ready. There were a lot of things missing. My character's wardrobe wasn't right. My hair was different from what it should be. And most importantly, I was completely unprepared for the scene. I hadn't memorized the lines, so I didn't know what to say or how to act. The whole thing went downhill fast, and it felt like the entire audience was watching me fall apart.
""",
	"journal_reward":\
"""Somehow we managed to improvise our way to completion. The audience applauded and gave us high fives afterwards. We went back home feeling accomplished, but something about that moment still haunts me. 
""",
	'journal_art': "res://assets/journal/advanced/Theatre Play.jpg",
	"ai_prompts": [
		"I was in a theatre troupe and part of a hyped new play but completely unprepared",
	],
}

const InfiniteCorridor = {
	"name": "Infinite Corridor",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/InfiniteCorridor.tscn")],
	"journal_description":\
"""Was it an office corridor, or a tight tunnel? I can't quite remember. But what stuck with me is how I could never seem to reach the end. Every light at the end, was just a corner. Every exit found, impassable. The only way out was to keep going, but it was exhausting. The corridors were always moving. They changed shape and color, as if the walls were alive. The floors seemed to move beneath my feet. My legs felt like jelly, but I kept on walking.
""",
	"journal_reward":\
"""Forcing myself past the encroaching boredom, I started noticing etches on the walls, the more I focused, the more it looked like a door. The etchings became clearer. The wall itself began to fade away into the shadows. As it did, the door revealed itself.
""",
	'journal_art': "res://assets/journal/advanced/Infinite Corridor.jpg",
	"ai_prompts": [
		"The corridor kept going on and on, to infinity as I",
		"Would I ever get out [ of the infinite corridor ] or was I cursed to walk endlessly forward",
	],
}

const ELITES = {
	"TheGatherer": TheGatherer,
	"TheatrePlay": TheatrePlay,
	"Infinite Corridor": InfiniteCorridor,
}

const FearAndPhobia = {
	"name": "Fear and Phobia",
	"title": "When my Deepest Fear Married My Greatest Phobia.",
	"scenes": [
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/FearBoss.tscn"),
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/PhobiaBoss.tscn"),
	],
	"journal_description":\
		"I barely dare to even recall what I dreamt next. Imagine your worst phobia in the scene of your greatest fear...",
	"journal_reward":\
		"That was finally it! When I opened my eyes, I felt the most relieved I've ever been.",
	'journal_art':
		[
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia1.jpg",
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia2.jpg",
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia3.jpg",
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia4.jpg",
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia5.jpg",
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia6.jpg",
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia7.jpg",
			"res://assets/journal/advanced/Fear and Phobia/Fear and Phobia8.jpg"
		],
	"ai_prompts": [
		"I could feel my phobias rising to the surface as my fears surrounded me",
	],
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
