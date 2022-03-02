class_name EnemyEncounter
extends CombatEncounter

const TORMENT_META_DICT := {
	"name": '',
	"meta_type": "popup_card",
}

var enemies: Array
var disabled_extra_draft_rewards := []

func _init(encounter: Dictionary, _difficulty: String):
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.enemy
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
#	print_debug(description.format(tag_format))
	return(description.format(tag_format))


func get_unique_enemies() -> Array:
	var unique_enemies := []
	for enemy_entry in enemies:
		var enemy : Dictionary = enemy_entry["definition"]
		if not enemy.Name in unique_enemies:
			unique_enemies.append(enemy.Name)
	return(unique_enemies)


func begin() -> void:
	if OS.has_feature("debug") and not cfc.get_tree().get_root().has_node('Gut'):
		var _debug_enemies := []
		for t in enemies:
			_debug_enemies.append(t.definition.Name)
		print("DEBUG INFO:Encounter: Torments Present: ", _debug_enemies)
	.begin()
	# Even though the next two lines should be in all combat encounters
	# I do not put them into the CombatEncounter begin() function
	# Because I would anwyay need the yield in this function
	# So it would just save me a single line,
	# and leaving it here, makes it more obvious what is happening.
	globals.journal.journal_cover.fade_to_black()
	yield(globals.journal.journal_cover, "fade_finished")
	current_combat = load(CFConst.PATH_CUSTOM + 'Main.tscn').instance()
	cfc.get_tree().get_root().call_deferred("add_child", current_combat)


func _on_board_instanced() -> void:
	cfc.NMAP.board.spawn_enemy_encounter(self)
	globals.music.switch_scene_music('ordeal')
	._on_board_instanced()


func end() -> void:
	.end()
	globals.journal.display_enemy_rewards(reward_description)


func return_extra_draft_cards() -> Array:
	var draft_rewards = get_unique_enemies()
	for enemy in disabled_extra_draft_rewards:
		if enemy in draft_rewards:
			draft_rewards.erase(enemy)
	return(draft_rewards)
