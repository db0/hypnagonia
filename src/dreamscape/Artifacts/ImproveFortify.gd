extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		if not cfc.NMAP.board.dreamer:
			yield(cfc.NMAP.board, "ready")
		cfc.NMAP.board.dreamer.connect("effect_modified", self, "_on_effect_modified")


func _on_effect_modified(
		_entity, _trigger: String, details: Dictionary) -> void:
	if details.get("effect_name") == Terms.ACTIVE_EFFECTS.fortify.name\
			and details.get(SP.TRIGGER_NEW_COUNT) < details.get(SP.TRIGGER_PREV_COUNT):
		var lost_fortify = details.get(SP.TRIGGER_PREV_COUNT) - details.get(SP.TRIGGER_NEW_COUNT)
		var script = [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
				"subject": "dreamer",
				"modification": lost_fortify,
				"tags": ["Curio"],
			},
		]
		execute_script(script)

func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()
