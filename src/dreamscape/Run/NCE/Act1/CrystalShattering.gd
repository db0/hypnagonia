# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

const PATHOS_PCT_MINIMUMS := {
	"progress": 0.1,
	"upgrade": 0.3,
	"remove": 0.6,
}

var secondary_choices := {
		'progress': '[Ermbaraz]: Lose {bcolor:all released (min {lowest_pathos_cost}%) {lowest_pathos}:}. {gcolor:Progress the least progressed card by 4:}.',
		'upgrade': '[Feelyne]: Lose {bcolor:all released (min {middle_pathos_cost}%) {middle_pathos}:}. {gcolor:Upgrade the most progressed card:}.',
		'remove': '[Depressium]: Lose {bcolor:all released (min {highest_pathos_cost}%) {highest_pathos}:}. {gcolor:Remove a card from your deck:}.',
		'leave': '[Stop]: Nothing Happens.',
	}
var pathos_choice_payments := {}

func _init():
	description =\
"""I remember mysel breaking apart the Crystalized snapshots of myself with heavy strikes of my pick.
It took an immense amount of feeling to make each blow, but the resulting release made me feel wiser. 
I grabbed the tool, ready to strike another blow at the next crystal. It's been a long time coming...
"""

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org()
#	print_debug(pathos_org)
	var pathos_type_lowest : PathosType = pathos_org["lowest_pathos"]["selected"]
	var pathos_type_middle : PathosType  = pathos_org["middle_pathos"]["selected"]
	var pathos_type_highest : PathosType  = pathos_org["highest_pathos"]["selected"]
	var lowest_pathos = pathos_type_lowest.name
	var middle_pathos = pathos_type_middle.name
	var highest_pathos = pathos_type_highest.name
	var scformat = {
		"lowest_pathos": '{released_%s}' % [lowest_pathos],
		"lowest_pathos_cost": PATHOS_PCT_MINIMUMS["progress"] * 100,
		"middle_pathos": '{released_%s}' % [middle_pathos],
		"middle_pathos_cost": PATHOS_PCT_MINIMUMS["upgrade"] * 100,
		"highest_pathos": '{released_%s}' % [highest_pathos],
		"highest_pathos_cost": PATHOS_PCT_MINIMUMS["remove"] * 100,
	}
	pathos_choice_payments["progress"]  = {
		"pathos": lowest_pathos,
		"pathos_type": pathos_type_lowest,
	}
	pathos_choice_payments["upgrade"] = {
		"pathos": middle_pathos,
		"pathos_type": pathos_type_middle,
	}
	pathos_choice_payments["remove"] = {
		"pathos": highest_pathos,
		"pathos_type": pathos_type_highest,
	}
	var disabled_choices := []
	for type in ['progress', 'upgrade', 'remove']:
		secondary_choices[type] = secondary_choices[type].format(scformat)
		if pathos_choice_payments[type]["pathos_type"].get_progress_pct() < PATHOS_PCT_MINIMUMS[type]:
			secondary_choices[type] = "[color=red]" + secondary_choices[type] + "[/color]"
			disabled_choices.append(type)
	var option_card
	if not 'progress' in disabled_choices:
		option_card = globals.player.deck.get_upgradable_card_type("least_progress")
		if not option_card:
			secondary_choices['progress'] = "[color=red]" + secondary_choices['progress'] + "[/color]"
			disabled_choices.append('progress')
	if not 'upgrade' in disabled_choices:
		option_card = globals.player.deck.get_upgradable_card_type("most_progress")
		if not option_card:
			secondary_choices['upgrade'] = "[color=red]" + secondary_choices['upgrade'] + "[/color]"
			disabled_choices.append('upgrade')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
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
	if key != "leave":
		var pathos_type : PathosType = pathos_choice_payments[key]["pathos_type"]
		pathos_type.spend_pathos(pathos_type.released)
	end()
	globals.journal.display_nce_rewards('')
