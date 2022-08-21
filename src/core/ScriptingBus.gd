class_name ScriptingBus
extends Node

# Emitted whenever a card is rotated
# warning-ignore:unused_signal
signal card_rotated(card,details)
# Emitted whenever a card flips up/down
# warning-ignore:unused_signal
signal card_flipped(card,details)
# Emitted whenever a card is viewed while face-down
# warning-ignore:unused_signal
signal card_viewed(card,details)
# Emited whenever a card is moved to the board
# warning-ignore:unused_signal
signal card_moved_to_board(card,details)
# Emited whenever a card is moved to a pile
# warning-ignore:unused_signal
signal card_moved_to_pile(card,details)
# Emited whenever a card is moved to a hand
# warning-ignore:unused_signal
signal card_moved_to_hand(card,details)
# Emited whenever a card's tokens are modified
# warning-ignore:unused_signal
signal card_token_modified(card,details)
# Emited whenever a card attaches to another
# warning-ignore:unused_signal
signal card_attached(card,details)
# Emited whenever a card unattaches from another
# warning-ignore:unused_signal
signal card_unattached(card,details)
# Emited whenever a card properties are modified
# warning-ignore:unused_signal
signal card_properties_modified(card,details)
# Emited whenever a new card has finished being added to the gane through the scripting engine
# warning-ignore:unused_signal
signal card_spawned(card,details)
# Emited whenever a card is targeted by another card.
# This signal is not fired by this card directly like all the others, 
# but instead by  the card doing the targeting.
# warning-ignore:unused_signal
signal card_targeted(card,details)
# warning-ignore:unused_signal
signal counter_modified(card,details)
# warning-ignore:unused_signal
signal shuffle_completed(card_container,details)


# This signal is not triggerring init_scripting_event() 
# It is used to trigger the execute_scripts functions on the various scriptable objects
signal scripting_event_triggered(trigger_card, trigger, details)

func _ready():
	for s in get_signal_list():
		if s.name == "scripting_event_triggered":
			continue
		if s.args.size() == 2:
			# warning-ignore:return_value_discarded
			connect(s.name, self, "init_scripting_event", [s.name])
		elif s.args.size() == 1:
			# This means the signal has no details being sent by defult, so we connect it using a dummy dictionary instead
			connect(s.name, self, "init_scripting_event", [{}, s.name])
		elif s.args.size() == 0:
			# This means the signal sends no args by default, so we just provide dummy vars
			connect(s.name, self, "init_scripting_event", [null, {}, s.name])
	
func init_scripting_event(trigger_object: Card = null, details: Dictionary = {}, trigger: String = '') -> void:
	if trigger == '':
		push_error("WARN: scripting event received with empty trigger name")
		return
	# We use Godot groups to ask every card to check if they
	# have [ScriptingEngine] triggers for this signal.
	#
	# I don't know why, but if I use simply call_group(), this will
	# not execute on a "self" subject
	# when the trigger card has a grid_autoplacement set, and the player
	# drags the card on the grid itself. If the player drags the card
	# To an empty spot, it works fine
	# It also fails to execute if I use any other flag than GROUP_CALL_UNIQUE
#	for card in cfc.get_tree().get_nodes_in_group("cards"):
#		card.execute_scripts(trigger_object,trigger,details)
#	# If we need other objects than cards to trigger scripts via signals
#	# add them to the 'scriptables' group ang ensure they have
#	# an "execute_scripts" function
#	for card in cfc.get_tree().get_nodes_in_group("scriptables"):
#		card.execute_scripts(trigger_object,trigger,details)
#		cfc.get_tree().call_group_flags(SceneTree.GROUP_CALL_UNIQUE  ,"cards",
#				"execute_scripts",trigger_card,trigger,details)
	emit_signal("scripting_event_triggered", trigger_object, trigger, details)	
