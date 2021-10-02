class_name Pathos
extends Reference

var repressed := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 20,
	Terms.RUN_ACCUMULATION_NAMES.rest: 0,
	Terms.RUN_ACCUMULATION_NAMES.nce: 0, # Normally should start at 5
	Terms.RUN_ACCUMULATION_NAMES.shop: 0,
	Terms.RUN_ACCUMULATION_NAMES.elite: 0,
	Terms.RUN_ACCUMULATION_NAMES.artifact: 0,
	Terms.RUN_ACCUMULATION_NAMES.boss: 0,
}

var progressions := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: range(11,20),
	Terms.RUN_ACCUMULATION_NAMES.rest: range(4,9),
	Terms.RUN_ACCUMULATION_NAMES.shop: range(2,4),
	Terms.RUN_ACCUMULATION_NAMES.artifact: range(2,3),
	Terms.RUN_ACCUMULATION_NAMES.elite: range(5,10),
# These arem temporarily disabled while I don't have any.
# Will be activated once populated
#	Terms.RUN_ACCUMULATION_NAMES.nce: range(7,11),
	Terms.RUN_ACCUMULATION_NAMES.nce: [0],
	Terms.RUN_ACCUMULATION_NAMES.boss: range(6,7),
}

var released := {}

func _init() -> void:
	for accumulation_name in Terms.RUN_ACCUMULATION_NAMES.values():
		released[accumulation_name] = 0
	var random_pathos =  grab_random_pathos()
	# Every run, starts the player with a bunch of released pathos on a random one.
	released[random_pathos] +=\
			round(get_progression_average(random_pathos)* CFUtils.randf_range(3,5))

func repress() -> void:
	for entry in repressed:
		repressed[entry] += get_progression(entry)


func release(entry: String) -> int:
	var retcode : int = CFConst.ReturnCode.CHANGED
	if repressed[entry] == 0:
		retcode = CFConst.ReturnCode.OK
	released[entry] += repressed[entry]
	repressed[entry] = 0
	return(retcode)


# Returns one random possible progression from the range
# Grabbing the number via a fuction, rather than directly from the var
# allows us to modify this via artifacts during runtime
func get_progression(entry) -> int:
	var rand_array : Array = progressions[entry].duplicate()
	CFUtils.shuffle_array(rand_array)
	return(rand_array[0])


# Returns the average value of the progression specified
func get_progression_average(entry) -> float:
	var total: int = 0
	for p in progressions[entry]:
		total += p
	return(total / progressions[entry].size())


func grab_random_pathos() -> String:
	var all_pathos = Terms.RUN_ACCUMULATION_NAMES.values()
	CFUtils.shuffle_array(all_pathos)
	return(all_pathos[0])
