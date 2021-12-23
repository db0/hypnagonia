class_name BossEncounter
extends CombatEncounter

var enemy_name: String
var enemy_scene: PackedScene

func _init(encounter: Dictionary, _boss_name: String):
	description = encounter["journal_description"]
	reward_description = encounter["journal_reward"]
	enemy_name = _boss_name
	enemy_scene = encounter['scene']

func begin() -> void:
	# warning-ignore:return_value_discarded
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.boss)
	.begin()
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

func end() -> void:
	current_combat.queue_free()
	yield(cfc.get_tree().create_timer(0.1), "timeout")
	cfc.NMAP.clear()
	cfc.are_all_nodes_mapped = false
	globals.journal.display_boss_rewards(reward_description)
