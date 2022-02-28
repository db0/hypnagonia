extends NonCombatEncounter

var secondary_choices := {
		'swing': '[Swing For It]: 50% chance to take 5 {anxiety}. Transform one {control} card to a random {action}.',
		'shout': '[Shout for Help]: 30% chance to take 7 {anxiety}. Transform one {control} card to a random {control}.',
		'hang': '[Hang Tighter]: 50% change to lose 4 max {anxiety}. 50% chance to gain a {chasm}',
	}

var nce_result_fluff := {
		'swing': "I use my cement hand to build momentum and swung for the edge.",
		'shout': "I thought I saw someone I knew walking behind the trees so I called out.",
		'hang': "I wrapped myself around that branch as tight as I could.",
	}


func _init():
	description = "I found myself walking between a cliff and an impassable forest while one of my hands was wrapped in cement. "\
			+ "The trees were impervious and the fall high so I was treading carefully. "\
			+ "At one point, as I was holding on to a branch, I lost my footing and ended up hanging on one hand over the chasm."
	prepare_journal_art(preload("res://assets/journal/nce/chasm.jpeg"))
	
func begin() -> void:
	.begin()
	var scformat = {
		"chasm": _prepare_card_popup_bbcode("Chasm", "a special card"),
	}
	secondary_choices['swing'] = secondary_choices['swing'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['shout'] = secondary_choices['shout'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['hang'] = secondary_choices['hang'].format(scformat).format(Terms.get_bbcode_formats(18))
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	match key:
		"swing", "shout":
			var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
			selection_deck.popup_exclusive = true
			# warning-ignore:return_value_discarded
			selection_deck.connect("operation_performed", self, "_on_card_removed", [key])
			selection_deck.card_filters.append(CardFilter.new("Type", "Control"))
			selection_deck.auto_close = true
			selection_deck.initiate_card_removal(0)
		"hang":
			var rng_roll = CFUtils.randi_range(1,100)
			if rng_roll <= 50:
				nce_result_fluff['hang'] += "\nHolding my eyes tight, I was trying to will myself out of this situation. "\
						+ "Then I heard a crack..."
				# warning-ignore:narrowing_conversion
				globals.player.health -= 4
			else:
				nce_result_fluff['hang'] += "\nNothing else to do but peer into the depths. "\
						+ "This was quite nice actually..."
				# warning-ignore:return_value_discarded
				globals.player.deck.add_new_card("Chasm")
			end()
			globals.journal.display_nce_rewards(nce_result_fluff[key])


func _on_card_removed(operation_details: Dictionary, key: String) -> void:
	var rng_roll = CFUtils.randi_range(1,100)
	var card_type: String
	if key == "swing":
		card_type = "Action"
		if rng_roll <= 50:
			nce_result_fluff[key] += "\nAt the last second, my fingers gave out and I flung wildly, "\
					+ "ending up [url={url}]dancing precariously on the edge[/url]."
			globals.player.damage += 5
		else:
			nce_result_fluff[key] += "\nThe extra weight on my other arm allowed for a fluid jumping motion,"\
					+ "and I landed on the other side [url={url}]like a pro[/url]."

	else:
		card_type = "Control"
		if rng_roll <= 30:
			nce_result_fluff[key] += "\nI shouted and shouted but the trees [url={url}]just kept bouncing my words back to me[/url]."
			globals.player.damage += 7
		else:
			nce_result_fluff[key] += "\nThanfully I soon saw movement on the other side. [url={url}]Help was on the way[/url]..."
	var transform_cards = globals.player.compile_card_type(
			card_type,
			["Common", "Uncommon", "Rare"],
			operation_details["upgraded"])
	CFUtils.shuffle_array(transform_cards)
	var card_name = transform_cards[0]
	# warning-ignore:return_value_discarded
	globals.player.deck.add_new_card(card_name, 0)
	globals.journal.prepare_popup_card(card_name)
	var popup_tag = NCE_POPUP_DICT.duplicate(true)
	popup_tag["name"] = card_name
	var tag_format = {"url": JSON.print(popup_tag)}
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key].format(tag_format))
