# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'remove': '[Remove]: Pay {bcolor:{remove} {remove_pathos}:}. {gcolor:Remove a card:} from your deck.',
		'progress': '[Progress]: Pay {bcolor:{progress} {progress_pathos}:}. {gcolor:Progress a card:} in your deck 4 times.',
		'upgrade': '[Upgrade]: Pay {bcolor:{upgrade} {upgrade_pathos}:}. {gcolor:Upgrade a random memory:} 2 times.',
		'leave': '[Leave]: Nothing Happens.'
	}

var amounts := {}
var pathos_types := {
	"remove": globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact],
	"progress": globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.shop],
	"upgrade": globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce],
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
	amounts["remove"] = round(pathos_types["remove"].get_progression_average() * 4)
	amounts["progress"] = round(pathos_types["progress"].get_progression_average() * 5)
	amounts["upgrade"] = round(pathos_types["upgrade"].get_progression_average() * 3)
	var scformat := {}
	for key in pathos_types:
		scformat[key] = amounts[key]
		scformat[key + "_pathos"] = '{released_%s}' % [pathos_types[key].name]
	var disabled_choices = []
	if globals.player.memories.size() == 0:
		disabled_choices.append('upgrade')
	if globals.player.deck.get_progressing_cards().size() == 0:
		disabled_choices.append('progress')
	for type in pathos_types:
		if pathos_types[type].released < amounts[type]:
			disabled_choices.append(type)
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key in pathos_types:
		var pathos_type : PathosType = pathos_types[key]
		pathos_type.spend_pathos(amounts[key])
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
