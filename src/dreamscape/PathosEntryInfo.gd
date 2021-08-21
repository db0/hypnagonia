extends HBoxContainer


onready var name_label := $Name
onready var repressed_label := $Represed
onready var released_label := $Released

func setup(_name: String) -> void:
	name_label.text = _name.capitalize()
	name = _name
	update()
	
func update() -> void:
	repressed_label.text = str(globals.player.pathos.repressed[name])
	released_label.text = str(globals.player.pathos.released[name])
