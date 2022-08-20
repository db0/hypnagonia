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
# Tracks the card names of cards played and the amount of times in this turn
var turn_cards_played := {}
# Tracks the card names of cards played and the amount of times in this ordeal
var encounter_cards_played := {}
# Tracks whose turn it currently is, the player's, or the enemies.
var current_turn : int = Turns.PLAYER_TURN

onready var board = get_parent()

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_deck_shuffled")

# Connecting all signals for the turn
# I should probably mobe these to each indibidual _ready() func
# Now that I'm using an event bus approah
func setup() -> void:
	board.end_turn.connect("pressed", self, "end_player_turn")
	for obj in [board]:
		for turn_signal in ALL_SIGNALS:
			# warning-ignore:return_value_discarded
			scripting_bus.connect(turn_signal, obj, "_on_" + turn_signal)
	for obj in [board.counters, cfc.NMAP.hand]:
		for turn_signal in PLAYER_SIGNALS:
			# warning-ignore:return_value_discarded
			scripting_bus.connect(turn_signal, obj, "_on_" + turn_signal)
		
func start_player_turn() -> void:
	_reset_turn()
	current_turn = Turns.PLAYER_TURN
	cfc.flush_cache()
	# warning-ignore:return_value_discarded
	TurnEventMessage.new("new_turn", 1)
	scripting_bus.emit_signal("player_turn_started", self)
	
func end_player_turn() -> void:
	for pile in cfc.get_tree().get_nodes_in_group("piles"):
		if pile.is_popup_open:
			yield(pile,"popup_closed")
	SoundManager.play_se('end_turn')
	scripting_bus.emit_signal("player_turn_ended", self)
		
func start_enemy_turn() -> void:
	_reset_turn()
	current_turn = Turns.ENEMY_TURN
	scripting_bus.emit_signal("enemy_turn_started", self)
	
func end_enemy_turn() -> void:
	scripting_bus.emit_signal("enemy_turn_ended", self)

func _reset_turn() -> void:
	firsts.clear()
	turn_event_count.clear()
	turn_cards_played.clear()
	applied_effects.clear()

func _on_deck_shuffled(_deck) -> void:
	var ds_count = turn_event_count.get("deck_shuffled", 0)
	turn_event_count["deck_shuffled"] = ds_count + 1
	var te_count = encounter_event_count.get("deck_shuffled", 0)
	encounter_event_count["deck_shuffled"] = te_count + 1
