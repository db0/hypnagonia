class_name SingleRun
extends Reference

const EARLY_ENEMIES := [
	{
		"journal_description":\
			'I found myself between [url={torment_tag1}]a pair of featureless creeps laughing[/url] at me.',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.THE_LAUGHING_ONE,
			EnemyDefinitions.THE_LAUGHING_ONE,
		],
		"journal_art": preload("res://assets/journal/the_laughing_one.jpeg"),
	},
	{
		"journal_description":\
			'Was that [url={torment_tag1}]a curious owl with three eyes[/url] staring at me?',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"journal_art": preload("res://assets/journal/fearmonger.jpeg"),
		"enemies": [
			EnemyDefinitions.FEARMONGER,
		]
	},
	{
		"journal_description":\
			'I saw [url={torment_tag1}]a strange form with a head like a lamp[/url] moving towards me.',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.GASLIGHTER,
		],
		"journal_art": preload("res://assets/journal/gaslighter.jpeg"),
	},
]

const ENEMIES := [
	{
		"journal_description":\
			'[url={torment_tag1}]<Description to be added>[/url].',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.UNNAMED_ENEMY_1,
		],
#		"journal_art": preload("res://assets/journal/the_critic.jpeg"),
	},
	{
		"journal_description":\
			'Strange furry animals with massive noses (or were they trunks) [url={torment_tag1}]started sniffing at me, and pointing out my weaknesses[/url].',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.THE_CRITIC,
			EnemyDefinitions.THE_CRITIC,
		],
		"journal_art": preload("res://assets/journal/the_critic.jpeg"),
	},
	{
		"journal_description":\
			'I somehow ended in a peculiar argument [url={torment_tag1}]with a clown[/url].',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.CLOWN,
		],
		"journal_art": preload("res://assets/journal/clown.jpeg"),
	},
	{
		"journal_description":\
			'The [url={torment_tag1}]cackling people I could not distinguish[/url] once again hounded me.',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.THE_LAUGHING_ONE,
			EnemyDefinitions.THE_LAUGHING_ONE,
			EnemyDefinitions.THE_LAUGHING_ONE,
		],
		"journal_art": preload("res://assets/journal/the_laughing_one.jpeg"),
	},
	{
		"journal_description":\
			'I found myself cowering before [url={torment_tag1}]a three-eyed owl[/url]'\
			+ ' while someone in the distance was [url={torment_tag2}]laughing at my aprehension.[/url]',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.FEARMONGER,
			EnemyDefinitions.THE_LAUGHING_ONE,
		]
	},
	{
		"journal_description":\
			'I discovered that [url={torment_tag1}]the lamps that should not be[/url] were multiplying.',
		"journal_reward":\
			'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
		"enemies": [
			EnemyDefinitions.GASLIGHTER,
			EnemyDefinitions.GASLIGHTER,
		],
		"journal_art": preload("res://assets/journal/gaslighter.jpeg"),
	},
]

const BOSSES := {
	"Narcissus": {
		"scene": preload("res://src/dreamscape/CombatElements/Enemies/Bosses/Narcissus.tscn"),
		"journal_description":\
			'I found someone I am sure I know, but I can\'t quite remember who.'\
			+ 'I found them gazing in a mirror, or was it a lake? They turned their attention to me...',
		"journal_reward":\
			'Through the many lies and denials, [url=boss_card_draft]I cornered the truth out of them.[/url]'\
			+ 'and for once felt like [url=boss_artifact]I was getting somewhere[/url].',
	}
}


var remaining_early_enemies := EARLY_ENEMIES.duplicate(true)
var remaining_enemies := ENEMIES.duplicate(true)
var boss_name : String
var current_encounter

func setup() -> void:
	CFUtils.shuffle_array(remaining_early_enemies)
	CFUtils.shuffle_array(remaining_enemies)
	var boss_choices := BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]

func generate_journal_choices() -> Array:
	var journal_options := []
	var next_enemy
	if globals.encounter_number >= 7:
		journal_options.append(BossEncounter.new(BOSSES[boss_name], boss_name))
	else:
		if globals.encounter_number <= 3:
			next_enemy = remaining_early_enemies.pop_back()
		else:
			next_enemy = remaining_enemies.pop_back()
			if globals.deep_sleeps == 0:
				journal_options.append(preload("res://src/dreamscape/Run/NCE/Rest.gd").new())
		journal_options.append(EnemyEncounter.new(next_enemy))
	return(journal_options)
