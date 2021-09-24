extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		globals.player.damage -= ArtifactDefinitions.StartingHeal.amounts.heal_amount
