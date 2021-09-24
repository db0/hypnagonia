# Stores between-encounter changes for the card
class_name CardEntry
extends Reference

var card_name: String
# The actual card on the board linked to this card entry. The card on the board
# is reset each new encounter
var card_object: Card
var upgrade_progress := 0 setget set_upgrade_progress
# How many times the card can be played before its eligible for an upgrade
# If the value is -1, it's not upgradable
var upgrade_threshold := 6
var upgrades: Dictionary
# Initiated along with this card entry. If this card is upgradable
# We store which potential upgrades it can have, so that they always stay
# consistent, no matter how many times the player retries to upgrade
# the same card
var upgrade_options : Array

func _init(_card_name: String) -> void:
	card_name = _card_name
	# If the key is not set, it means the card is not upgradable
	upgrade_threshold = cfc.card_definitions[card_name].get("_upgrade_threshold", -1)
	set_upgrade_options()

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

func set_upgrade_progress(amount) -> void:
	# If the card upgrade progress is -1 it means it's not upgradable
	if upgrade_threshold < 0:
		return
	upgrade_progress += amount
	if upgrade_progress > upgrade_threshold:
		upgrade_progress = upgrade_threshold
	elif upgrade_progress < 0:
		upgrade_progress = 0
		

func can_be_upgraded() -> bool:
	if upgrade_progress == upgrade_threshold:
		return(true)
	return(false)

# Retrieves all possible upgrades for this card and sets two of them to be
# the options when it's upgraded
func set_upgrade_options() -> void:
	upgrade_options = cfc.card_definitions[card_name].get("_upgrades", []).duplicate(true)
	if upgrade_options.size() > 2:
		CFUtils.shuffle_array(upgrade_options)
		upgrade_options.resize(2)

func is_upgraded() -> bool:
	if upgrade_threshold < 0:
		return(true)
	return(false)

# Returns a property of the card, from the card definitions
func get_property(property: String):
	return(cfc.card_definitions[card_name].get(property))
