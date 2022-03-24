class_name ModAmountsArtifact
extends ModifyPropertyArtifact

var amount_name: String
var amount_value
# This key is used to specify which purpose amount keys to look for
# This field is only used is amount_name is "discover_purpose"
var purpose := ''
var payload: Dictionary

func _on_artifact_added() -> void:
	if not amount_name in CardModifications.ALL_NUMERICALS + ["discover_purpose"]:
		print_debug("ERROR: amount name '%s' not known." % [amount_name])
		return
	if amount_name == "discover_purpose":
		var new_filter = DreamCardFilter.new('_amounts', purpose, 'eq', false, "discover_purpose")
		card_filters.append(new_filter)
	else:
		card_filters.append(DreamCardFilter.new('_amounts', amount_name, 'eq'))
	property = '_amounts'
	payload = {
		"amount_key": amount_name,
		"amount_value": amount_value,
		"purpose": purpose,
	}
	new_value = payload
	._on_artifact_added()
