extends Memory

func execute_memory_effect() -> void:
	player_info_node.owner_node.reroll_shop()
#
#
#func _on_memory_ready(_memory: Reference) -> void:
#	._on_memory_ready(artifact_object)
#	if globals.current_encounter \
#			and "current_shop" in globals.current_encounter \
#			and globals.current_encounter.current_shop != null:
#		_switch_highlight_to(active_highlight)
#		globals.current_encounter.connect("encounter_end", self, "_on_encounter_end")
#	else:
#		while not is_instance_valid(globals.journal):
#			yield(get_tree(), "idle_frame")
#		globals.journal.connect("encounter_start", self, "_on_encounter_start")
#		_switch_highlight_to(inactive_highlight)
#
#
#func _use() -> void:
#	if active_highlight.visible:
#		artifact_object.use()
#		execute_memory_effect()
#
#
#func _on_encounter_start(encounter: SingleEncounter) -> void:
#	if encounter as ShopEncounter:
#		._on_memory_ready(artifact_object)
#	encounter.connect("encounter_end", self, "_on_encounter_end")
#
#
#func _on_encounter_end(encounter: SingleEncounter) -> void:
#	if artifact_object.is_ready:
#		_switch_highlight_to(inactive_highlight)
