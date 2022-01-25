class_name CombatEncounter
extends SingleEncounter

var reward_description: String
var current_combat: ViewportCardFocus
var difficulty: String = "medium"
	

func begin() -> void:
	cfc.connect("all_nodes_mapped", self, "_on_board_instanced")
	.begin()


func end() -> void:
	cfc.quit_game()
	.end()


func _on_board_instanced() -> void:
	cfc.disconnect("all_nodes_mapped", self, "_on_board_instanced")
	cfc.NMAP.board.connect("battle_ended", self, "end")
	cfc.NMAP.board.connect("game_over", self, "game_over")
	# We hide the journal black cover, so that when the board fades out
	# The journal appears behind it
	globals.journal.journal_cover.visible = false
	cfc.NMAP.board.begin_encounter()
