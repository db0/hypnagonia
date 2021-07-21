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
	var added_effects := []
	var bbcode_format := Terms.get_bbcode_formats(18)
	if card.get_property("_effects_info"):
		var effects_info : Dictionary = card.get_property("_effects_info")
		for effect_name in effects_info:
			added_effects.append(effect_name)
			var effect_entry = Terms.get_term_entry(effect_name, 'description')
			var entity_type: String = effects_info[effect_entry.name]
			var format = Terms.COMMON_FORMATS[entity_type].duplicate()
			format["effect_name"] = effect_entry.name
			format["effect_icon"] = "[img=24x24]" + effect_entry.rich_text_icon + "[/img]"
			format["amount"] = "1"
			format["double_amount"] = "3"
			format["triple_amount"] = "3"
			format["half_amount"] = "0.5"
			focus_info.add_info(
					effect_entry.name,
					effect_entry.description.format(format).format(bbcode_format), preload("res://src/dreamscape/EffectInfoPanel.tscn"))
	var tags : Array = card.get_property("Tags")
	for tag in tags:
		if tag in added_effects:
			continue
		var tag_entry : Dictionary = Terms.get_term_entry(tag, 'generic_description')
		focus_info.add_info(
				tag_entry.name,
				tag_entry.generic_description.format(bbcode_format), preload("res://src/dreamscape/InfoPanel.tscn"))
