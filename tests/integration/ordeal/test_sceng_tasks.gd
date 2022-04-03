extends "res://tests/HUTCommon_Ordeal.gd"

class TestConfirmPlay:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func _init() -> void:
		test_card_names = [
			"GUT",
		]

	func test_spawned_card_confirms_play():
		card.scripts = SPAWN_CARD_SCRIPT
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(hand.get_card_count(), 1)
		if hand.get_card_count() != 1:
			return
		var card2 = hand.get_card(0)
		gut.p(card2)
		yield(yield_for(0.5), YIELD)
		sceng = execute_with_yield(card2)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(turn.turn_event_count.get("cards_played", 0), 2, "Correct amount of cards recorded played")
