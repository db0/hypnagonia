extends Node

# warning-ignore:unused_signal
signal card_drafted(card_entity)
# warning-ignore:unused_signal
signal battle_begun
# warning-ignore:unused_signal
signal battle_ended
# warning-ignore:unused_signal
signal game_over

func _ready():
	# warning-ignore:return_value_discarded
	connect("battle_begun", cfc.signal_propagator, "_on_signal_received", [self, "battle_begun", {}])
	
