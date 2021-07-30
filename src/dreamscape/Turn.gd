class_name Turn
extends Node

enum Turns {
	PLAYER_TURN
	ENEMY_TURN
}
const PLAYER_SIGNALS := [
	"player_turn_started",
	"player_turn_ended",
]
const ENEMY_SIGNALS := [
	"enemy_turn_started",
	"enemy_turn_ended",
]

const ALL_SIGNALS := PLAYER_SIGNALS + ENEMY_SIGNALS

signal player_turn_started(turn)
signal player_turn_ended(turn)
signal enemy_turn_started(turn)
signal enemy_turn_ended(turn)
# Tracks the first of each card to have been played each turn
var firsts := {}
# Tracks how much of each effect has been applied this turn
var applied_effects := {}
# Tracks how many event of any type have happened this turn
# For example the amount of cards with a specific tag, played, is an event
# The amount of times the deck was reshuffled is also an event.
# This allows card abilities to filter effects based on how many events of 
# a type have happened
var turn_event_count := {}
# Tracks how many event of any type have happened throughout the game
# These events do not reset turn to turn, but only between encounters
var encounter_event_count := {}
var current_turn : int = Turns.PLAYER_TURN


func _init() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_deck_shuffled")

func setup() -> void:
	cfc.NMAP.board.end_turn.connect("pressed", self, "end_player_turn")
	for obj in [cfc.NMAP.board]:
		for turn_signal in ALL_SIGNALS:
			# warning-ignore:return_value_discarded
			connect(turn_signal, obj, "_on_" + turn_signal)
	for turn_signal in ALL_SIGNALS:
		# warning-ignore:return_value_discarded
		connect(turn_signal, cfc.signal_propagator, "_on_signal_received", ["on_" + turn_signal, {"turn": self}])
	for obj in [cfc.NMAP.board.counters, cfc.NMAP.hand]:
		for turn_signal in PLAYER_SIGNALS:
			# warning-ignore:return_value_discarded
			connect(turn_signal, obj, "_on_" + turn_signal)
		
func start_player_turn() -> void:
	_reset_turn()
	current_turn = Turns.PLAYER_TURN
	emit_signal("player_turn_started", self)
	
func end_player_turn() -> void:
	emit_signal("player_turn_ended", self)
		
func start_enemy_turn() -> void:
	_reset_turn()
	current_turn = Turns.ENEMY_TURN
	emit_signal("enemy_turn_started", self)
	
func end_enemy_turn() -> void:
	emit_signal("enemy_turn_ended", self)

func _reset_turn() -> void:
	firsts.clear()
	turn_event_count.clear()
	applied_effects.clear()

func _on_deck_shuffled() -> void:
	var ds_count = turn_event_count.get("deck_shuffled", 0)
	turn_event_count["deck_shuffled"] = ds_count + 1
	var te_count = encounter_event_count.get("deck_shuffled", 0)
	encounter_event_count["deck_shuffled"] = te_count + 1
