# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'remove': '[Remove]: Pay {remove} released {remove_pathos}. Remove a card from your deck.',
		'progress': '[Progress]: Pay {progress} released {progress_pathos}. Progress a card in your deck 4 times.',
		'upgrade': '[Upgrade]: Pay {upgrade} released {upgrade_pathos}. Upgrade a random memory 2 times.',
		'leave': '[Leave]: Nothing Happens.'
	}

var amounts := {}
var pathos := {
	"remove": Terms.RUN_ACCUMULATION_NAMES.artifact,
	"progress": Terms.RUN_ACCUMULATION_NAMES.shop,
	"upgrade": Terms.RUN_ACCUMULATION_NAMES.nce,
}

var nce_result_fluff := {
		'remove': 'The stranger helped take some weight off my shoulders. Did he take more?',
		'progress': 'The stranger was friendly. He offered some wise words that I can no longer recall.',
		'upgrade': 'We reminisced about old times as he helped me recall fond memories.',
		'leave': 'Thinking it must have been a trap, I left. I hope I didn\'t offend him.',
	}

func _init():
	description = "A stranger called to me, claiming to be my childhood firend. Did I know him from somwehere?"

func begin() -> void:
	.begin()
	amounts["remove"] = round(globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.artifact) * 4)
	amounts["progress"] = round(
			globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.shop)
			* 5)
	amounts["upgrade"] = round(globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.nce) * 3)
	var scformat := {}
	for key in pathos:
		scformat[key] = amounts[key]
		scformat[key + "_pathos"] = pathos[key]
	for key in secondary_choices:
		secondary_choices[key] = secondary_choices[key].format(scformat).format(Terms.get_bbcode_formats(18))
	var disabled_choices = []
	if globals.player.memories.size() == 0:
		disabled_choices.append('upgrade')
	if globals.player.deck.get_progressing_cards().size() == 0:
		disabled_choices.append('progress')
	for type in pathos:
		if globals.player.pathos.released[pathos[type]] < amounts[type]:
			disabled_choices.append(type)
	for choice in disabled_choices:
		secondary_choices[choice] = "[color=red]" + secondary_choices[choice] + "[/color]"
	globals.journal.add_nested_choices(secondary_choices, disabled_choices)

func continue_encounter(key) -> void:
	if key in pathos:
		globals.player.pathos.modify_released_pathos(pathos[key], -amounts[key])
	match key:
		"remove":
			var selection_deck = globals.journal.spawn_selection_deck()
			selection_deck.auto_close = true
			selection_deck.initiate_card_removal(0)
			selection_deck.update_header("(Free Removal)")
			selection_deck.update_color(Color(0,1,0))
		"progress":
			var selection_deck = globals.journal.spawn_selection_deck()
			selection_deck.auto_close = true
			selection_deck.initiate_card_progress(0)
			selection_deck.update_header("(Free Progress for 4)")
			selection_deck.update_color(Color(0,1,0))
			selection_deck.connect("operation_performed", self, "_on_card_selected")
		"upgrade":
			var memory :MemoryObject = globals.player.get_random_memory()
			memory.upgrades_amount += 2
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

func _on_card_selected(operation_details: Dictionary) -> void:
	if operation_details.operation == "progress":
		var chosen_card: CardEntry = operation_details.card_entry
		chosen_card.upgrade_progress += 3
