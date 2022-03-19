extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

class TestNormalFusion:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func test_basic_fusion():
		watch_signals(hand)
		for iter in 4:
			add_single_card('Cannon', deck)
		turn.end_player_turn()
		yield(yield_to(hand, "cards_fused", 3), YIELD)
		# Wait one more sec to allow cards to despawn
		yield(yield_for(1), YIELD)
		assert_true(hand.has_card_name("HiCannon"), "Cards should fuse")
		assert_eq(hand.get_card_count(), 2, "Old cards removed")
		assert_signal_emit_count(hand, "cards_fused", 2)

	func test_upgraded_fusion():
		watch_signals(hand)
		for iter in 4:
			add_single_card('+ Cannon +', deck)
		turn.end_player_turn()
		yield(yield_to(hand, "cards_fused", 3), YIELD)
		# Wait one more sec to allow cards to despawn
		yield(yield_for(1), YIELD)
		assert_true(hand.has_card_name("+ HiCannon +"), "Cards should fuse to upgraded version")
		assert_eq(hand.get_card_count(), 2, "Old cards removed")
		assert_signal_emit_count(hand, "cards_fused", 2)

	func test_half_upgraded_fusion():
		watch_signals(hand)
		for iter in 1:
			add_single_card('Cannon', deck)
		for iter in 1:
			add_single_card('+ Cannon +', deck)
		turn.end_player_turn()
		yield(yield_to(hand, "cards_fused", 3), YIELD)
		# Wait one more sec to allow cards to despawn
		yield(yield_for(1), YIELD)
		assert_true(hand.has_card_name("HiCannon"), "Cards should fuse to normal version")
		assert_eq(hand.get_card_count(), 1, "Old cards removed")
		assert_signal_emit_count(hand, "cards_fused", 1)
