# Gives three choices, for candy
# Each candy will remove a card from the deck and replace it with another
# The colour of the candy represents the card types removed/added
# but the player does not know which colour removes and which adds
# before they eat it.

extends NonCombatEncounter

const SPECIAL_REWARD_ARTIFACT = "PerturbationHeal"

var secondary_choices := {}
var pathos_choice_payments := {}
func _init():
	description = "I somehow found myself in front of [color=#FFC0CB]The Candyman[/color]. They offered me, a choice of a multicoloured candy. I love candy!"

func begin() -> void:
	.begin()
	# Candy Colour BBCode
	var ccbbc = "[color={ccolour}]{cstring}[/color]"
	var candies := []
	var candies_bbc := []
	# Player gets 3 candy choices
	var colours = HConst.COLOUR_MAP.keys()
	for colour in colours.duplicate():
		var card_filter := CardFilter.new("Type", HConst.COLOUR_MAP[colour])
		if globals.player.deck.filter_cards(card_filter).size() < 1:
			colours.erase(colour)
	while candies.size() < 3:
		# Each candy has 2 colours
		var candy_colours := []
		var cc_bbformat := []
		for _iter in range(2):
			CFUtils.shuffle_array(colours)
			var cformat: Dictionary
			if colours[0] in candy_colours:
				cformat = {
					"ccolour": colours[0].to_lower(),
					"cstring": "Pure " + colours[0].to_lower()
					}
				cc_bbformat = [ccbbc.format(cformat)]
			else:
				cformat = {
					"ccolour": colours[0].to_lower(),
					"cstring": colours[0].to_lower()
					}
				cc_bbformat.append(ccbbc.format(cformat))
			candy_colours.append(colours[0])
			# This ensures a same colour candy won't appear as, for example, "Blue/Blue"
		var candy_exists := false
		for candy in candies:
			# That's the only way to compare the arrays without
			# always having the same sorting of colours displayed.
			var dcc = candy_colours
			var c = candy
			dcc.sort()
			c.sort()
			if dcc == c:
				candy_exists = true
		if not candy_exists:
			candies.append(candy_colours)
			candies_bbc.append(cc_bbformat)
		# If the player has only one type of card in their deck, we have to
		# break here to avoid an infinite loop
		if colours.size() == 1:
			break
	var choice_strings = [
		'[{candy_key}] Eat a delicious candy.',
		'[{candy_key}] Eat a pretty candy.',
		'[{candy_key}] Eat an aromatic candy.',
	]
	CFUtils.shuffle_array(choice_strings)
	for index in range(candies.size()):
		var candy_key : String = CFUtils.array_join(candies_bbc[index - 1], '/')
		secondary_choices[candies[index - 1]] = choice_strings.pop_back().format({"candy_key": candy_key})
	secondary_choices['leave'] ='[Leave]: Eat noting.'
	globals.journal.add_nested_choices(secondary_choices, [])

func continue_encounter(key) -> void:
	if typeof(key) == TYPE_ARRAY:
		# We shuffle the array so that the colour choices are random.
		CFUtils.shuffle_array(key)
		var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
		# warning-ignore:return_value_discarded
		selection_deck.connect("operation_performed", self, "_on_card_removed", [key])
		selection_deck.card_filters.append(CardFilter.new("Type", HConst.COLOUR_MAP[key[0]]))
		selection_deck.auto_close = true
		selection_deck.initiate_card_removal(0)
		var transmute_format = {
			"select": HConst.COLOUR_MAP[key[0]],
			"transmute": HConst.COLOUR_MAP[key[1]]
		}
		selection_deck.update_header("(Choose {select} to transform into {transmute})".format(transmute_format))
		selection_deck.update_color(Color(0,1,0))
	else:
		end()
		globals.journal.display_nce_rewards('')

func _on_card_removed(operation_details: Dictionary, candy: Array) -> void:
	var removed_rarity = cfc.card_definitions[operation_details["card_name"]].get("_rarity")
	var rarities = [removed_rarity]
	if removed_rarity in ["Basic", "Perturbation"]:
		rarities = ["Common"]
	elif removed_rarity in ["Received"]:
		rarities = ["Common", "Uncommon", "Rare"]
	var transmute_cards = globals.player.compile_card_type(
			HConst.COLOUR_MAP[candy[1]],
			rarities,
			operation_details["upgraded"])
	CFUtils.shuffle_array(transmute_cards)
	if transmute_cards.size() == 0:
		# If we cannot find that card type among the specified rarity
		# Then we start expanding our search
		# We put this order, so that we look for uncommons when we start from rares or commons only
		for missing_rarity in ["Uncommon", "Rare", "Common"]:
			if not missing_rarity in rarities:
				rarities.append(missing_rarity)
				transmute_cards = globals.player.compile_card_type(
						HConst.COLOUR_MAP[candy[1]],
						rarities,
						operation_details["upgraded"])
				CFUtils.shuffle_array(transmute_cards)
				if transmute_cards.size() > 0:
					break
	# This should almost never happen, but if for some reason an archetype
	# doesn't have a card Type at any rarity, we just give this message
	# Possible spot for an EASTER EGG artifact compensation?
	if transmute_cards.size() == 0:
		end()
		globals.journal.display_nce_rewards("The candy turns to ashes in your mouth and the Candyman is nowhere to be seen anymore.")
		return
	var card_name = transmute_cards[0]
	# warning-ignore:return_value_discarded
	globals.player.deck.add_new_card(card_name, operation_details["progress"])
	globals.journal.prepare_popup_card(card_name)
	var tastes = ["strange", "concerning", "bitter", "sweet", "sour", "tarty", "rugose"]
	CFUtils.shuffle_array(tastes)
	var tag_format := {"taste": tastes[0]}
	var reward_desc := "The taste is {taste} and I realized [url={url}]it altered my perception[/url] within the dream."
	if HConst.COLOUR_MAP[candy[1]] == "Perturbation"\
			and not SPECIAL_REWARD_ARTIFACT in globals.player.get_all_artifact_names():
		globals.player.add_artifact(SPECIAL_REWARD_ARTIFACT)
		reward_desc += "\nThe weird taste made me crave for more!"
	var popup_tag = NCE_POPUP_DICT.duplicate(true)
	popup_tag["name"] = card_name
	tag_format["url"] = JSON.print(popup_tag)
	end()
	globals.journal.display_nce_rewards(reward_desc.format(tag_format))
