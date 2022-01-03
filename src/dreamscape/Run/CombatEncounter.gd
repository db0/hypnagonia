class_name CombatEncounter
extends SingleEncounter

var reward_description: String
var current_combat: ViewportCardFocus
var difficulty: String = "medium"
	

func end() -> void:
	cfc.quit_game()
	.end()
