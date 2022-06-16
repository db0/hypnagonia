class_name CombatEncounter
extends SingleEncounter

var reward_description: String
var current_combat: ViewportCardFocus
var difficulty: String = "medium"
	

func begin() -> void:
	# warning-ignore:return_value_discarded
	cfc.connect("all_nodes_mapped", self, "_on_board_instanced")
	.begin()


func end() -> void:
	cfc.quit_game()
	.end()


func start_ordeal() -> void:
	globals.journal.journal_cover.fade_to_black()
	yield(globals.journal.journal_cover, "fade_finished")
	current_combat = load(CFConst.PATH_CUSTOM + 'Main.tscn').instance()
	cfc.get_tree().get_root().call_deferred("add_child", current_combat)


func _on_board_instanced() -> void:
	cfc.disconnect("all_nodes_mapped", self, "_on_board_instanced")
	EventBus.connect("battle_ended", self, "end")
	EventBus.connect("game_over", self, "game_over")
	# We hide the journal black cover, so that when the board fades out
	# The journal appears behind it
	globals.journal.journal_cover.visible = false
	cfc.NMAP.board.begin_encounter()
