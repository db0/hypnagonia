extends HBoxContainer

const ARTIFACT_CHOICE_SCENE = preload("res://src/dreamscape/ArtifactChoiceObject.tscn")

var memory_prep : MemoryPrep
var upgrades : int

func display(reward_payload) -> void:
	visible = true
	populate_memories(reward_payload)
	$Tween.interpolate_property(get_parent(),
			'rect_min_size:y', 0, CFConst.CARD_SIZE.y * CFConst.THUMBNAIL_SCALE, 1.0,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()


func populate_memories(reward_payload = 1) -> void:
	var quantity = reward_payload.quantity
	upgrades = reward_payload.upgrades
	memory_prep = MemoryPrep.new(quantity, true)
	for index in range(memory_prep.selected_memories.size()):
		var memory: Dictionary = memory_prep.selected_memories[index]
		if memory.canonical_name in globals.player.get_all_memory_names():
			var existing_memory = globals.player.find_memory(memory.canonical_name)
			memory["upgrades"] = existing_memory.upgrades_amount + upgrades - 1
			memory["is_upgrade"] = true
		var memory_object = ARTIFACT_CHOICE_SCENE.instance()
		add_child(memory_object)
		memory_object.setup(memory, memory.canonical_name)
		memory_object.index = index
		memory_object.connect("artifact_selected", self, "_on_artifact_selected", [memory_object])
#	yield(get_tree().create_timer(0.15), "timeout")
#	call_deferred('set_size',Vector2(0,0))
	globals.journal.artifact_selection_started(self)


func _on_artifact_selected(_option: int, memory_object) -> void:
	for child in get_children():
		if child != memory_object:
			$Tween.interpolate_property(child,
					'modulate:a', 1, 0, 0.7,
					Tween.TRANS_SINE, Tween.EASE_IN)
		else:
			child.disconnect("artifact_selected", self, "_on_artifact_selected")
			child.apply_shader("res://shaders/grayscale.shader")
	$Tween.start()
	yield($Tween, "tween_all_completed")
	for child in get_children():
		if child != memory_object:
			child.queue_free()
# warning-ignore:return_value_discarded
	var existing_memory = globals.player.find_memory(memory_object.canonical_name)
	if existing_memory:
		existing_memory.upgrades_amount += upgrades
	else:
		globals.player.add_memory(memory_object.canonical_name)
