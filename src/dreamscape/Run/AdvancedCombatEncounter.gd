class_name AdvancedCombatEncounter
extends CombatEncounter

var enemy_scene: PackedScene
var enemy_entity: EnemyEntity

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


func _on_board_instanced() -> void:
	cfc.disconnect("all_nodes_mapped", self, "_on_board_instanced")
	enemy_entity = cfc.NMAP.board.spawn_advanced_enemy(self)
	globals.music.switch_scene_music('boss')
	._on_board_instanced()
