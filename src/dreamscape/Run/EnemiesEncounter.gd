class_name EnemyEncounter
extends CombatEncounter

const TORMENT_META_DICT := {
	"name": '',
	"meta_type": "torment_card",
}

var enemies: Array


func _init(encounter: Dictionary, _difficulty: String):
	description = encounter["journal_description"]
	difficulty = _difficulty
	enemies = encounter["enemies"][difficulty]
	reward_description = encounter["journal_reward"]
	prepare_journal_art(encounter)


func get_formated_description() -> String:
	var rtag_index = 1
	var tag_format := {}
	for torment_name in get_unique_enemies():
		var rich_text_format_tag = "torment_tag" + str(rtag_index)
		rtag_index += 1
		var torment_tag = TORMENT_META_DICT.duplicate(true)
		torment_tag["name"] = torment_name
		tag_format[rich_text_format_tag] = JSON.print(torment_tag)
	return(description.format(tag_format))


func get_unique_enemies() -> Array:
	var unique_enemies := []
	for enemy_entry in enemies:
		var enemy : Dictionary = enemy_entry["definition"]
		if not enemy.Name in unique_enemies:
			unique_enemies.append(enemy.Name)
	return(unique_enemies)


func begin() -> void:
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.enemy)
	.begin()
	globals.journal.journal_cover.fade_to_black()
	yield(globals.journal.journal_cover, "fade_finished")
	current_combat = load(CFConst.PATH_CUSTOM + 'Main.tscn').instance()
	cfc.get_tree().get_root().call_deferred("add_child", current_combat)
	yield(cfc, "all_nodes_mapped")
	globals.journal.journal_cover.visible = false
	cfc.NMAP.board.spawn_enemy_encounter(self)
	cfc.NMAP.board.begin_encounter()


func end() -> void:
	current_combat.queue_free()
	yield(cfc.get_tree().create_timer(0.1), "timeout")
	cfc.NMAP.clear()
	cfc.are_all_nodes_mapped = false
	globals.journal.display_rewards(reward_description)


func return_extra_draft_cards() -> Array:
	return(get_unique_enemies())
