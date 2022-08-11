class_name Act1
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
	"name": "The Laughing Ones",
	"title": "Surrounded by mocking laughter",
	"journal_description":\
"""It was the unending cackle that did it. I'd had enough.
I turned to face my tormentors and found myself between [url={torment_tag1}]a pair of featureless creeps laughing[/url].
"What's so funny?" I demanded. My voice sounded thin, even to my own ears.
"You," they replied in unison, their laughter redoubling.
I tried to lunge at them but they side-stepped easily, still laughing uncontrollably.
Suddenly furious, I screamed at them; a anguished, keening sound that echoed in the emptiness around us.
They only laughed harder and danced away from me again as if this were the most amusing thing they'd ever seen.
""",
	"journal_reward":\
""""ENOUGH!" I roared, and they finally stopped, still grinning their awful grins. "I don't know who you are or what you want from me, but I'm done playing your games. So just go away and leave me alone!" For a moment they simply stared at me; then slowly, ever so slowly, their grins widened even further until their mouths threatened to split open from the effort. And then they dissolved into laughter once more and faded away until I was left standing alone in the darkness." Standing up to my fear made me feel stronger than before.
""",
	"journal_art": "res://assets/journal/torments/The Laughing One.jpg",
	"ai_prompts": [
		"It was the unending cackle { of the laughing ones } that did it",
		"I found myself surrounded by featureless laughing faces",
	],
	"replacement_keywords": {
		"torment_tag1": ["featureless","laughing","cackling","laughter", "lol", "rofl", "roflmao"],
	},
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
				"health_modifier": -7,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
				"health_modifier": -5,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
				"health_modifier": -5,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
				"health_modifier": -8,
			}
		],
	},
}


const Fearmonger = {
	"name": "Fearmonger",
	"title": "The Fearmonger watches",
	"journal_description":\
"""[url={torment_tag1}]Three eyes staring at me[/url], the first was a piercing blue that seemed to bore through me, the second was a deep black that hid my true nature, and the third was a bright yellow that I couldn't look away from.
I felt a bit dizzy. I had the sensation that I was falling. My stomach lurched, and my breath caught in my throat. It all felt so real. I was floating in the middle of the night, staring at the third eye, and I couldn't move. I had to look away.
""",
	"journal_reward":\
"""The experience was definitely strange, and it left me feeling a bit unsettled. It's hard to say what exactly the owl represented, but it seemed to be some sort of symbol of wisdom or knowledge. Perhaps the three eyes represented different aspects of knowledge (past, present, and future?) or different ways of seeing things (logic, emotion, intuition?). In any case, the experience taught me that there is more to life than what we can see with our physical eyes. There are other ways of knowing and understanding the world around us.
""",
	"journal_art": "res://assets/journal/torments/Fearmonger.jpg",
	"ai_prompts": [
		"The third eye { of the fearmonger } was focused on me",
		"As I felt dread encompass me, I looked around to see the Fearmonger focusing on me",
	],
	"replacement_keywords": {
		"torment_tag1": ["fearmonger","dread","state","staring"],
	},
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
	"title": "Gaslight manifest",
	"name": "Gaslighter",
	"journal_description":\
"""It was dark as I was standing in an open field. A light flickered in the dark, filling my body with suspense as I wondered what it was coming from.
I remember In the distance I could see [url={torment_tag1}]a grotesque entity move towards me[/url], the green flame flickered from the lamp attached to its strange head-body hybrid, illuminating the grueling faces it possessed.
It started to tell me what I was and had become. I began to doubt myself and I felt like everything that I stood for was slowly burning away inside of me.
I pleaded for it to go away, but I knew I couldn't shake it. The dark field I was standing in had erupted into green flames and in the light I was now face-to-face with the two-faced abomination.
""",
	"journal_reward":\
		"In the end, I had learned to overcome the doubt. I wouldn't let them gaslight me anymore. The ugly entity was crippled on the ground breathing out puffs of smoke as I pondered at my triumph. The entity ascended upwards and screamed at me in sheer exasperation and embarassment as it flew away. I knew that that was not the last time I was going to have to confront them. But now, I won't let anyone question my reality.",
	"journal_art": "res://assets/journal/torments/Gaslighter.jpg",
	"ai_prompts": [
		"The sphrerical head { of the gaslighter } dismissed my concerns",
		"\"Did it realy happen this way?\", the Gaslighter whispered to me, as I struggled to keep in mind the true memory",
	],
	"replacement_keywords": {
		"torment_tag1": ["gaslighters?","gaslighting"],
	},
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
}


const Murmurs = {
	"name": "Murmurs",
	"title": "Murmurs in the wind",
	"journal_description":\
"""I thought I heard [url={torment_tag1}]murmurs in the wind[/url]. Were they talking about [i]that[/i] time..?
By the minute, I was getting more certain that they were talking about me, and this had only left me more upset.
Their whispers lingered in the air, getting more acerbic by the second.
""",
	"journal_reward":\
"""Their blame and resentment had me at my breaking point. Yet I stood firm them and reinforced my self-esteem. At this point, I had learned life is too short to keep grudges.
""",
	"journal_art": "res://assets/journal/torments/Murmurs.jpg",
	"ai_prompts": [
		"The murmurs were all around me. I was sure it was about me.",
		"I hated the whispering judgements { of the murmurs } that were just at the edge of my hearing",
	],
	"replacement_keywords": {
		"torment_tag1": ["murmurs?","whispers?","judgements?"],
	},
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.MURMURS,
				"health_modifier": -15,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.MURMURS,
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
				"definition": EnemyDefinitions.MURMURS,
				"health_modifier": +30,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.thorns.name,
						"stacks": 4
					}
				]
			},
		],
	},
}

#Title [The Critic]
#Keywords [torment, surrealism, absurdity, uncanny valley, comical, animal, anthropomorphic, criticism, humorous]
#Summary  [Entities with enlarged sense organs detecting my flaws]
#Avoid [I woke up, wake up, awaken, I was dreaming]
const TheCritic = {
	"name": "The Critic",
	"title": "The Critic's uncomfortable gaze",
	"journal_description":\
"""I was in the middle of my usual morning jog when I noticed them.
At first I thought they were birds, but then I realized they were something else entirely.
They were [url={torment_tag1}]strange entities with comically enlarged sense organs[/url] that started circling me and pointing out all my flaws.
It was disconcerting to say the least, especially since I had no idea what they were or where they came from.
""",
	"journal_reward":\
"""I was eventually able to shake them off and escape, but I couldn't help but wonder what it all meant.
Do these creatures represent some kind of uncanny valley where everyday objects are given strange, exaggerated features?
Or is this a commentary on the nature of criticism itself? Whatever the case may be, it's certainly a surreal experience that I won't soon forget.
""",
	"journal_art": "res://assets/journal/torments/The Critic.jpg",
	"ai_prompts": [
		"The hilarity of their appearance wasn't enough to dull the cut of their review as the critics beset me",
		"Each assessment painfull accurate, the critics were callous in their critique.",
	],
	"replacement_keywords": {
		"torment_tag1": ["critics?","critique","judgement"],
	},
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
}


#Keywords [dream, argument, clown, torment, philosphy, calm, surreality, humanism, ennui, existentialism]
#Summary  [I somehow ended in a peculiar argument with a clown.]
#Avoided concepts [woke up, wake up, awaken]
const Clown = {
	"name": "Clown",
	"title": "Arguing with a Clown",
	"journal_description":\
"""I found myself in the middle of an argument [url={torment_tag1}]with a clown[/url]. It was a surreal experience, and I couldn't quite make sense of what was happening. The clown seemed to be tormenting me, but I wasn't sure why. Suddenly, I felt an overwhelming sense of ennui wash over me. It was as if nothing mattered any more. All that existed was this pointless argument with the clown.
""",
	"journal_reward":\
"""Suddenly, I realized that the clown wasn't really worth getting so worked up over. It was just a silly creature, with no real understanding of anything. In the grand scheme of things, it didn't really matter what it said or did.

With that realization, I felt a sense of calm come over me. The ennui dissipated and I was able to see things more clearly. This whole confrontation with the clown was an exercise in existentialism; it made me confront the meaninglessness of life head-on. But eventually, I overcame that feeling and moved on.
""",
	"journal_art": "res://assets/journal/torments/Clown.jpg",
	"ai_prompts": [
		"I found myself in the middle of an argument with a clown",
		"How long have I been talking to this clown?",
		"The back and forth between me and the clown was endless",
		"I've never discussed philosophy { with a clown } in such a manner before",
	],
	"replacement_keywords": {
		"torment_tag1": ["clowns?"],
	},
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
}

#Keywords [dreaming, argument, butterfly, torment, surrealism, absurdity, uncanny valley]
#Summary  [A depressive butterfly confounded me with its dark beauty.]
#Avoid [I woke up, wake up, awaken]
const Butterfly = {
	"name": "Butterfly",
	"title": "Such a depressive butterfly",
	"journal_description":\
"""I was having a conversation with a friend about something completely mundane when I noticed [url={torment_tag1}]a dark butterfly nearby[/url]. It was incredibly beautiful, but its beauty was overshadowed by the fact that it seemed to be in pain. It's wings were drooping and it looked like it was struggling to stay alive.

As I watched, the butterfly began to move closer and I could see that its eyes were clouded over with sadness. It seemed as though it wanted to speak to me, but no words came out. Suddenly, the butterfly flew towards me and perched on my finger. Its weight felt surprisingly heavy and I could feel its sadness seeping into my own heart.
""",
	"journal_reward":\
"""Though it was beautiful, the dark butterfly was a reminder of the pain and sadness that often plagues us. Its presence was a jarring contrast to the mundanity of my everyday life and its uncanniness sent shivers down my spine. In some ways, it felt like a token of death, but in others, I glimpsed a glimmer of hope.
""",
	"journal_art": "res://assets/journal/torments/Butterfly.jpg",
	"ai_prompts": [
		"What a depressive butterfly which has beset me",
		"The beauty I saw { in the butterfly } was countered by the sadness I felt in it's flutter.",
	],
	"replacement_keywords": {
		"torment_tag1": ["butterly","butterflies"],
	},
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
}


#Keywords [dreaming, torment, surrealism, absurdity, uncanny valley, curse, bad luck, perspective, broken mirror, dark shadow of myself, evil twin]
#Summary  [Am I cursed by this broken mirror, or is it just the random happenstance of bad luck?]\
#Avoid [I woke up, wake up, awaken]
const BrokenMirrors = {
	"name": "Broken Mirrors",
	"title": "The kaleidoscope of broken mirrors",
	"journal_description":\
"""I glance over at the [url={torment_tag1}]broken mirror[/url] on my bedside table and shudder. It's not like I didn't know it was there; I could see the cracked glass from across the room. But now that it's so close, I can't help but feel a sense of dread. Am I cursed by this broken mirror, or is it just the random happenstance of bad luck?

I try to shake off my superstitions and remind myself that there's probably a rational explanation for why this happened. But no matter how much logical reasoning I apply, I can't help but feel like there's something more to it all. Maybe it's the surrealism of seeing such an unexpected break in symmetry.
""",
	"journal_reward":\
"""But even as I write this, I can't shake the feeling that there's something more to it. That maybe this broken mirror is a dark shadow of myself, an evil twin that's been following me around and bringing me nothing but bad luck.
""",
	"journal_art": "res://assets/journal/torments/Broken Mirror.jpg",
	"ai_prompts": [
		"Am I unlucky { to break these mirrors } or is it just bad luck?",
		"I saw myself reflected a thousand times, in the shards of the broken mirror",
	],
	"replacement_keywords": {
		"torment_tag1": ["broken mirror","mirror","broken"],
	},
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
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"starting_defence": +10,
			},
		],
	},
}

const Pialephant = {
	"name": "Pialephant",
	"title": "Pachydermic Music",
	"journal_description":\
"""I felt a feeling of excitement wash over me, as I heard a rumble in the clouds under my feet.
I had thought it was a storm at first, but I had realized it was the circus coming straight towards me with great surprise!
The drums boomed while the music and laughter blared louder as they were getting closer.
My anticipation was met with concern, as I noticed they were not slowing down.
In the distance I could hear the hastened sliding of piano keys evoking the sound of thunder as [url={torment_tag1}]a behemoth was charging straight towards me[/url].
This was no orchestra I wanted to be overrun by!
""",
	"journal_reward":\
"""Instead of letting my shock overtake me, I had to make some notes for a balloon as the gargantuan beast punted me through the clouds in the sound of a sonata.
Hopefully it didn’t play something sharp, or else my balloon would become a corny pop song!
Luckily, I had just found I was able to catch myself in the music, because I’d B-flat on the ground otherwise.
""",
	"journal_art": "res://assets/journal/torments/pialephant.jpg",
	"ai_prompts": [
		"The thundering of the ground felt like a perfect accompanyment to the weighty piano sound { coming from the pialephant }.",
		"I cowered before the Pialephant, as the piano keyboard that was its nose lay before me, daring me to play the first note.",
	],
	"replacement_keywords": {
		"torment_tag1": ["pialephants?","elephants?","piano keyboard","pianos?","keyboards?"],
	},
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"health_modifier": -30,
				"rebalancing": {
					"Stress": -2,
					"Perplex": -2
				}
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"health_modifier": 0,
				"rebalancing": {
					"Stress": 0,
					"Perplex": 0
				}
			},
		],
		"hard": [
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


#Title [The Light Calling]
#Keywords [torment, surrealism, absurdity, uncanny valley, calm, ascending, dread, excitement, apathy, emotion, bright]
#Summary  [At one point, I felt like I was having a near death experience.]
#Avoid [I woke up, wake up, awaken, I was dreaming]
const TheLightCalling = {
	"name": "The Light Calling",
	"title": "The Light Calling",
	"journal_description":\
"""I'm not sure how I got here. One moment I was in my bed, and the next I was floating through some kind of odd, surreal landscape. It felt like I was having a near death experience; everything had an intense sense of calm about it, but there was also a underlying feeling of dread that kept me from enjoying it too much.

Eventually though, the weirdness began to pass and I found myself ascending towards what looked like [url={torment_tag1}]the light at the end of a tunnel[/url]. Excitement welled up in me as approached closer and closer until...
""",
	"journal_reward":\
"""I reached the light and passed through it, finding myself in a bright and beautiful world. I felt a sense of apathy settle over me as I stared around at the seemingly infinite planes of this place; there was nothing to excite me or hold my attention for long.

Eventually, I turned away from the light and began to wander aimlessly through the planes until I found myself back where I started.
""",
	"journal_art": "res://assets/journal/torments/The Light Calling.jpg",
	"ai_prompts": [
		"Is this the light calling me, the end of the tunnel, or something worse?",
		"I am beckoned { to The Light Calling } and I cannot stop myself",
	],
	"replacement_keywords": {
		"torment_tag1": ["the light calling","[Ll]ights?","[Cc]alling"],
	},
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_LIGHT_CALLING,
				"health_modifier": -10,
				"rebalancing": {
					"Stress": -1,
				}
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
				"rebalancing": {
					"Stress": +1,
				}
			},
		],
	},
}

#Title [The Squirrel]
#Keywords [torment, surrealism, absurdity, uncanny valley, calm before the storm, upset, nut, mad, comical, explode]
#Summary  [I found myself facing off with a squirrel giving me the stink-eye.]
#Avoid [I woke up, wake up, awaken, I was dreaming]
const Squirrel = {
	"name": "Squirrel",
	"title": "One pissed off rodent",
	"journal_description":\
"""I found myself staring down [url={torment_tag1}]a squirrel[/url] as it gave me the stink-eye. I wondered what was going through its head, as nut season had come and gone and it clearly wasn't getting any food from me. It must have been incredibly frustrating for the poor creature.
""",
	"journal_reward":\
"""As I watched, the squirrel tensed up and seemed to be gathering itself for something. I braced myself for an attack, but to my surprise, the squirrel simply exploded into a cloud of nuts. It was such a comical sight that I couldn't help but laugh out loud. In spite of the absurdity of the situation, it felt like a calm before the storm; I could feel upset brewing in the air.
""",
	"journal_art": "res://assets/journal/torments/Squirrel.jpg",
	"ai_prompts": [
		"This squirrel was the worst! It wouldn't let me pass.",
		"Never before have I encountered such a intimidating rodent { as the squirrel }.",
	],
	"replacement_keywords": {
		"torment_tag1": ["squirrels?"],
	},
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
				"starting_defence": +3,
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
}

#Title [The Baby]
#Keywords [torment, surrealism, absurdity, uncanny valley, stressful, responsibility, novelty, babysitting, crying, baby food, joy, dread]
#Summary  [I had to take care of a fussy baby. I am responsible enough?]
#Avoid [I woke up, wake up, awaken, I was dreaming]
const Baby = {
	"name": "Baby",
	"title": "The struggles of the unprepared babysitter",
	"journal_description":\
"""I was babysitting [url={torment_tag1}]a baby[/url] the other day and it was so fussy. It wouldn't stop crying no matter what I did. The worst part was that it was so new and strange to me. I had never taken care of a baby before, and I wasn't sure if I was doing everything right.

I got really stressed out trying to take care of it, and the whole experience just felt really surreal and absurd. It didn't help that the baby looked like it was right on the edge of the uncanny valley, which made me feel even more uneasy around it.
""",
	"journal_reward":\
"""I couldn't help but feel a sense of joy and wonder. Babies are so innocent and new, and it's amazing to see the world through their eyes for the first time.

Even though it was stressful taking care of the baby, overall I found the experience to be quite rewarding. I'm glad I got to babysit it and learn more about what it's like to take care of a child.
""",
	"journal_art": "res://assets/journal/torments/baby.jpeg",
	"ai_prompts": [
		"I found myself at babysitting duty. I did not feel ready.",
		"The situation was not optimal. The baby was already edging towards a tantrum and my hands were full.",
	],
	"replacement_keywords": {
		"torment_tag1": ["baby","babies","babysitting"],
	},
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
}
#	{
#		"journal_description":\
#			'I found myself cowering before [url={torment_tag1}]a three-eyed owl[/url]'\
#			+ ' while someone in the distance was [url={torment_tag2}]laughing at my aprehension.[/url]',
#		"journal_reward":\
#			'Through overcoming that weird experience, I felt wiser.',
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
#			'Through overcoming that weird experience, I felt wiser.',
#		"enemies": [
#			{
#				"definition": EnemyDefinitions.GASLIGHTER,
#			},
#			{
#				"definition": EnemyDefinitions.GASLIGHTER,
#			},
#		],
#		"journal_art": "res://assets/journal/gaslighter.jpeg"),
#	},



const ENEMIES = {
	"TheLaughingOnes": TheLaughingOnes,
	"TheCritic": TheCritic,
	"Fearmonger": Fearmonger,
	"Murmurs": Murmurs,
	"Clown": Clown,
	"Butterfly": Butterfly,
	"BrokenMirrors": BrokenMirrors,
	"Pialephant": Pialephant,
	"TheLightCalling": TheLightCalling,
	"Baby": Baby,
	"Squirrel": Squirrel,
	"Gaslighter": Gaslighter,
}

#Title [The Labyrinth]
#Keywords [torment, surrealism, meandering, disquietude, existentialism, lost,  calm, eerie, ever-changing, hopeless]
#Summary  [I remember maze walls enclosing me and no obvious way out...]
#Avoid [I woke up, wake up, awaken, I was dreaming]
const RushElite = {
	"name": "Labyrinth",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/RushElite.tscn")],
	"journal_description":\
"""I remember the first time I saw The Labyrinth. Walls of intricately carved stone enclosing me, with no obvious way out. It was disquieting, to say the least, and it wasn't long before I found myself hopelessly lost within its ever-changing corridors.

The sense of unease that The Labyrinth gives is like nothing else. It's a place where reality seems to blend with surrealism and there's a constant feeling of disquietude hanging over everything. It's an existential angst simulator if there ever was one!

Even now, long awake after my visit, I can still recall the calm but eerie atmosphere that pervades the entire place. It feels like something just beyond our understanding is waiting for us.
""",
	"journal_reward":\
"""The Labyrinth is a place of torment and confusion, but also one of great beauty. It's a surrealist's dream come true, with its ever-changing corridors and mysterious atmosphere. It can be disquieting and eerie at times, but it's also strangely calming.

For me, The Labyrinth represented a journey into the unknown. I woke up to what these infinite twists and turns represented; they were my own personal struggles, my battles with myself. It was an existential experience that left me changed for the better.
""",
	'journal_art': "res://assets/journal/advanced/Labyrinth.jpg",
}

#Title [The Bully]
#Keywords [torment, surrealism, beating, upset, crying, taunting, pushing, schoolyard, playground, glasses, break, upset, hopeless, hide, frustration]
#Avoid [I woke up, wake up, awaken, I was dreaming]
#Story Summary  [My mind took me back to uncomfortable memories of schoolyard bullying.]
#Conclusion Summary [This time, I fortunately knew how to respond.]
const Bully = {
	"name": "Bully",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Bully.tscn")],
	"journal_description":\
"""I could feel the weight of the bullies' stares on me as I made my way through the schoolyard. I knew they were plotting their next attack, and I had no idea how to defend myself. Suddenly, they descended upon me like a pack of wolves.  I tried to run, but they were too fast. They punched me, kicked me, and taunted me until I was crying and hopelessly hiding behind a bush. It seemed like it would never end
""",
	"journal_reward":\
"""The bully in my dream was symbolic of those harsh memories from my past. However, this time, I fortunately knew how to respond. I faced the bully head-on and refused to be intimidated. This may not have ended the bullying once and for all, but it made me feel stronger and more confident in myself.
""",
	'journal_art': "res://assets/journal/advanced/Bully.jpg",
}

const ELITES = {
	"RushElite": RushElite,
	"Bully": Bully
}

const Narcissus = {
	"name": "Narcissus",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Bosses/Narcissus.tscn")],
	"journal_description":\
"""I ran into Narcissus on the edge of a lake. They were as beautiful as I thought they would be, with their perfect skin and bright green eyes. But there was something different about them. They seemed vulnerable, almost hurt.

As if feeling my emotional probe, they turned to me while their mask came back up...
""",
	"journal_reward":\
"""I am not really sure what I was expecting when I ran into Narcissus. Maybe some validation? Or an explanation for their behavior? But all I got was a feeling of confusion and hurt.

Why did they act like that? What did I do wrong?

These questions echoed in my head as I walked away from the encounter, but I knew that I would never get any answers from them. They were too selfish and too wrapped up in their own ego to ever confess the truth.
""",
	'journal_art':
		[
			"res://assets/journal/advanced/Narcissus/Narcissus1.jpg",
			"res://assets/journal/advanced/Narcissus/Narcissus2.jpg",
			"res://assets/journal/advanced/Narcissus/Narcissus3.jpg",
			"res://assets/journal/advanced/Narcissus/Narcissus4.jpg",
			"res://assets/journal/advanced/Narcissus/Narcissus5.jpg"
		],
}

const BOSSES := {
	"Narcissus": Narcissus
}


const NCE := {
	"easy": {
		"MonsterTrain": "res://src/dreamscape/Run/NCE/Act1/MonsterTrain.gd",
		"SlayTheSpire": "res://src/dreamscape/Run/NCE/Act1/SlayTheSpire.gd",
		"SleepOfOblivion": "res://src/dreamscape/Run/NCE/Act1/SleepOfOblivion.gd",
		"CrystalShattering": "res://src/dreamscape/Run/NCE/Act1/CrystalShattering.gd",
		"PathosForAnxiety": "res://src/dreamscape/Run/NCE/Act1/PathosForAnxiety.gd",
		"Dollmaker": "res://src/dreamscape/Run/NCE/Act1/Dollmaker.gd",
		"Greed": "res://src/dreamscape/Run/NCE/Act1/Greed.gd",
		"PopPsychologist1": "res://src/dreamscape/Run/NCE/Act1/PopPsychologist1.gd",
	},
	"risky": {
		"Highwire": "res://src/dreamscape/Run/NCE/Act1/Highwire.gd",
		"Spider": "res://src/dreamscape/Run/NCE/Act1/Spider.gd",
		# Recurrence appears in Act1, but if it's not encountered, it stays locked
		"Recurrence1": "res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd",
	}
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.Act1)

static func get_act_number() -> int:
	return(1)
