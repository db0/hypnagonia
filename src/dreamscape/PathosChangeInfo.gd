extends MarginContainer


onready var name_label := $HBC/Name
onready var chance_label := $HBC/Chance
onready var repressed_label := $HBC/Represed
onready var released_label := $HBC/Released
#onready var description := $Popup/Description
#onready var description_popup := $Popup

func setup(_name: String) -> void:
	name = _name
	
func update_labels(pathos_dict: Dictionary) -> int:
	var repress_mod_dict := {}
	var repress_mod = pathos_dict[name].repress_mod
	var release_mod = pathos_dict[name].release_mod
	for entry in pathos_dict:
		repress_mod_dict[entry] = pathos_dict[entry]["repress_mod"]
	var chance : int = globals.player.pathos.calculate_chance_for_encounter(name, true, repress_mod_dict)
	var chance_before : int = globals.player.pathos.calculate_chance_for_encounter(name, true, {})
	name_label.text = "%s (%s)" % [name.capitalize(), Terms.RUN_ACCUMULATION_TYPES[name]]
	chance_label.text = "%s%%" % [chance]
	repressed_label.text = str(floor(globals.player.pathos.pathi[name].repressed + repress_mod))
	released_label.text = str(floor(globals.player.pathos.pathi[name].released + release_mod ))
	if chance > chance_before:
		chance_label.add_color_override("font_color", Color(0,1,0))
	elif chance < chance_before:
		chance_label.add_color_override("font_color", Color(1,0,0))
	else:
		chance_label.add_color_override("font_color", Color(1,1,1))
	if repress_mod > 0:
		repressed_label.add_color_override("font_color", Color(0,1,0))
	elif repress_mod < 0:
		repressed_label.add_color_override("font_color", Color(1,0,0))
	else:
		repressed_label.add_color_override("font_color", Color(1,1,1))
	if release_mod < 0:
		released_label.add_color_override("font_color", Color(1,0,0))
	elif release_mod > 0:
		released_label.add_color_override("font_color", Color(0,1,0))
	else:
		released_label.add_color_override("font_color", Color(1,1,1))
	return(chance)

func set_max_chance() -> void:
	if name == Terms.RUN_ACCUMULATION_NAMES.enemy:
			chance_label.text = "100%"
			chance_label.add_color_override("font_color", Color(0,1,0))
