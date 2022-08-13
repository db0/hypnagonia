extends NonCombatEncounter

const MASTERIES_AMOUNT := {
	"progress": round(Pathos.MASTERY_BASELINE * 0.3),
	"upgrade": round(Pathos.MASTERY_BASELINE * 0.6),
	"remove": round(Pathos.MASTERY_BASELINE * 1.5),
	"leave": 0,
}

const journal_description =\
"""I remember mysel breaking apart the Crystalized snapshots of myself with heavy strikes of my pick.
It took an immense amount of feeling to make each blow, but the resulting release made me feel wiser. 
I grabbed the tool, ready to strike another blow at the next crystal. It's been a long time coming...
"""
const ai_prompts:= [
	"I remember mysel breaking apart the Crystalized snapshots of myself with"
]

var secondary_choices := {
		'progress': '[Ermbaraz]: Spend {bcolor:{progress_amount} {mastery}:}. {gcolor:Progress the least progressed card by 4:}.',
		'upgrade': '[Feelyne]: Spend {bcolor:{upgrade_amount} {masteries}:}. {gcolor:Upgrade the most progressed card:}.',
		'remove': '[Depressium]: Spend {bcolor:{remove_amount} {masteries}:}. {gcolor:Remove a card from your deck:}.',
		'leave': '[Stop]: Nothing Happens.',
	}
var pathos_choice_payments := {}

func _init():

	introduction.setup_with_vars("Crystal Shattering",journal_description, '', ai_prompts)
	prepare_journal_art(load("res://assets/journal/nce/Crystal Shattering.jpg"))
func begin() -> void:
	.begin()
	var scformat = {}
	for option in ['progress', 'upgrade', 'remove']:
		scformat[option+ '_amount'] = MASTERIES_AMOUNT[option]
	var disabled_choices := []
	for type in ['progress', 'upgrade', 'remove']:
		if MASTERIES_AMOUNT[type] > globals.player.pathos.available_masteries:
			disabled_choices.append(type)
	var option_card
	if not 'progress' in disabled_choices:
		option_card = globals.player.deck.get_upgradable_card_type("least_progress")
		if not option_card:
			disabled_choices.append('progress')
	if not 'upgrade' in disabled_choices:
		option_card = globals.player.deck.get_upgradable_card_type("most_progress")
		if not option_card:
			disabled_choices.append('upgrade')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	globals.player.pathos.available_masteries -= MASTERIES_AMOUNT[key]
	match key:
		"progress":
			var card_entry : CardEntry = globals.player.deck.get_upgradable_card_type("least_progress")
			if card_entry:
				card_entry.upgrade_progress += 4
		"upgrade":
			var card_entry : CardEntry = globals.player.deck.get_upgradable_card_type("most_progress")
			if card_entry:
				card_entry.upgrade_progress = card_entry.upgrade_threshold
		"remove":
			var selection_deck = globals.journal.spawn_selection_deck()
			selection_deck.auto_close = true
			selection_deck.initiate_card_removal(0)
			selection_deck.update_header("(Free Removal)")
			selection_deck.update_color(Color(0,1,0))
	end()
	globals.journal.display_nce_rewards('')
