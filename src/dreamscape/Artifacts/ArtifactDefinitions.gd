class_name ArtifactDefinitions
extends Reference

# Defines when an artifact's effects are active.
# This allows us to know when to trigger artifact effects.
enum EffectContext {
	# This artifact's effects are active only outside battle
	OVERWORLD
	# This artifact's effects are active only during a battle
	BATTLE
	# This artifact triggers its effect only in the shop
	SHOP
}

const MaxHealth := {
	"name": "Unnamed1",
	"description": "{artifact_name}: max {health} inreased by 10",
	"icon": preload("res://assets/icons/artifacts/centaur-heart.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

const HealPerBattle := {
	"name": "Unnamed2",
	"description": "{artifact_name}: {heal} for 2 when you encounter a Torment",
	"icon": preload("res://assets/icons/artifacts/glass-heart.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

const FirstPowerAttack := {
	"name": "Unnamed3",
	"description": "{artifact_name}: Your first {attack} each encounter is increased by 8",
	"icon": preload("res://assets/icons/artifacts/binoculars.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}
