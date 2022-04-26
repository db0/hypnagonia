# Records the name of each card played in a turn/ordeal
# These are used for things like redundant 
class_name TurnRecordCardPlayMessage
extends Reference

func _init(card_name: String) -> void:
	if cfc.NMAP.has("board") and cfc.NMAP.board.turn:
		var turn_cards_played = cfc.NMAP.board.turn.turn_cards_played
		turn_cards_played[card_name] = turn_cards_played.get(card_name,0) + 1
		
		var encounter_cards_played = cfc.NMAP.board.turn.encounter_cards_played
		encounter_cards_played[card_name] = encounter_cards_played.get(card_name,0) + 1
