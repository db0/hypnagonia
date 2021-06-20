class_name Turn
extends Node

signal turn_started(turn)
signal turn_ended(turn)
# Tracks the first of each card to have been played each turn
var firsts := {}

func _init() -> void:
	pass

func setup() -> void:
	cfc.NMAP.board.end_turn.connect("pressed", self, "end_turn")
	for obj in [cfc.NMAP.board.counters, cfc.NMAP.hand, cfc.NMAP.board, ]:
		# warning-ignore:return_value_discarded
		connect("turn_started", obj, "_on_turn_started")
		# warning-ignore:return_value_discarded
		connect("turn_ended", obj, "_on_turn_ended")
		
func start_turn() -> void:
	emit_signal("turn_started", self)
	
func end_turn() -> void:
	emit_signal("turn_ended", self)
