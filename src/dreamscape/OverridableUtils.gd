extends "res://src/core/OverridableUtils.gd"


func get_subjects(subject_request, _stored_integer: int = 0) -> Array:
	var ret_array := []
	match subject_request:
		"dreamer":
			ret_array = [cfc.NMAP.board.dreamer]
	return(ret_array)


# Populates the info panels under the card, when it is shown in the
# viewport focus or deckbuilder
func populate_info_panels(card: Card, focus_info: DetailPanels) -> void:
	.populate_info_panels(card, focus_info)
	for effect in Terms.ACTIVE_EFFECTS:
		if card.get_property("_effects_info"):
			var effects_info : Dictionary = card.get_property("_effects_info")
			if effects_info.has(Terms.ACTIVE_EFFECTS[effect].name):
				var entity_type: String = effects_info[Terms.ACTIVE_EFFECTS[effect].name]
				var format = Terms.COMMON_FORMATS[entity_type].duplicate()
				format["effect_name"] = Terms.ACTIVE_EFFECTS[effect].name
				format["amount"] = "1"
				format["double_amount"] = "3"
				format["triple_amount"] = "3"
				format["half_amount"] = "0.5"
				focus_info.add_info(
						Terms.ACTIVE_EFFECTS[effect].name, 
						Terms.ACTIVE_EFFECTS[effect].description.format(format), preload("res://src/dreamscape/EffectInfoPanel.tscn"))
