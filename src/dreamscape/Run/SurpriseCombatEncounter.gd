# Surprise Combat Encounter are typically called from within NCE, rather than
# directly from the journal
# They act as advanced enemies
class_name SurpriseCombatEncounter
extends AdvancedCombatEncounter

var owner_nce


func _init(encounter: Dictionary, difficulty: String, nce).(encounter, difficulty):
	owner_nce = nce

func finish_surpise_ordeal() -> void:
	# Likewise we don't have an .end() as that will be called on the parent NCE.
	# The parent NCE should in turn call this function when that happens
	# to clear the board
	cfc.quit_game()
