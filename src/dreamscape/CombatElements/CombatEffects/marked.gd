extends CombatEffect

func _ready():
	self_decreasing = SELF_DECREASE.TURN_END
	decrease_type = DECREASE_TYPE.REDUCE
	priority = PRIORITY.MULTIPLY

# To override. This is called by the scripting engine
# Is source is telling this script that the owning combat_entity is the one owning
# this alteration
func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'modify_damage'\
			or not "Attack" in script.get_property(SP.KEY_TAGS)\
			or is_source\
			or is_delayed:
		return(0)
	var new_value = round(value * 1.5)
	var alteration = new_value - value
#	print_debug("Disempower ({value} * 0.7) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	return(alteration)
