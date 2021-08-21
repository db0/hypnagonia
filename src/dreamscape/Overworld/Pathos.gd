class_name Pathos
extends Reference

var repressed := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 20,
	Terms.RUN_ACCUMULATION_NAMES.rest: 0,
	Terms.RUN_ACCUMULATION_NAMES.nce: 5,
	Terms.RUN_ACCUMULATION_NAMES.shop: 5,
	Terms.RUN_ACCUMULATION_NAMES.elite: 0,
	Terms.RUN_ACCUMULATION_NAMES.artifact: 0,
	Terms.RUN_ACCUMULATION_NAMES.boss: 0,
}

var progressions := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: range(10,20),
	Terms.RUN_ACCUMULATION_NAMES.rest: range(5,10),
	Terms.RUN_ACCUMULATION_NAMES.nce: range(7,11),
	Terms.RUN_ACCUMULATION_NAMES.shop: range(2,4),
	Terms.RUN_ACCUMULATION_NAMES.elite: range(5,10),
	Terms.RUN_ACCUMULATION_NAMES.artifact: range(2,3),
	Terms.RUN_ACCUMULATION_NAMES.boss: range(5,7),
}

var released := {}

func _init() -> void:
	for accumulation_name in Terms.RUN_ACCUMULATION_NAMES.values():
		released[accumulation_name] = 0


func repress() -> void:
	for entry in repressed:
		var rand_array : Array = progressions[entry].duplicate()
		CFUtils.shuffle_array(rand_array)
		repressed[entry] += rand_array[0]


func release(entry: String) -> int:
	var retcode : int = CFConst.ReturnCode.CHANGED
	if repressed[entry] == 0:
		retcode = CFConst.ReturnCode.OK
	released[entry] += repressed[entry]
	repressed[entry] = 0
	return(retcode)

