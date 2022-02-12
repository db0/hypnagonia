extends "res://tests/HUTCommon_Ordeal.gd"

var testing_card_name: String
var expected_amount_keys := []


func before_each():
	if testing_card_name and not testing_card_name in test_card_names:
		test_card_names.append(testing_card_name)
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	spawn_test_torments()
	yield(yield_for(0.1), YIELD)

func get_amount(amount_key: String):
	var requested_amount = card.deck_card_entry.properties.get("_amounts", {}).get(amount_key)
	return(requested_amount)

func assert_has_amounts() -> void:
	var card_def = cfc.card_definitions.get(testing_card_name)
	# We don't use assert_has here, because the failed output includes the whole
	# cards dict, which is too long
	assert_not_null(card_def, "card_definition_exists")
	if card_def:
		assert_has(card_def, "_amounts")
		var amounts = card_def.get("_amounts")
		if amounts:
			for akey in expected_amount_keys:
				assert_has(amounts, akey)
		
