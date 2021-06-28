extends TargetingArrow

# Will end the targeting process.
#
# The top targetable object which is hovered (if any) will become the target and inserted
# into the target_object property for future use.
func complete_targeting() -> void:
	if len(_potential_targets) and is_targeting:
		target_object = _potential_targets.back()
	emit_signal("target_selected",target_object)
	is_targeting = false
	clear_points()
	$ArrowHead.visible = false
	$ArrowHead/Area2D.monitoring = false
	if target_object:
		print_debug(target_object.canonical_name)


# Triggers when a targetting arrow hovers over a combat entity while being dragged
func _on_ArrowHead_area_entered(area: Area2D) -> void:
	._on_ArrowHead_area_entered(area)
	if area.get_class() == 'CombatEntity' and not area.get_combat_entity() in _potential_targets:
		_potential_targets.append(area.get_combat_entity())
		if 'highlight' in owner_object:
			owner_object.highlight.highlight_potential_card(
					CFConst.TARGET_HOVER_COLOUR, _potential_targets)


# Triggers when a targetting arrow stops hovering over a combat entity
func _on_ArrowHead_area_exited(area: Area2D) -> void:
	._on_ArrowHead_area_exited(area)
	if area.get_class() == 'CombatEntity' and area.get_combat_entity() in _potential_targets:
		# We remove the card we stopped hovering from the _potential_targets
		var combat_entity = area.get_combat_entity()
		_potential_targets.erase(combat_entity)
		# And we explicitly hide its cards focus since we don't care about it anymore
		if 'highlight' in combat_entity:
			combat_entity.highlight.set_highlight(false)
		# Finally, we make sure we highlight any other cards we're still hovering
		if not _potential_targets.empty() and 'highlight' in owner_object:
			owner_object.highlight.highlight_potential_card(
				CFConst.TARGET_HOVER_COLOUR,
				_potential_targets)


