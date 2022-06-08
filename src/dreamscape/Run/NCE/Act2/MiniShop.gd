# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

const COSTS := {
	"remove": 1,
	"progress": 2,
	"upgrade": 3,
}
const MEMORY_PROGRESS = 5
const CARD_PROGRESS = 6

var secondary_choices := {
		'remove': '[Remove]: Pay {bcolor:{remove} {masteries}:}. {gcolor:Remove a card:} from your deck.',
		'progress': '[Progress]: Pay {bcolor:{progress} {masteries}:}. {gcolor:Progress a card:} in your deck {card_progress} times.',
		'upgrade': '[Upgrade]: Pay {bcolor:{upgrade} {masteries}:}. {gcolor:Upgrade a random memory:} {memory_progress} times.',
		'leave': '[Leave]: Nothing Happens.'
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
	var scformat := {
		"card_progress": CARD_PROGRESS,
		"memory_progress": MEMORY_PROGRESS,
	}
	for key in COSTS:
		scformat[key] = COSTS[key]
	var disabled_choices = []
	if globals.player.memories.size() == 0:
		disabled_choices.append('upgrade')
	if globals.player.deck.get_progressing_cards().size() == 0:
		disabled_choices.append('progress')
	for type in COSTS:
		if globals.player.pathos.available_masteries < COSTS[type]:
			disabled_choices.append(type)
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key in COSTS:
		globals.player.pathos.available_masteries -= COSTS[key]
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
			selection_deck.update_header("(Free Progress for 6)")
			selection_deck.update_color(Color(0,1,0))
			selection_deck.connect("operation_performed", self, "_on_card_selected")
		"upgrade":
			var memory :MemoryObject = globals.player.get_random_memory()
			memory.upgrades_amount += MEMORY_PROGRESS
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

func _on_card_selected(operation_details: Dictionary) -> void:
	if operation_details.operation == "progress":
		var chosen_card: CardEntry = operation_details.card_entry
		chosen_card.upgrade_progress += CARD_PROGRESS
