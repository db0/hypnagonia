class_name MemoryObject
extends Reference

const MEMORY_SCENE = preload("res://src/dreamscape/Memories/MemoryTemplate.tscn")

signal removed
signal memory_charging(memory, amount)
signal memory_ready(memory)
signal memory_unready(memory)
signal memory_used(memory)
signal memory_upgraded(memory, amount)
signal memory_downgraded(memory, amount)

var is_ready := false
var pathos_used : PathosType
var recharge_time : int
var current_charge : int = 0 setget set_current_charge
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
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Memory: Adding Memory: " + memory_name)
	memory_scene = MEMORY_SCENE
	if globals.test_flags.get("memory_defintions", {}).has(memory_name):
		definition = globals.test_flags.memory_defintions[memory_name]
	else:
		definition = MemoryDefinitions[memory_name].duplicate(true)
	canonical_name = definition["canonical_name"]
	context = definition["context"]
	pathos_used = globals.player.pathos.pathi[definition["pathos"]]
	pathos_used.progression_modifying_objects.append(self)
	_calculate_recharge_time()
	# First use is free
	current_charge = recharge_time
	is_ready = true
	emit_signal("memory_charging", self, 0)
	modifiers = _mods
	if globals.encounters:
		# warning-ignore:return_value_discarded
		globals.encounters.connect("encounter_changed", self, "_on_encounter_changed")


func remove_self() -> void:
	emit_signal("removed")


func ready() -> void:
	current_charge = recharge_time
	is_ready = true
	emit_signal("memory_ready", self)


func unready() -> void:
	is_ready = false
	emit_signal("memory_unready", self)


func use() -> void:
	is_ready = false
	current_charge = 0
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
		_calculate_recharge_time()
		emit_signal("memory_upgraded", self, 1)


func set_upgrades_amount(value) -> void:
	var pre_upgrade = upgrades_amount
	upgrades_amount = value
	if upgrades_amount > definition.amounts.get("max_upgrades", 100) - 1:
		upgrades_amount = definition.amounts.get("max_upgrades", 100) - 1
	elif upgrades_amount < 0:
		upgrades_amount = 0
	if value > pre_upgrade:
		emit_signal("memory_upgraded", self, value - pre_upgrade)
	else:
		emit_signal("memory_downgraded", self, value - pre_upgrade)


func get_pathos_progression_modifier() -> float:
	var modifier : float = definition.get("pathos_progress_multiplier", 0.0)
	if "pathos_progress_multiplier" in definition.get("keys_modified_by_upgrade", []):
		modifier +=\
				float(upgrades_amount) * float(definition.amounts["upgrade_multiplier"]) * 0.01
	return(modifier)


func _on_encounter_changed(_act_name, _encounter_number) -> void:
	set_current_charge(current_charge + 1)


func set_current_charge(value: int) -> void:
	if current_charge >= recharge_time:
		return
	if value > current_charge:
		emit_signal("memory_charging", self, 1)
	current_charge = value
	if current_charge >= recharge_time:
		ready()
	elif is_ready:
		unready()
		
static func get_cost_format(memory_name: String, upgrades := 0) -> Dictionary:
	var memory_definition = MemoryDefinitions.find_memory_from_canonical_name(memory_name)
	if not memory_definition:
		print_debug("WARNING: Memory Definition '%s' could not be found!" % [memory_name])
		return({})
	var progress_modifier : float = memory_definition.get("pathos_progress_multiplier", 0.0)
	var recharge_time : int = memory_definition.get("recharge_time", 2)
	var pathos_type: PathosType = globals.player.pathos.pathi[memory_definition.pathos]
	var is_threshold_upgrade := false
	var is_recharge_upgrade := false
	if "pathos_progress_multiplier" in memory_definition.get("keys_modified_by_upgrade", []):
		progress_modifier += float(upgrades) * float(memory_definition.amounts["upgrade_multiplier"]) * 0.01
		is_threshold_upgrade = true
	if "recharge_time" in memory_definition.get("keys_modified_by_upgrade", []):
		recharge_time -= upgrades * memory_definition.amounts["upgrade_multiplier"]
		is_recharge_upgrade = true
	var pathos_desc_fmt: Dictionary
	var turns_needed = recharge_time
	var pathos_description:= "This memory {verb} chance of {encounter_type} encounters by {pct}%"
	var decrease_bad: bool
	match memory_definition.pathos:
		Terms.RUN_ACCUMULATION_NAMES.enemy:
			pathos_desc_fmt["encounter_type"] = "normal torment"
			decrease_bad = false
		Terms.RUN_ACCUMULATION_NAMES.elite:
			pathos_desc_fmt["encounter_type"] = "elite torment"
			decrease_bad = false
		Terms.RUN_ACCUMULATION_NAMES.artifact:
			pathos_desc_fmt["encounter_type"] = "curio"
			decrease_bad = true
		Terms.RUN_ACCUMULATION_NAMES.nce:
			pathos_desc_fmt["encounter_type"] = "non-ordeal"
			decrease_bad = true
		Terms.RUN_ACCUMULATION_NAMES.shop:
			pathos_desc_fmt["encounter_type"] = "shop"
			decrease_bad = true
		Terms.RUN_ACCUMULATION_NAMES.rest:
			pathos_desc_fmt["encounter_type"] = "deep torpor"
			decrease_bad = true
#	print_debug((progression_avg / pathos_accumulation_divider))
	if progress_modifier < 0:
		if decrease_bad:
			pathos_desc_fmt["verb"] = "[color=red]decreases[/color]"
		else:
			pathos_desc_fmt["verb"] = "[color=green]decreases[/color]"
	elif progress_modifier > 0:
		if decrease_bad:
			pathos_desc_fmt["verb"] = "[color=green]increases[/color]"
		else:
			pathos_desc_fmt["verb"] = "[color=red]increases[/color]"
	elif progress_modifier == 0:
		pathos_description = ''
	pathos_desc_fmt["pct"] = str(round(abs(progress_modifier) * 100))
	if is_threshold_upgrade:
		pathos_desc_fmt["pct"] = "[color=yellow]%s[/color]" % [pathos_desc_fmt["pct"]]
	var cost_format := {
		"pathos_description": pathos_description.format(pathos_desc_fmt),
		"turns_needed": turns_needed,
		"delay_pct_explanation": '\nIt takes %s Journal encounters to be ready' % [turns_needed],
	}
	return(cost_format)


# Calculates how much pathos is needed to recall this memory, taking into account upgrades which
# might reduce this cost
func _calculate_recharge_time() -> void:
	recharge_time = definition.get("recharge_time", 2)
	if upgrades_amount and "recharge_time" in definition.get("keys_modified_by_upgrade", []):
		recharge_time += upgrades_amount * definition.amounts["upgrade_multiplier"]
	if recharge_time <= 1:
		recharge_time = 1
	# To avoid showing the player that a memory is 120% ready etc.
	if current_charge > recharge_time:
		current_charge = recharge_time


func get_class() -> String:
	return("MemoryObject")


func extract_save_state() -> Dictionary:
	var memory_dict := {
		"canonical_name": canonical_name,
		"is_ready": is_ready,
		"recharge_time": recharge_time,
		"current_charge": current_charge,
		"upgrades_amount" : upgrades_amount,
		"modifiers": modifiers,
	}
	return(memory_dict)
