class_name BossEncounter
extends AdvancedCombatEncounter

func _init(encounter: Dictionary).(encounter):
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.boss

func end() -> void:
	.end()
	globals.journal.display_boss_rewards(reward_description)
