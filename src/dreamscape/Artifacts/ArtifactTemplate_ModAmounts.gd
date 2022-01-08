class_name ModAmountsArtifact
extends ModifyPropertyArtifact

# This list is not exhaustive
# Just the most common ones, which might be ones used in curios
const KNOWN_AMOUNTS := [
	"damage_amount",
	"defence_amount",
	"draw_amount",
	"healing_amount",
	"immersion_amount",
	"effect_stacks",
	"chain_amount",
	"multiplier_amount",
	"discard_amount",
	"exert_amount",
]

var amount_name: String
var amount_value
var payload: Dictionary

func _on_artifact_added() -> void:
	if not amount_name in KNOWN_AMOUNTS:
		print_debug("ERROR: amount name '%s' not known." % [amount_name])
		return
	card_filters.append(CardFilter.new('_amounts', amount_name, 'eq'))
	property = '_amounts'
	payload = {
		"amount_key": amount_name,
		"amount_value": amount_value,
	}
	new_value = payload
	._on_artifact_added()
