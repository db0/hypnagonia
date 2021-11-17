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
		SP.FILTER_PER_EFFECT_STACKS, SP.PER_EFFECT_STACKS:
			ret = _count_effect_stacks()
		SP.KEY_PER_ENCOUNTER_EVENT_COUNT:
			ret = cfc.NMAP.board.turn.encounter_event_count.get(get_property(SP.KEY_EVENT_NAME),0)
		SP.KEY_PER_TURN_EVENT_COUNT:
			ret = cfc.NMAP.board.turn.turn_event_count.get(get_property(SP.KEY_EVENT_NAME),0)
		_:
			ret = 1
	return(ret)


func _count_effect_stacks() -> int:
	var ret := 0
	var effect_name = get_property(SP.KEY_EFFECT_NAME)
	for subject in subjects:
		if subject.is_in_group("CombatEntities"):
			ret += subject.active_effects.get_effect_stacks(effect_name)
	return(ret)
