class_name AdvancedCombatEncounter
extends CombatEncounter

var enemy_scene: PackedScene

func _init(encounter: Dictionary, _difficulty := "medium"):
	description = encounter.get("journal_description", '')
	reward_description = encounter.get("journal_reward", '')
	enemy_scene = encounter['scene']
	difficulty = _difficulty
	prepare_journal_art(encounter)


func begin() -> void:
	.begin()
	start_ordeal()

func start_ordeal() -> void:
	globals.journal.journal_cover.fade_to_black()
	yield(globals.journal.journal_cover, "fade_finished")
	current_combat = load(CFConst.PATH_CUSTOM + 'Main.tscn').instance()
	cfc.get_tree().get_root().call_deferred("add_child", current_combat)
	yield(cfc, "all_nodes_mapped")
	# We hide the journal black cover, so that when the board fades out
	# The journal appears behind it
	globals.journal.journal_cover.visible = false
	cfc.NMAP.board.spawn_advanced_enemy(self)
	cfc.NMAP.board.begin_encounter()
	globals.music.switch_scene_music('boss')
