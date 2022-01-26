class_name BoardSignalConnector
extends Node

onready var board: DreamBoard = get_parent()

func _ready() -> void:
	# warning-ignore:return_value_discarded
	board.connect("enemy_spawned", self, "_combat_entity_added")
	# warning-ignore:return_value_discarded
	board.connect("player_added", self, "_combat_entity_added")
	
func _combat_entity_added(enemy) -> void:
	var turn: Turn = board.turn
	for turn_signal in Turn.ALL_SIGNALS:
		# warning-ignore:return_value_discarded
		turn.connect(turn_signal, enemy, "_on_" + turn_signal)
