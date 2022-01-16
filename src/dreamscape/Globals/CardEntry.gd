# Stores between-encounter changes for the card
class_name CardEntry
extends Reference

signal card_entry_upgraded(card_entry)
signal card_entry_modified(card_entry)
signal card_entry_progressed(card_entry, amount)

# The baseline threshold which all cards needs to upgrade
const UPGRADE_THRESHOLD_BASELINE = 6
# The modifier on the baseline threshold based on the card's rarity.
const UPGRADE_THRESHOLDS_RARITY_MODIFIERS := {
	"Basic": 0,
	"Common": +2,
	"Uncommon": +3,
	"Rare": +4,
	"Received": +8,
	"Perturbation": 0,
}
const UPGRADE_THRESHOLDS_TYPE_MODIFIERS := {
	"Action": 0,
	"Control": 0,
	"Concentration": -2,
	"Understanding": 0,
	"Perturbation": 0,
}

var card_name: String
# The actual card on the board linked to this card entry. The card on the board
# is reset each new encounter
var card_object: Card
var upgrade_progress := 0 setget set_upgrade_progress
# How many times the card can be played before its eligible for an upgrade
# If the value is -1, it's not upgradable
var upgrade_threshold := UPGRADE_THRESHOLD_BASELINE
var upgrades: Dictionary
# Initiated along with this card entry. If this card is upgradable
# We store which potential upgrades it can have, so that they always stay
# consistent, no matter how many times the player retries to upgrade
# the same card
var upgrade_options : Array
var properties := {}
var printed_properties := {}
var unmodified_scripts : Dictionary
# Each entry is a dictionary. Each dictionary has a property and a value.
# These changes are re-applied to the card, when it's upgraded
var property_modifications := []

func _init(_card_name: String) -> void:
	_setup_card_entry(_card_name)


func _setup_card_entry(_card_name: String) -> void:
	card_name = _card_name
	properties = cfc.card_definitions.get(card_name, {}).duplicate(true)
	printed_properties = cfc.card_definitions.get(card_name, {}).duplicate(true)
	# If the key is not set, it means the card is not upgradable
	upgrade_threshold = properties.get("_upgrade_threshold_modifier", -1)
	# if it is set, then it is modifying the card's standard upgrade threshold based on its rarity
	if upgrade_threshold >= 0:
		upgrade_threshold =\
				UPGRADE_THRESHOLD_BASELINE\
				+ UPGRADE_THRESHOLDS_RARITY_MODIFIERS[properties["_rarity"]]\
				+ UPGRADE_THRESHOLDS_TYPE_MODIFIERS[properties["Type"]]\
				+ upgrade_threshold
	set_upgrade_options()
	if cfc.scripts_loading:
		yield(cfc, "scripts_loaded")
	unmodified_scripts = cfc.unmodified_set_scripts.get(card_name, {})
	## DEBUG
#	set_upgrade_progress(upgrade_threshold)
	## END DEBUG


func instance_self(is_display_card:= false) -> Card:
	var new_card_object =  cfc.instance_card(card_name)
	if not is_display_card:
		card_object = new_card_object
	new_card_object.properties = properties
	new_card_object.printed_properties = printed_properties
	new_card_object.connect_card_entry(self)
	return(new_card_object)


func upgrade(upgrade_name: String) -> void:
	_setup_card_entry(upgrade_name)
	for mod in property_modifications:
		modify_property(mod.property, mod.value, false)
	emit_signal("card_entry_upgraded", self)


# Returns true is progrss towards an upgrade happened
# Else returns false
func record_use() -> bool:
	if upgrade_progress < upgrade_threshold:
		set_upgrade_progress(upgrade_progress + 1)
		return(true)
	return(false)


func set_upgrade_progress(amount) -> void:
	# If the card upgrade progress is -1 it means it's not upgradable
	if upgrade_threshold < 0:
		return
	var pre_upgrade = upgrade_progress
	if amount > upgrade_threshold:
		amount = upgrade_threshold
	elif amount < 0:
		amount = 0
	upgrade_progress = amount
	if pre_upgrade != amount:
		emit_signal("card_entry_progressed", amount - pre_upgrade)


func can_be_upgraded() -> bool:
	if upgrade_progress == upgrade_threshold:
		return(true)
	return(false)


func is_progressing() -> bool:
	if upgrade_progress < upgrade_threshold:
		return(true)
	return(false)


# Retrieves all possible upgrades for this card and sets two of them to be
# the options when it's upgraded
func set_upgrade_options() -> void:
	upgrade_options = properties.get("_upgrades", []).duplicate(true)
	if upgrade_options.size() > 2:
		CFUtils.shuffle_array(upgrade_options)
		upgrade_options.resize(2)


func is_upgraded() -> bool:
	if upgrade_threshold < 0:
		return(true)
	return(false)


# Returns a property of the card, from the card definitions
func get_property(property: String):
	return(properties.get(property))


# This permanently modifies a property for that one card in your deck.
func modify_property(property: String, value, record := true) -> void:
	# We record the changes permanently, so that we can re-apply them after the card upgrades
	if record:
		var record_entry := {
			"property": property,
			"value": value,
		}
		property_modifications.append(record_entry)
	# When modifying _amounts, we expect a certain payload dictionary
	if property == "_amounts":
		_modify_amounts(value.amount_key, value.amount_value)
	elif typeof(properties.get(property)) == typeof(value):
		# This handles dictionary propertie, like _amounts
		if typeof(value) == TYPE_DICTIONARY:
			for key in value:
				properties[property][key] = value
		# This handles string properties (typical labels)
		# And int-to-int property changes.
		else:
			properties[property] = value
	elif property in CardConfig.PROPERTIES_NUMBERS:
		# If the property is numerical but the value is a string
		# and that value has a +/- operator
		# The designer is attempting to modify the property
		# from its current value
		if typeof(value) == TYPE_STRING:
			# This handles operations, like +3 or -2
			if value.is_valid_integer():
				properties[property] += int(value)
			# This handles strings as numbers, such as 'X' and 'U'
			else:
				properties[property] = value
	# This handles Array properties, like Tags
	# A tag name, prepended with '-' means we're removing it
	elif property in CardConfig.PROPERTIES_ARRAYS:
		var tag: String = value
		if tag.begins_with('-'):
			tag = tag.lstrip('-')
			if tag in properties[property]:
				properties[property].erase(tag)
		else:
			if not tag in properties[property]:
				properties[property].append(tag)
	emit_signal("card_entry_modified", self)


# In Hypnagonia, cards with permanent CardEntries, retrieve their scripts from
# them. This allows us to permanently modify the card scripts of a card in the deck.
func retrieve_scripts(trigger: String) -> Dictionary:
	var found_scripts: Dictionary = unmodified_scripts.duplicate(true)
	CoreScripts.lookup_script_property(found_scripts, card_name, self)
#	print(found_scripts.get(trigger,{}))
	return(found_scripts.get(trigger,{}))


func modify_scripts(task: Dictionary, script_state:= 'hand') -> void:
	if unmodified_scripts['manual'].has(script_state):
		unmodified_scripts['manual'][script_state].append(task)
		properties["Abilities"] += "\n{forget}"
	else:
		printerr("ERROR:CardEntry: Cannot find script state '%s' in unmodified scripts of '%s" % [script_state,card_name])


# This function should only be called from modify_property()
# to ensure the changes survive card upgrades
func _modify_amounts(amount_name: String, value) -> void:
	if not properties.has("_amounts"):
		properties["_amounts"] = {}
	var current_value = properties["_amounts"].get(amount_name)
	var new_value
	if typeof(value) == TYPE_STRING\
			and value.lstrip("*").is_valid_float()\
			and typeof(current_value) == TYPE_INT:
		if value.begins_with("*"):
			new_value = ceil(float(current_value) * float(value.lstrip("*")))
		else:
			new_value = current_value + int(value)
	else:
		new_value = value
	properties["_amounts"][amount_name] = new_value
