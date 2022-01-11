# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'progress': '[Progress]: Lose {lowest_pathos_cost} released {lowest_pathos}. Progress the least progressed card by 4.',
		'upgrade': '[Upgrade]: Lose {middle_pathos_cost} released {middle_pathos}. Upgrade the most progressed card.',
		'remove': '[Remove]: Lose {highest_pathos_cost} released {highest_pathos}. Remove a card from your deck.',
		'leave': '[Leave]: Nothing Happens.',
	}
var pathos_choice_payments := {}

func _init():
	description = "<Multiple Options - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org()
#	print_debug(pathos_org)
	var highest_pathos = pathos_org["highest_pathos"]["selected"]
	var lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var middle_pathos = pathos_org["middle_pathos"]["selected"]
	var lowest_pathos_cost = globals.player.pathos.get_progression_average(lowest_pathos) * 2
	var middle_pathos_cost = globals.player.pathos.get_progression_average(middle_pathos) * 3
	var highest_pathos_cost = globals.player.pathos.get_progression_average(highest_pathos) * 3
	var scformat = {
		"lowest_pathos": lowest_pathos,
		"lowest_pathos_cost":  lowest_pathos_cost,
		"middle_pathos": middle_pathos,
		"middle_pathos_cost":  middle_pathos_cost,
		"highest_pathos": highest_pathos,
		"highest_pathos_cost":  highest_pathos_cost,
	}
	pathos_choice_payments["progress"]  = {
		"pathos": lowest_pathos,
		"cost": lowest_pathos_cost
	}
	pathos_choice_payments["upgrade"] = {
		"pathos": middle_pathos,
		"cost": middle_pathos_cost
	}
	pathos_choice_payments["remove"] = {
		"pathos": highest_pathos,
		"cost": highest_pathos_cost
	}
	for key in secondary_choices:
		secondary_choices[key] = secondary_choices[key].format(scformat).format(Terms.get_bbcode_formats(18))	
	var disabled_choices := []
	for type in ['progress', 'upgrade', 'remove']:
		secondary_choices[type] = secondary_choices[type].format(scformat)
		if globals.player.pathos.released[pathos_choice_payments[type]["pathos"]]\
				< pathos_choice_payments[type]["cost"]:
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
	globals.journal.add_nested_choices(secondary_choices, disabled_choices)

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
		globals.player.pathos.released[pathos_choice_payments[key]["pathos"]]\
				-= pathos_choice_payments[key]["cost"]
	end()
	globals.journal.display_nce_rewards('')
