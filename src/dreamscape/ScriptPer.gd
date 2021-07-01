extends ScriptPer

func _init(per_msg: perMessage).(per_msg) -> void:
	pass


func _count_custom() -> int:
	var ret := 0
	match script_name:
		SP.KEY_PER_DEFENCE:
			for subject in subjects:
				if subject.is_in_group("CombatEntities"):
					ret += subject.defence
		SP.FILTER_PER_EFFECT_STACKS:
			ret = _count_effect_stacks()
		_:
			ret = 1
	return(ret)


func _count_effect_stacks() -> int:
	var ret: int
	var effect_name = get_property(SP.KEY_EFFECT_NAME)
	for subject in subjects:
		if subject.is_in_group("CombatEntities"):
			ret += subject.active_effects.get_effect_stacks(effect_name)
	return(ret)
