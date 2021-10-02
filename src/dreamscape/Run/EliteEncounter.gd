class_name EliteEncounter
extends CombatEncounter

var enemy_scene: PackedScene

func _init(encounter: Dictionary, _difficulty: String):
	description = encounter["journal_description"]
	reward_description = encounter["journal_reward"]
	enemy_scene = encounter['scene']
	difficulty = _difficulty
	prepare_journal_art(encounter)

func begin() -> void:
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.elite)
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

func end() -> void:
	current_combat.queue_free()
	yield(cfc.get_tree().create_timer(0.1), "timeout")
	cfc.NMAP.clear()
	cfc.are_all_nodes_mapped = false
	globals.journal.display_elite_rewards(reward_description)
