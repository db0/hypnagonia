class_name ArtifactsList
extends ObjectInfoList

const ARTIFACT_ICON_SCENE = preload("res://src/dreamscape/MainMenu/ArtifactRepresentation.tscn")


func _ready() -> void:
	list_description.text = "Starting Curios:"


func _show_description_popup(artifact: String, popup_anchor: Node) -> void:
	var description = ArtifactDefinitions[artifact].description.format(
			ArtifactDefinitions.get_artifact_bbcode_format(ArtifactDefinitions[artifact]))
	_display_popup(popup_anchor, description)


func populate_artifacts(list: Array) -> void:
	var artifact_names := []
	for artifact_def in list:
		artifact_names.append(artifact_def.canonical_name)
	populate_list(artifact_names, ARTIFACT_ICON_SCENE)
