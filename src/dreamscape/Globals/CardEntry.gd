# Stores between-encounter changes for the card
class_name CardEntry
extends Reference

var card_name: String
var card_object: Card
var upgrade_progress := 0
# How many times the card can be played before its eligible for an upgrade
# If the value is -1, it's not upgradable
var upgrade_threshold := 6
var upgrades: Dictionary

func _init(_card_name: String) -> void:
	card_name = _card_name
	# If the key is not set, it means the card is not upgradable
	upgrade_threshold = cfc.card_definitions[card_name].get("_upgrade_threshold", -1)

func instance_self() -> Card:
	card_object = cfc.instance_card(card_name)
	card_object.deck_card_entry = self
	return(card_object)

# Returns true is progrss towards an upgrade happened
# Else returns false
func record_use() -> bool:
	if upgrade_progress < upgrade_threshold:
		upgrade_progress += 1
		return(true)
	return(false)

func can_be_upgraded() -> bool:
	if upgrade_progress == upgrade_threshold:
		return(true)
	return(false)

func get_upgrade_options() -> Array:
	return(cfc.card_definitions[card_name].get("_upgrades", []))
	
