# Records that an event has happened during the game
# These are used for filters on scripts.
class_name TurnEventMessage
extends Reference

func _init(event_name: String, modification: int, is_delayed := false) -> void:
	# TODO: Add recording for run events
	# E.g. Total amount of damage taken during whole run etc.
	if cfc.NMAP.has("board") and cfc.NMAP.board.turn:
		# If we want the event record to be delayed, it means we want it
		# to be registered just after the counters are wiped.
		# This is for example useful to record events to be used in the opposing
		# turn, such as leftover immersion
		if is_delayed:
			yield(scripting_bus, "enemy_turn_started")
		var turn_event_count = cfc.NMAP.board.turn.turn_event_count
		var existing_turn_count = turn_event_count.get(event_name,0)
		turn_event_count[event_name] = existing_turn_count + modification
		
		var encounter_event_count = cfc.NMAP.board.turn.encounter_event_count
		var existing_encounter_count = encounter_event_count.get(event_name,0)
		encounter_event_count[event_name] = existing_encounter_count + modification
