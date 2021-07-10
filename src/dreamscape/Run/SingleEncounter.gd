class_name SingleEncounter
extends Reference

var description: String
var type: String

func begin() -> void:
	globals.current_encounter = self
	
