extends NonCombatEncounter

const MASTERIES_AMOUNT := round(Pathos.MASTERY_BASELINE * 3.3)
const journal_description = "<Risky Dream 3 - Story Fluff to be Done>. Select one Option...."

var amounts := {
	"emotions": 0.06,
	"knowledge": 0.09,
	"memories": 0.03,
	"bliss": 0.1,
	"masteries_amount": MASTERIES_AMOUNT,
}

var secondary_choices := {
		'emotions': '[Emotions]: {bcolor:-{emotions} max {anxiety}:}. {gcolor:Gain {masteries_amount} masteries:}',
		'knowledge': '[Knowledge]: {bcolor:-{knowledge} max {anxiety}:}. Gain {gcolor:a random {understanding} card:} fully progressed.',
		'memories': '[Memories]: {bcolor:-{memories} max {anxiety}:}. {gcolor:Upgrade a random memory:}.',
		'bliss': '[Bliss]: {bcolor:-{bliss} max {anxiety}:} and exit loop.',
	}

var nce_result_fluff := "It was better to try and forget the whole thing."

func _init():
	# TODO: Add story
	introduction.setup_with_vars("Risky Event 3",journal_description, "")

func begin() -> void:
	.begin()
	repeat_choices()

func repeat_choices() -> void:
	var secondary_choices_dupe := {}
	for key in secondary_choices:
		if amounts[key] < 1:
			amounts[key] = round(globals.player.health * amounts[key])
			if amounts[key] < 5:
				amounts[key] = 5
		secondary_choices_dupe[key] = secondary_choices[key].format(amounts).format(Terms.get_bbcode_formats(18))
	var disabled_choices = []
	if globals.player.health < 10:
		for key in secondary_choices:
			if key =="bliss": continue
			disabled_choices.append(key)
	if globals.player.memories.size() == 0: 
		disabled_choices.append('memories')
	_prepare_secondary_choices(secondary_choices_dupe, {}, disabled_choices)
	
func continue_encounter(key) -> void:
	var reduction = amounts[key]
	globals.player.health -= reduction
	amounts[key] += 1
	match key:
		"emotions":
			globals.player.pathos.available_masteries += MASTERIES_AMOUNT
			repeat_choices()
		"knowledge":
			var card_entry = globals.player.deck.add_new_card(Understanding.get_random_understanding())
			card_entry.upgrade_progress = card_entry.upgrade_threshold
			repeat_choices()
		"memories":
			var memory : MemoryObject = globals.player.get_random_memory()
			memory.upgrade()
			repeat_choices()
		"bliss":
			end()
			globals.journal.display_nce_rewards(nce_result_fluff)
