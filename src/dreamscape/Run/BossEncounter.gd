class_name BossEncounter
extends AdvancedCombatEncounter

func _init(encounter: Dictionary).(encounter):
	pass

func end() -> void:
	.end()
	globals.journal.display_boss_rewards(reward_description)
