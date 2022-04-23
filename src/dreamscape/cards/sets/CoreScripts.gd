# Don't know why, but putting a class name here, breaks HTML exports
class_name CoreScripts
extends Reference

# If the upgraded card name is prepending one of these words
# Then we know it's going to be using the same script definition as the original
# card.
# This allows us to avoid writing new definitions when all that is changing
# is the card statistics (like cost)
const SAME_SCRIPT_ADJECTIVES := [
	"Easy", # Used when the upgraded card has just lower cost
	"Solid", # Used when the upgraded card has higher amount or damage or defence.
	"Enhanced", # Used when the upgraded card has higher amount of effect stacks.
	"Ephemeral", # Used when the upgraded card is adding an extra task to remove the card from deck.
	"Fleeting", # Used when the upgraded card is adding an extra task to exhaust the card.
	"Swift", # Used when the upgraded card is increasing the amount of cards drawn.
	"Balanced", # Used when the upgraded card is tweaking all values at the same time.
]
const SAME_SCRIPT_SYMBOLS := [
	"@", # Used when the upgraded card has just lower cost
	"+", # Used when the upgraded card has higher amount of damage or defence.
	"++", # Used when the upgraded card has even higher amount of damage or defence.
	"*", # Used when the upgraded card has higher amount of effect stacks.
	"-", # Used when the upgraded card is adding an extra task to remove the card from deck.
	"~", # Used when the upgraded card is adding an extra task to exhaust the card.
	"!", # Used when the upgraded card is increasing the amount of cards drawn.
	"=", # Used when the upgraded card is tweaking all values at the same time.
	"%", # Used when the upgraded card is rebalancing all values at the same time.
	"^", # Used when the upgraded card is receiving the alpha keyword.
	"Ω", # Used when the upgraded card is receiving the omega keyword.
]

# When a the "Ephemeral" prepend has been added to a card upgrade
# It means the card is permanently removed from the deck after using it.
# This is the ScEng task that does this, and it is automatically appended
# to the card's normal scripts.
# For this to work properly, the card definition needs to also have
# The "_avoid_normal_discard" property set to true
const EPHEMERAL_TASK := {
	"name": "remove_card_from_deck",
	"subject": "self",
	"tags": ["Played", "Card"],
}

# Takes care to return the correct script, even for card with standard upgrades
func _prepare_scripts(all_scripts: Dictionary, card_name: String, get_modified := true) -> Dictionary:
	# When a the "Fleeting" prepend has been added to a card upgrade
	# It means the card is forgotten after using it.
	# This is the ScEng task that does this, and it is automatically appended
	# to the card's normal scripts.
	# We cannot make this into a const as it refers via NMAP
	var FLEETING_TASK := {
		"name": "move_card_to_container",
		"subject": "self",
		"dest_container": "forgotten",
		"tags": ["Played", "Card"],
	}
	var script_name := card_name
	var break_loop := false
	var special_destination = null
	if not all_scripts.has(card_name):
		for script_id in all_scripts:
			for prepend in SAME_SCRIPT_ADJECTIVES:
				var card_name_with_unmodified_scripts = prepend + ' ' + script_id
				if card_name == card_name_with_unmodified_scripts:
					script_name = script_id
					if prepend in ["Ephemeral", "Fleeting"]:
						special_destination = prepend
					break_loop = true
					break
			for symbol in SAME_SCRIPT_SYMBOLS:
				var card_name_with_unmodified_scripts = symbol + ' ' + script_id + ' ' + symbol
				if card_name == card_name_with_unmodified_scripts:
					script_name = script_id
					if symbol in ["-", "~"]:
						special_destination = symbol
					break_loop = true
					break
			if break_loop: break
	# We can mark which script to reuse in each card's definition
	# This allows us to reuse scripts, using different names than the prepends
	# in SAME_SCRIPT_ADJECTIVES
	if cfc.card_definitions[card_name].has("_reuse_script"):
		script_name = cfc.card_definitions[card_name]["_reuse_script"]
	# We return only the scripts that match the card name and trigger
	var ret_script = all_scripts.get(script_name,{}).duplicate(true)
	# We use this trick to avoid creating a whole new script for the ephemeral
	# upgraded versions, just to add the "remove from deck" task
	match special_destination:
		"Ephemeral", '-':
			ret_script["manual"]["hand"].append(EPHEMERAL_TASK)
		"Fleeting", '~':
			ret_script["manual"]["hand"].append(FLEETING_TASK)
	if get_modified:
		lookup_script_property(ret_script, card_name)
	return(ret_script)


# This function will go through all the dictionaries in the card scripts
# and look for dictionaries with a key lookup_property
# This signifies a value that needs to be looked up from the card itself
# So we do that and replace the value in that dictionary with the looked up value.
# This allows us to tweak the values of scripts from the card definitions
# and thus have only one adjustment point
static func lookup_script_property(script: Dictionary, card_name: String, card_properties = null) -> void:
	for key in script:
		if typeof(script[key]) == TYPE_DICTIONARY:
			if script[key].has("lookup_property"):
				var lookup = script[key].duplicate()
				var lookup_property = lookup.get("lookup_property")
				var value_key = lookup.get("value_key")
				var default_value = lookup.get("default")
				var value
				if card_properties:
					value = card_properties\
						.get(lookup_property, {}).get(value_key, default_value)
				else:
					value = cfc.card_definitions[card_name]\
						.get(lookup_property, {}).get(value_key, default_value)
				if lookup.get("is_inverted"):
					value *= -1
				if lookup.get("convert_to_string", false):
					if value > 0:
						value = '+' + str(value)
					else:
						value = str(value)
				script[key] = value
			else:
				lookup_script_property(script[key], card_name, card_properties)
		elif typeof(script[key]) == TYPE_ARRAY:
			for task in script[key]:
				if typeof(task) == TYPE_DICTIONARY:
					lookup_script_property(task, card_name, card_properties)

