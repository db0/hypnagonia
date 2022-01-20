class_name TurnEventMessage
extends Reference

# We're kinda cheating here by using a static function which relies on a global.
# Hopefully won't crash on testing
func _init(event_name: String, modification: int) -> void:
	# TODO: Add recording for run events
	# E.g. Total amount of damage taken during whole run etc.
	if cfc.NMAP.has("board") and cfc.NMAP.board.turn:
		var turn_event_count = cfc.NMAP.board.turn.turn_event_count
		var existing_turn_count = turn_event_count.get(event_name,0)
		turn_event_count[event_name] = existing_turn_count + modification
		
		var encounter_event_count = cfc.NMAP.board.turn.encounter_event_count
		var existing_encounter_count = encounter_event_count.get(event_name,0)
		encounter_event_count[event_name] = existing_encounter_count + modification
