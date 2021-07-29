class_name BossEncounter
extends CombatEncounter

var boss_name: String
var boss_scene: PackedScene

func _init(encounter: Dictionary, _boss_name: String):
	description = encounter["journal_description"]
	reward_description = encounter["journal_reward"]
	boss_name = _boss_name
	boss_scene = encounter['scene']

func begin() -> void:
	.begin()
	current_combat = load(CFConst.PATH_CUSTOM + 'Main.tscn').instance()
	cfc.get_tree().get_root().call_deferred("add_child", current_combat)
	yield(cfc, "all_nodes_mapped")
	cfc.NMAP.board.spawn_boss_encounter(self)
	cfc.NMAP.board.begin_encounter()

func end() -> void:
	current_combat.queue_free()
	yield(cfc.get_tree().create_timer(0.1), "timeout")
	cfc.NMAP.clear()
	cfc.are_all_nodes_mapped = false
	globals.journal.display_boss_rewards(reward_description)
