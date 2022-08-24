class_name HypnagoniaScriptingBus
extends ScriptingBus

# Emited whenever the card is played manually or via card effect.
# Since a card might be "played" from any source and to many possible targets
# we use a specialized signal to trigger effects which fire after playing cards
# warning-ignore:unused_signal
signal card_played(card,details)
# warning-ignore:unused_signal
signal card_removed(card,details)
# warning-ignore:unused_signal
signal selection_window_opened(selection_window, details)
# warning-ignore:unused_signal
signal card_selected(selection_window, details)
# warning-ignore:unused_signal
signal battle_begun
# warning-ignore:unused_signal
signal player_turn_started(turn)
# warning-ignore:unused_signal
signal player_turn_ended(turn)
# warning-ignore:unused_signal
signal enemy_turn_started(turn)
# warning-ignore:unused_signal
signal enemy_turn_ended(turn)
# warning-ignore:unused_signal
signal cards_fused(card)
