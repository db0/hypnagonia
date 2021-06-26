class_name CardEntry
extends Reference

var card_name: String
var card_object: Card
var upgrades: Dictionary

func _init(_card_name: String) -> void:
	card_name = _card_name

func instance_self() -> Card:
	return(cfc.instance_card(card_name))
