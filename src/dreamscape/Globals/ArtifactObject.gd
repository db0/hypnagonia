class_name ArtifactObject
extends Reference

signal removed
signal counter_modified(counter_value)

# Some artifact might need to track something. In which case we use this var.
var counter := 0
var artifact_scene: PackedScene
var canonical_name: String
var definition: Dictionary

func _init(artifact_name: String) -> void:
	artifact_scene = load(
			"res://src/dreamscape/Artifacts/{artifact_name}.tscn".format(
			{"artifact_name":artifact_name}))
	definition = ArtifactDefinitions[artifact_name].duplicate(true)
	canonical_name = definition["name"]

func remove_self() -> void:
	emit_signal("removed")
