class_name MemoryObject
extends Reference

const MEMORY_SCENE = preload("res://src/dreamscape/Memories/MemoryTemplate.tscn")

signal removed
signal pathos_accumulated(memory, amount)
signal memory_ready(memory)
signal memory_used(memory)

var is_ready := false
var pathos_used : String
var pathos_threshold : float
var pathos_accumulated : float = 0
var upgrades_amount := 0 setget set_upgrades_amount

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
	if globals.encounters:
		# warning-ignore:return_value_discarded
		globals.encounters.connect("encounter_changed", self, "_on_encounter_changed")


func remove_self() -> void:
	emit_signal("removed")


func accumulate_pathos(value: float) -> void:
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

func set_upgrades_amount(value) -> void:
	upgrades_amount = value
	if upgrades_amount > definition.amounts.get("max_upgrades", 100) - 1:
		upgrades_amount = definition.amounts.get("max_upgrades", 100) - 1
	


func _on_encounter_changed(_act_name, _encounter_number) -> void:
	var accumulation_div : float = definition.get("pathos_accumulation_divider", 2)
	if upgrades_amount and "pathos_accumulation_divider" in definition.get("keys_modified_by_upgrade", []):
		accumulation_div -= float(upgrades_amount) * float(definition.amounts["upgrade_multiplier"] * 0.1)
	# warning-ignore:integer_division
	var amount : float = globals.player.pathos.get_progression_average(pathos_used)
	var acc := amount / accumulation_div
#	print_debug("%s : %s : %s" % [amount, acc, accumulation_div])
	accumulate_pathos(acc)


static func get_cost_format(memory_name: String, upgrades := 0) -> Dictionary:
	var memory_definition = MemoryDefinitions.find_memory_from_canonical_name(memory_name)
	if not memory_definition:
		print_debug("WARNING: Memory Definition '%s; could not be found!" % [memory_name])
		return({})
	var pathos_threshold_multiplier : float = memory_definition.get("pathos_threshold_multiplier", 2)
	var pathos_accumulation_divider : float = memory_definition.get("pathos_accumulation_divider", 2)
	var progression_avg : float = globals.player.pathos.get_progression_average(memory_definition.pathos)
	var is_threshold_upgrade := false
	var is_divider_upgrade := false
	if "pathos_threshold_multiplier" in memory_definition.get("keys_modified_by_upgrade", []):
		pathos_threshold_multiplier -= float(upgrades) * float(memory_definition.amounts["upgrade_multiplier"]) * 0.1
		is_threshold_upgrade = true
	if "pathos_accumulation_divider" in memory_definition.get("keys_modified_by_upgrade", []):
		pathos_accumulation_divider -= upgrades * memory_definition.amounts["upgrade_multiplier"] * 0.1
		is_divider_upgrade = true
	var fill_cost = progression_avg * pathos_threshold_multiplier
	var turns_needed = ceil(fill_cost / (progression_avg / pathos_accumulation_divider))
#	print_debug((progression_avg / pathos_accumulation_divider))
	var threshold_description = str(ceil(fill_cost))
	if is_threshold_upgrade:
		threshold_description = "[color=yellow]%s[/color]" % [threshold_description]
	var cost_format := {
		"pathos": memory_definition.pathos,
		"fill_cost": threshold_description,
		"delay_pct": round(2.0 / pathos_accumulation_divider * 100),
		"turns_needed": turns_needed,
		"delay_pct_explanation": '\nIt takes approx %s Journal encounters to be ready' % [turns_needed],
	}
	var divider_description := ''
	if cost_format["delay_pct"] > 100:
		divider_description = " (%s%% faster)" % [cost_format["delay_pct"] - 100]
	elif cost_format["delay_pct"] < 100:
		divider_description = " (%s%% slower)" % [abs(cost_format["delay_pct"] - 100)]
	if is_divider_upgrade:
		divider_description = "[color=yellow]%s[/color]" % [divider_description]
	cost_format["delay_pct_explanation"] += divider_description
	return(cost_format)


# Calculates how much pathos is needed to recall this memory, taking into account upgrades which
# might reduce this cost
func _calculate_threshold() -> void:
	var threshold_multiplier := float(definition.get("pathos_threshold_multiplier", 2))
	if upgrades_amount and "pathos_threshold_multiplier" in definition.get("keys_modified_by_upgrade", []):
		threshold_multiplier -= float(upgrades_amount) * float(definition.amounts["upgrade_multiplier"]) * 0.1
	pathos_threshold = globals.player.pathos.get_progression_average(pathos_used) * threshold_multiplier
	# Threshold can never be below 1
	if pathos_threshold <= 1:
		pathos_threshold = 1
	# To avoid showing the player that a memory is 120% ready etc.
	if pathos_accumulated > pathos_threshold:
		pathos_accumulated = pathos_threshold


func get_class() -> String:
	return("MemoryObject")
