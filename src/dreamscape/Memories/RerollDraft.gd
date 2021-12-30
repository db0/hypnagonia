extends Memory

func execute_memory_effect() -> void:
	for node in _get_active_card_drafts():
		node.reroll_card_draft()


func _on_memory_ready(_memory: Reference) -> void:
	._on_memory_ready(artifact_object)
	if _get_active_card_drafts().size() > 0:
		_switch_highlight_to(active_highlight)
		for draft_node in _get_active_card_drafts():
			draft_node.connect("card_drafted", self, "_on_card_drafted")
	else:
		while not is_instance_valid(globals.journal):
			yield(get_tree(), "idle_frame")
		globals.journal.connect("card_draft_started", self, "_on_card_draft_started")
		_switch_highlight_to(inactive_highlight)

func _use() -> void:
	if active_highlight.visible:
		artifact_object.use()
		execute_memory_effect()


func _get_active_card_drafts() -> Array:
	var active_drafts := []
	for node in  get_tree().get_nodes_in_group("card_draft"):
		if not node.selected_draft and node.card_draft_type != '':
			active_drafts.append(node)
	return(active_drafts)


func _on_card_draft_started(draft_node: Node) -> void:
	if artifact_object.is_ready:
		._on_memory_ready(artifact_object)
	draft_node.connect("card_drafted", self, "_on_card_drafted")


func _on_card_drafted(_card) -> void:
	if artifact_object.is_ready and _get_active_card_drafts().size() == 0:
		_switch_highlight_to(inactive_highlight)
