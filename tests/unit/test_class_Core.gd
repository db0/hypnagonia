extends "res://tests/UTCommon.gd"


class TestCardDefinitions:
	extends "res://tests/UTCommon.gd"

	func test_all_upgrades_exist():
		for card_name in cfc.card_definitions:
			for card_upgrades in cfc.card_definitions[card_name].get("_upgrades", []):
				# We're not using assert_has because the printout is too big
				assert_true(cfc.card_definitions.has(card_upgrades), card_upgrades + " is defined")

	func test_all_cards_scripted():
		var known_unscripted_card_names = [
			"GUT",
			"Lacuna",
			"Hubris",
			"Distracted",
			"Universal Component",
		]
		for c in known_unscripted_card_names:
			for upgrade in cfc.card_definitions.get(c, {}).get('_upgrades',[]):
				known_unscripted_card_names.append(upgrade)
		var pending_scripting_card_names = [
			"War Paint"
		]
		for card_name in cfc.card_definitions:
			if card_name in known_unscripted_card_names:
				continue
			if card_name in pending_scripting_card_names:
				pending("Write script for: " + card_name)
				continue
			assert_true(cfc.unmodified_set_scripts.has(card_name), card_name + " is scripted")

	func test_rarities_matching():
		for archetype in Aspects.get_complete_archetype_list():
			for rarity in ["Basic","Common","Uncommon","Rare","Special"]:
				for card_name in Aspects.get_all_cards_in_archetype(archetype, [rarity]):
					assert_eq(cfc.card_definitions[card_name]["_rarity"], rarity,
						"%s card rarity matches archetype rarity" % [card_name])
					for upgrade_name in HUtils.get_all_card_variants(card_name):
						assert_eq(cfc.card_definitions[upgrade_name]["_rarity"], rarity,
							"%s upgraded card rarity matches archetype rarity" % [upgrade_name])
