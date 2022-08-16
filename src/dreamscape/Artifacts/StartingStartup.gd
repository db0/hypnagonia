extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.connect("all_nodes_mapped", self, "_on_all_nodes_mapped")


func _on_all_nodes_mapped():
	if not _activate():
		return
	var script = [
		{
			"name": "spawn_card_to_container",
			"card_filters": [
				{
					'property': 'Tags',
					'value': Terms.GENERIC_TAGS.startup.name,
				},
				{
					'property': '_is_upgrade',
					'value': false,
				}
			],
			"immediate_placement": true,
			"dest_container": "deck",
			"object_count": ArtifactDefinitions.StartingStartup.amounts.card_amount,
			"tags": ["Card"],
		},
		{
			"name": "shuffle_container",
			"tags": ["Card"],
			"dest_container": "deck",
		},
	]
	execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()
