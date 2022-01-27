extends HBoxContainer

const ARTIFACT_CHOICE_SCENE = preload("res://src/dreamscape/ArtifactChoiceObject.tscn")

var artifact_prep : ArtifactPrep

func display(reward_type = "elite_artifact") -> void:
	visible = true
	populate_artifacts(reward_type)
	$Tween.interpolate_property(get_parent(),
			'rect_min_size:y', 0, CFConst.CARD_SIZE.y * CFConst.THUMBNAIL_SCALE, 1.0,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()


func populate_artifacts(reward_type = "elite_artifact") -> void:
	var rare_pct: int
	var uncommon_pct: int
	var quantity: int
	var artifact_type: String
	match reward_type:
		"elite_artifact":
			rare_pct = 5
			uncommon_pct = 30
			quantity = 1
			artifact_type = 'generic'
		"boss_artifact":
			rare_pct = 100
			uncommon_pct = 0
			quantity = 3
			artifact_type = 'boss'
	artifact_prep = ArtifactPrep.new(rare_pct, uncommon_pct, quantity, artifact_type)
	for index in range(artifact_prep.selected_artifacts.size()):
		var artifact: Dictionary = artifact_prep.selected_artifacts[index]
		var artifact_object = ARTIFACT_CHOICE_SCENE.instance()
		add_child(artifact_object)
		artifact_object.setup(artifact, artifact.canonical_name)
		artifact_object.index = index
		artifact_object.connect("artifact_selected", self, "_on_artifact_selected", [artifact_object])
#	yield(get_tree().create_timer(0.15), "timeout")
#	call_deferred('set_size',Vector2(0,0))
	globals.journal.artifact_selection_started(self)


func _on_artifact_selected(_option: int, artifact_object) -> void:
	for child in get_children():
		if child != artifact_object:
			$Tween.interpolate_property(child,
					'modulate:a', 1, 0, 0.7,
					Tween.TRANS_SINE, Tween.EASE_IN)
		else:
			child.disconnect("artifact_selected", self, "_on_artifact_selected")
			child.apply_shader("res://shaders/grayscale.shader")
	$Tween.start()
	yield($Tween, "tween_all_completed")
	for child in get_children():
		if child != artifact_object:
			child.queue_free()
# warning-ignore:return_value_discarded
	globals.player.add_artifact(artifact_object.canonical_name)
