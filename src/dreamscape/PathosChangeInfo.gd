extends MarginContainer


onready var name_label := $HBC/Name
onready var chance_label := $HBC/Chance
onready var repressed_label := $HBC/Represed
onready var released_label := $HBC/Released
#onready var description := $Popup/Description
#onready var description_popup := $Popup

func setup(_name: String) -> void:
	name = _name
	
func update_labels(repressed_mod: float, released_mod: float) -> void:
	var chance : int = globals.player.pathos.calculate_chance_for_encounter(name, true, repressed_mod)
	var chance_before : int = globals.player.pathos.calculate_chance_for_encounter(name, true, 0)
	name_label.text = "%s (%s)" % [name.capitalize(), Terms.RUN_ACCUMULATION_TYPES[name]]
	chance_label.text = "%s%%" % [chance]
	repressed_label.text = str(floor(globals.player.pathos.repressed[name] + repressed_mod))
	released_label.text = str(floor(globals.player.pathos.released[name] + released_mod ))
	if chance != chance_before:
		chance_label.add_color_override("font_color", Color(0,1,0))
	elif chance > chance_before:
		chance_label.add_color_override("font_color", Color(1,0,0))
	else:
		chance_label.add_color_override("font_color", Color(1,1,1))
	if repressed_mod < 0:
		repressed_label.add_color_override("font_color", Color(0,1,0))
	elif repressed_mod > 0:
		repressed_label.add_color_override("font_color", Color(1,0,0))
	else:
		repressed_label.add_color_override("font_color", Color(1,1,1))
	if released_mod < 0:
		released_label.add_color_override("font_color", Color(1,0,0))
	elif released_mod > 0:
		released_label.add_color_override("font_color", Color(0,1,0))
	else:
		released_label.add_color_override("font_color", Color(1,1,1))
