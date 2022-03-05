class_name AdvancedCombatEncounter
extends CombatEncounter

var enemy_scenes := []
var basic_enemies := []
var enemy_entities: Array

func _init(encounter: Dictionary, _difficulty := "medium"):
	description = encounter.get("journal_description", '')
	reward_description = encounter.get("journal_reward", '')
	# If no advanced enemy scenes are there, there should be some basic enemies defined
	enemy_scenes = encounter.get('scenes',[])
	difficulty = _difficulty
	# Advanced Combat Encounters might also have some basic enemies
	# They can be defined in the same format as other basic enemies
	# with a key for easy,medium,hard difficulty, or just with an array which stays the same per difficulty
	if encounter.has('basic_enemies'):
		if typeof(encounter['basic_enemies']) == TYPE_ARRAY:
			basic_enemies = encounter['basic_enemies']
		else:
			basic_enemies = encounter['basic_enemies'].get(difficulty,[])
	prepare_journal_art(encounter)


func begin() -> void:
	.begin()
	start_ordeal()


func _on_board_instanced() -> void:
	cfc.disconnect("all_nodes_mapped", self, "_on_board_instanced")
	enemy_entities = cfc.NMAP.board.spawn_advanced_enemy(self)
	globals.music.switch_scene_music('boss')
	._on_board_instanced()
