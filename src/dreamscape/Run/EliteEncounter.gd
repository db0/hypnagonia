class_name EliteEncounter
extends AdvancedCombatEncounter

func _init(encounter: Dictionary, _difficulty: String).(encounter):
	difficulty = _difficulty

func end() -> void:
	.end()
	globals.journal.display_elite_rewards(reward_description)
