extends "res://src/core/OverridableUtils.gd"


func get_subjects(subject_request, stored_integer: int = 0) -> Array:
	var ret_array := []
	match subject_request:
		"dreamer":
			ret_array = [cfc.NMAP.board.dreamer]
	return(ret_array)
