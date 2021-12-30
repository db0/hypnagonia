class_name MemoryObject
extends Reference

const MEMORY_SCENE = preload("res://src/dreamscape/Memories/MemoryTemplate.tscn")

signal removed
signal pathos_accumulated(memory, amount)
signal memory_ready(memory)
signal memory_used(memory)

var is_ready := false
var pathos_used : String
var pathos_threshold : int
var pathos_accumulated := 0
var upgrades_amount := 0

var memory_scene: PackedScene
var canonical_name: String
var definition: Dictionary
# Whether this artifact is active during the battle or the journal phases
var context: int
# These is an open ended dictionary which we can use to pass arguments to the
# artifact definition. For example if we want the same artifact, but it behaves in
# different ways, based on how the player got it.
var modifiers := {}

func _init(memory_name: String, _mods := {}) -> void:
	memory_scene = MEMORY_SCENE
	definition = MemoryDefinitions[memory_name].duplicate(true)
	canonical_name = definition["canonical_name"]
	context = definition["context"]
	pathos_used = definition["pathos"]
	_calculate_threshold()
	# First use is free
	pathos_accumulated = pathos_threshold
	is_ready = true
#	emit_signal("pathos_accumulated", self, 0)
	modifiers = _mods
	# warning-ignore:return_value_discarded
#	globals.player.pathos.connect("pathos_released", self, "_on_pathos_released")
	if globals.encounters:
		# warning-ignore:return_value_discarded
		globals.encounters.connect("encounter_changed", self, "_on_encounter_changed")


func remove_self() -> void:
	emit_signal("removed")


func accumulate_pathos(value: int) -> void:
	# The memory cannot withdraw more pathos than the player currently has
	if value > globals.player.pathos.released.get(pathos_used,0):
		value = globals.player.pathos.released.get(pathos_used,0)
	# The memory cannot withdraw more pathos then needed to reach its threshold
	if pathos_accumulated + value > pathos_threshold:
		value = pathos_threshold - pathos_accumulated
	# Pathos send to a memory is considered spent
	if value > 0:
		pathos_accumulated += value
		globals.player.pathos.spend_pathos(pathos_used, value)
		emit_signal("pathos_accumulated", self, value)
	if pathos_accumulated >= pathos_threshold:
		pathos_accumulated = pathos_threshold
		is_ready = true
		emit_signal("memory_ready", self)


func use() -> void:
	is_ready = false
	pathos_accumulated = 0
	emit_signal("memory_used", self)


func instance_memory() -> Memory:
	var memory: Memory = memory_scene.instance()
	memory.name = canonical_name
	var script_path := "res://src/dreamscape/Memories/%s.gd" % [canonical_name]
	if ResourceLoader.exists(script_path):
		var memory_script = load(script_path)
		memory.set_script(memory_script)
	return(memory)


func upgrade() -> void:
	# -1 because the player sees starting level as 1 while we start with 0 upgrade count internally.
	if upgrades_amount < definition.amounts.get("max_upgrades", 100) - 1:
		upgrades_amount += 1
		_calculate_threshold()


#func _on_pathos_released(pathos: String, amount: int) -> void:
#	if pathos == pathos_used:
#		# The pathos.release_adjustments dictionary allows a pathos that is exceeding
#		# its threshold for getting an encounter, to release more than just that amount
#		# every time it's used. To avoid a memory thus filling too quickly due to this
#		# multiplier (i.e. every 1-2 encounters of that type), we divide the amount of
#		# released pathos we use to fill up the memoty by the same amount.
#		var adjustment_div = globals.player.pathos.release_adjustments.get(pathos,1)
#		var accumulation_div = definition.get("pathos_accumulation_divider", 2)
#		if upgrades_amount and "pathos_accumulation_divider" in definition.get("keys_modified_by_upgrade", []):
#			accumulation_div -= upgrades_amount * definition.amounts["upgrade_multiplier"]
#		# warning-ignore:integer_division
#		var acc := int(round(amount / accumulation_div / adjustment_div))
##		print_debug("%s : %s : %s : %s" % [amount, acc, adjustment_div, accumulation_div])
#		accumulate_pathos(acc)


func _on_encounter_changed(_act_name, _encounter_number) -> void:
	var accumulation_div = definition.get("pathos_accumulation_divider", 2)
	if upgrades_amount and "pathos_accumulation_divider" in definition.get("keys_modified_by_upgrade", []):
		accumulation_div -= upgrades_amount * definition.amounts["upgrade_multiplier"]
	# warning-ignore:integer_division
	var amount : float = globals.player.pathos.get_progression_average(pathos_used)
	var acc := int(round(amount / accumulation_div))
#		print_debug("%s : %s : %s : %s" % [amount, acc, adjustment_div, accumulation_div])
	accumulate_pathos(acc)


static func get_cost_format(memory_name: String, upgrades := 0) -> Dictionary:
	var memory_definition = MemoryDefinitions.find_memory_from_canonical_name(memory_name)
	if not memory_definition:
		print_debug("WARNING: Memory Definition '%s; could not be found!" % [memory_name])
		return({})
	var pathos_threshold_multiplier : float = memory_definition.get("pathos_threshold_multiplier", 1)
	var pathos_accumulation_divider : float = memory_definition.get("pathos_accumulation_divider", 2)
	if upgrades > 0:
		if "pathos_threshold_multiplier" in memory_definition.get("keys_modified_by_upgrade", []):
			pathos_threshold_multiplier -= upgrades * memory_definition.amounts["upgrade_multiplier"]
		if "pathos_accumulation_divider" in memory_definition.get("keys_modified_by_upgrade", []):
			pathos_accumulation_divider -= upgrades * memory_definition.amounts["upgrade_multiplier"]
	var cost_format := {
		"pathos": memory_definition.pathos,
		"fill_cost": round(globals.player.pathos.get_progression_average(memory_definition.pathos)\
				* pathos_threshold_multiplier),
		"delay_pct": round(2.0 / pathos_accumulation_divider * 100),
		"delay_pct_explanation": '',
	}
	if cost_format["delay_pct"] > 100:
		cost_format["delay_pct_explanation"] = " and activates %s%% faster" % [cost_format["delay_pct"] - 100]
	elif cost_format["delay_pct"] < 100:
		cost_format["delay_pct_explanation"] = " and activates %s%% slower" % [abs(cost_format["delay_pct"] - 100)]
	return(cost_format)


# Calculates how much pathos is needed to recall this memory, taking into account upgrades which
# might reduce this cost
func _calculate_threshold() -> void:
	var threshold_multiplier := float(definition.get("pathos_threshold_multiplier", 2))
	if upgrades_amount and "pathos_threshold_multiplier" in definition.get("keys_modified_by_upgrade", []):
		threshold_multiplier -= float(upgrades_amount) * float(definition.amounts["upgrade_multiplier"])
	pathos_threshold = int(round(globals.player.pathos.get_progression_average(pathos_used)
			* threshold_multiplier))
	# Threshold can never be below 1
	if pathos_threshold <= 1:
		pathos_threshold = 1
	# To avoid showing the player that a memory is 120% ready etc.
	if pathos_accumulated > pathos_threshold:
		pathos_accumulated = pathos_threshold


func get_class() -> String:
	return("MemoryObject")
