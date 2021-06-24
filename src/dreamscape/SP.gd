# SP stands for "ScriptProperties".
#
# This dummy class exists to allow games to extend 
# the core [ScriptProperties] class provided by CGF, with their own requirements.
# 
# This is particularly useful when needing to adjust filters for the game's needs.
class_name SP
extends ScriptProperties

# Used for specifying the amount of something a script provides
# e.g. amount of damage, or amount of armor
const KEY_AMOUNT = "amount"
const KEY_EFFECT = "effect"

# This call has been setup to call the original, and allow futher extension
# simply create new filter
static func filter_trigger(
		card_scripts,
		trigger_card,
		owner_card,
		trigger_details) -> bool:
	var is_valid := .filter_trigger(card_scripts,
		trigger_card,
		owner_card,
		trigger_details)
	# This is a sample setup of how you would setup a new filter. 
	# See ScriptProperties for more advanced filters
	return(is_valid)
