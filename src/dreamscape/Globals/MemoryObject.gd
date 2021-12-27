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
	pathos_threshold = globals.player.pathos.get_progression_average(pathos_used)\
			* definition["pathos_threshold_average_multiplier"]
	modifiers = _mods
	# warning-ignore:return_value_discarded
	globals.player.pathos.connect("pathos_released", self, "_on_pathos_released")


func remove_self() -> void:
	emit_signal("removed")

func accumulate_pathos(value: int) -> void:
	pathos_accumulated += value
	emit_signal("pathos_accumulated", self, value)
	if pathos_accumulated >= pathos_threshold:
		pathos_accumulated = pathos_threshold
		is_ready = true
		emit_signal("memory_ready", self)

func use() -> void:
	is_ready = false
	pathos_accumulated = 0
	emit_signal("memory_used", self)

func instance_memory() -> Artifact:
	var memory: Artifact = memory_scene.instance()
	memory.name = canonical_name
	var script_path := "res://src/dreamscape/Memories/%s.gd" % [canonical_name]
	var script_exists = Directory.new()
	if script_exists.file_exists(script_path):
		var memory_script = load(script_path)
		memory.set_script(memory_script)
	return(memory)

func _on_pathos_released(pathos: String, amount: int) -> void:
	if pathos == pathos_used:
		# warning-ignore:integer_division
		var acc := int(round(amount/2))
		accumulate_pathos(acc)
