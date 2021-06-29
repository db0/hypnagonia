extends ScriptPer

func _init(per_msg: perMessage).(per_msg) -> void:
	pass


func _count_custom() -> int:
	var per_count := 0
	match script_name:
		SP.KEY_PER_DEFENCE:
			for subject in subjects:
				if subject.is_in_group("CombatEntities"):
					per_count += subject.defence
		_:
			per_count = 1
	return(per_count)
