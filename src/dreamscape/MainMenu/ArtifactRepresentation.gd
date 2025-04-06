class_name ArtifactRepresentation
extends CenterContainer

onready var _artifact_icon:= $Icon

func setup(artifact: String) -> void:
	name = artifact
	var tex = ArtifactDefinitions[artifact].icon
	# This means there's no dedicated texture for that tag specified.
	if tex:
		_artifact_icon.texture = CFUtils.convert_texture_to_image(tex)
