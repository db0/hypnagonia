extends NonCombatEncounter

const MEMORY_PROGRESS = 4
const RELEASED_PATHOS_MASTERIES = 2
const PATHOS = Terms.RUN_ACCUMULATION_NAMES.elite
const REPRESSED_PATHOS_AVG_MULTIPLIER = 1
const CARD_PROGRESS = 3

var secondary_choices := {
		'card': '[Card]: {bcolor:Remove an upgraded card:}. {gcolor:Upgrade a card:}.',
		'memory': '[Memory]: {bcolor:Remove an upgraded card:}. {gcolor:Upgrade a random Memory:} {memory_progress} times.',
		'pathos': '[Pathos]: {bcolor:Remove an upgraded card:}. Gain {gcolor:{masteries_amount} {mastery_pathos} masteries:}.',
		'progress': '[Progress]: Gain {bcolor:{repressed_pathos_amount} {repressed_pathos}:}. {gcolor:Progress a random card:} by {progress}',
	}

# TODO: Fluff
var nce_result_fluff := {
		'card': "",
		'memory': "",
		'pathos': "",
		'progress': "",
	}

var repressed_pathos_amount: int
var pathos_type : PathosType = globals.player.pathos.pathi[PATHOS]

func _init():
	# TODO: Fluff
	description = "<Multiple Options - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	repressed_pathos_amount = round(pathos_type.get_progression_average()
			 * REPRESSED_PATHOS_AVG_MULTIPLIER * CFUtils.randf_range(0.8,1.2))
	var scformat = {
		"memory_progress": MEMORY_PROGRESS,
		"masteries_amount": RELEASED_PATHOS_MASTERIES,
		"repressed_pathos_amount": "some",
		"repressed_pathos": '{repressed_%s}' % [PATHOS],
		"mastery_pathos": PATHOS,
		"progress": CARD_PROGRESS,
	}
	var disabled_choices = []
	if globals.player.deck.count_progressing_cards() == 0:
		secondary_choices['progress'] = '[Leave]: Nothing happens.'
	if globals.player.deck.count_upgraded_cards() == 0:
		disabled_choices.append('card')
		disabled_choices.append('memory')
		disabled_choices.append('pathos')
	if globals.player.memories.size() == 0 and not 'memory' in disabled_choices:
		disabled_choices.append('memory')
	if globals.player.deck.count_progressing_cards() == 0 and not 'card' in disabled_choices:
		disabled_choices.append('card')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key != 'progress':
		var card_filters = [CardFilter.new('_is_upgrade', true)]
		var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
		selection_deck.popup_exclusive = true
		# warning-ignore:return_value_discarded
		selection_deck.connect("operation_performed", self, "_on_upgraded_card_selected", [key])
		selection_deck.auto_close = true
		selection_deck.card_filters = card_filters
		selection_deck.initiate_card_selection(0)
		selection_deck.update_color(Color(0,1,0))
	elif globals.player.deck.count_progressing_cards() > 0:
			pathos_type.repressed +=  repressed_pathos_amount
			var cards = globals.player.deck.get_progressing_cards()
			CFUtils.shuffle_array(cards)
			var card: CardEntry = cards[0]
			card.upgrade_progress += CARD_PROGRESS
	end()
	globals.journal.display_nce_rewards('')

func _on_upgraded_card_selected(operation_details: Dictionary, key: String) -> void:
	var chosen_card: CardEntry = operation_details.card_entry
	globals.player.deck.remove_card(chosen_card)
	match key:
		"card":
			var selection_deck = globals.journal.spawn_selection_deck()
			selection_deck.auto_close = true
			selection_deck.initiate_card_progress(0)
			selection_deck.update_header("(Free Upgrade)")
			selection_deck.update_color(Color(0,1,0))
			selection_deck.connect("operation_performed", self, "_on_card_selected")
		"memory":
			var existing_memory = globals.player.get_random_memory()
			if existing_memory:
				existing_memory.upgrades_amount += MEMORY_PROGRESS
		"pathos":
			for iter in RELEASED_PATHOS_MASTERIES:
				pathos_type.level_up()

func _on_card_selected(operation_details: Dictionary) -> void:
	if operation_details.operation == "progress":
		var chosen_card: CardEntry = operation_details.card_entry
		chosen_card.upgrade_progress = chosen_card.upgrade_threshold
		globals.journal._reveal_entry(globals.journal.upgrade_journal, true)
