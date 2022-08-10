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
	description = globals.ai_stories.retrieve_torment_story(encounter)
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
	if OS.has_feature("debug") and not cfc.is_testing:
		var _debug_enemies := []
		for t in enemies:
			_debug_enemies.append(t.definition.Name)
		print("DEBUG INFO:Encounter: Torments Present: ", _debug_enemies)
	.begin()
	start_ordeal()


func _on_board_instanced() -> void:
	cfc.NMAP.board.spawn_enemy_encounter(self)
	globals.music.switch_scene_music('ordeal')
	._on_board_instanced()


func end() -> void:
	.end()
	# We're doing an if-clause to avoid failing during fast testing teradown
	if is_instance_valid(globals.journal):
		globals.journal.display_enemy_rewards(reward_description)


func return_extra_draft_cards() -> Array:
	var draft_rewards = get_unique_enemies()
	for enemy in disabled_extra_draft_rewards:
		if enemy in draft_rewards:
			draft_rewards.erase(enemy)
	return(draft_rewards)
