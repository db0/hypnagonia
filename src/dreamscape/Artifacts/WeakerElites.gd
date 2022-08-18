extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		EventBus.connect("battle_begun", self, "_on_battle_begun")


func _on_battle_begun():
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		if enemy._properties.get("Rank", "Basic") == "Elite":
			enemy.health -= enemy.health * float(ArtifactDefinitions.WeakerElites.amounts.health_reduction) / 100.0
			_send_trigger_signal() 
