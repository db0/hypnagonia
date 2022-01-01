# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var amounts := {
	"emotions": 0.09,
	"knowledge": 0.09,
	"memories": 0.04,
	"bliss": 0.1,
}

var secondary_choices := {
		'emotions': '[Emotions]: Reduce your max {anxiety} threshold by {emotions}. Gain a large amount of a random released pathos.',
		'knowledge': '[Knowledge]: Reduce your max {anxiety} threshold by {knowledge}. Gain a random {understanding} card fully progressed.',
		'memories': '[Memories]: Reduce your max {anxiety} threshold by {memories}. Upgrade a random memory.',
		'bliss': '[Bliss]: Reduce your max {anxiety} threshold by {bliss} and exit loop.',
	}

var nce_result_fluff := "It was better to try and forget the whole thing."

func _init():
	# TODO: Add story
	description = "<Risky Dream 3 - Story Fluff to be Done>. Select one Option...."

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
	if globals.player.memories.size() == 0: 
		disabled_choices.append('memories')
		secondary_choices['memories'] = "[color=red]" + secondary_choices['memories'] + "[/color]"
	globals.journal.add_nested_choices(secondary_choices_dupe, disabled_choices)
	
func continue_encounter(key) -> void:
	var reduction = amounts[key]
	globals.player.health -= reduction
	amounts[key] += 1
	match key:
		"emotions":
			var pathos = globals.player.pathos.grab_random_pathos() 
			var pathos_amount = globals.player.pathos.get_progression_average(pathos) * 6
			globals.player.pathos.modify_released_pathos(pathos, pathos_amount)
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
