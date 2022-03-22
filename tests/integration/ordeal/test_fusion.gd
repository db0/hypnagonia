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

class TestUniversalComponent:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true


	func test_single_uc():
		watch_signals(hand)
		for iter in 3:
			add_single_card('Cannon', deck)
		add_single_card('Universal Component', deck)
		turn.end_player_turn()
		yield(yield_to(hand, "cards_fused", 3), YIELD)
		# Wait one more sec to allow cards to despawn
		yield(yield_for(1), YIELD)
		assert_true(hand.has_card_name("HiCannon"), "Cards should fuse")
		assert_eq(hand.get_card_count(), 4, "Old cards removed")
		assert_eq(counters.get_counter("immersion"), 4,
				"Immersion increased by Universal Component")
		assert_signal_emit_count(hand, "cards_fused", 2)

	func test_double_uc():
		watch_signals(hand)
		for iter in 2:
			add_single_card('Universal Component', deck)
		turn.end_player_turn()
		yield(yield_to(hand, "cards_fused", 3), YIELD)
		# Wait one more sec to allow cards to despawn
		yield(yield_for(1), YIELD)
		assert_true(hand.has_card_name("Fusion Grenade"), "Cards should fuse")
		assert_eq(hand.get_card_count(), 6, "Old cards removed")
		assert_eq(counters.get_counter("immersion"), 5,
				"Immersion increased by Universal Component")
		assert_signal_emit_count(hand, "cards_fused", 1)

	func test_single_uc_drawn_during_turn():
		watch_signals(hand)
		for iter in 1:
			add_single_card('Cannon', hand)
		add_single_card('Universal Component', deck)
		hand.draw_card()
		yield(yield_to(hand, "cards_fused", 3), YIELD)
		# Wait one more sec to allow cards to despawn
		assert_true(hand.has_card_name("HiCannon"), "Cards should fuse")
		assert_eq(hand.get_card_count(), 2, "Old cards removed")
		assert_eq(counters.get_counter("immersion"), 4,
				"Immersion increased by Universal Component")
		assert_signal_emit_count(hand, "cards_fused", 1)

	func test_upgraded_uc_drawn_during_turn():
		watch_signals(hand)
		for iter in 1:
			add_single_card('Photon Shield', hand)
		add_single_card('! Universal Component !', deck)
		hand.draw_card()
		yield(yield_to(hand, "cards_fused", 3), YIELD)
		# Wait one more sec to allow cards to despawn
		assert_true(hand.has_card_name("Lumen Shield"), "Cards should fuse")
		assert_eq(hand.get_card_count(), 4, "Old cards removed")
		assert_eq(counters.get_counter("immersion"), 4,
				"Immersion increased by Universal Component")
		assert_signal_emit_count(hand, "cards_fused", 1)

	func test_single_uc_with_normal_cards():
		watch_signals(hand)
		add_single_card('Universal Component', deck)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		# Wait one more sec to allow cards to despawn
		yield(yield_for(1), YIELD)
		assert_signal_not_emitted(hand,"cards_fused")
