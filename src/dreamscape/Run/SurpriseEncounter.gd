# Surprise Encounters are NCEs that spring an surprise Ordeal on the player.
# As such, they need some functions that typically exist in combat encounters
class_name SurpriseEncounter
extends NonCombatEncounter

var surprise_combat_encounter: SurpriseCombatEncounter

func end() -> void:
	surprise_combat_encounter.finish_surpise_ordeal()
	.end()
