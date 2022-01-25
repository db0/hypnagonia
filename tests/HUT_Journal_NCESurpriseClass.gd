extends "res://tests/HUT_Journal_NCETestClass.gd"

var surprise_combat_encounter: SurpriseCombatEncounter

func begin_surprise_encounter(nce_script: SurpriseEncounter) -> void:
	nce_script.begin()
	surprise_combat_encounter = nce_script.surprise_combat_encounter

func end_surprise_encounter() -> void:
	surprise_combat_encounter.end()
