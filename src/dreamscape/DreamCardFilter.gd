class_name DreamCardFilter
extends CardFilter

func _init(
		_property: String,
		_value,
		_comparison := 'eq',
		_compare_int_as_str := false).(_property, _value, _comparison, _compare_int_as_str) -> void:
	pass

func custom_check(card_properties: Dictionary) -> bool:
	var card_matches = false
	var prop_value = card_properties.get(property)
	if custom_filter == 'discover_purpose':
		var amount_keys : Array = HUtils.get_amount_key_by_purpose(filter, card_properties)
		# When we're trying to discover if the card has an amounts key for a specific purpose
		# We just check if any of the amounts keys has been marked for that purpose
		# If any exist, then we're good
		if amount_keys.size():
			card_matches = true
	return(card_matches)
