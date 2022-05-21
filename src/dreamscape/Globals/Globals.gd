extends Node

const PLAYER_COMBAT_ENTITY_SIZE = Vector2(120,120)

signal encounter_selected(encounter)

var load_start_time := OS.get_ticks_msec()

var player: Player
var encounters: SingleRun
var current_encounter: SingleEncounter setget set_current_encounter
var journal: Journal
var music: Music
var difficulty: Difficulty
var game_save: GameSave
# I use this to keep track of which journal texts I haven't used yet in this run
# to avoid writing always the same thing
var unused_journal_texts := {}
#var utils := DeckbuilderUtils.new()
var card_back_texture_selection := 0
# For Unit Testing
var test_flags := {
	### REFERENCES ###
#	# Loads the initial player deck to he board deck
#	"test_initial_hand": false, 
#	# prevents initial hand being drawn
#	"no_refill": true, 
#	# prevents starting artifacts being added
#	"disable_starting_artifacts": false, 
#	# prevents delay at end of turn
#	"no_end_turn_delay": true, 
#	# prevents torment animations
#	"no_ordeal_anims": true, 
#	# disables random board background
#	"disable_board_background": true, 
#	# disables board journal fade out
#	"no_journal_fade": true, 
#	# Custom curio definitions for testing
#	"artifact_defintions": {}, 
#	# Custom memory definitions for testing
#	"memory_defintions": {}, 
#   # Preselected random choice for use during testing
#   "test_rng_ndex": 0,
#   # Prevents the ordeal from starting during before_each()
#	"start_ordeal_before_each": true
#	test_artifact_prep : [],
#	test_memory_prep : [],
}

# Test setup. This should happen at game start
func _ready() -> void:
	var load_end_time = OS.get_ticks_msec()
	if OS.has_feature("debug") and not cfc.is_testing:
		print_debug("DEBUG INFO:Globals: instance time = %sms" % [str(load_end_time - load_start_time)])
		
	difficulty = Difficulty.new()
	music = Music.new()
	player = Player.new()
	encounters = SingleRun.new()
	game_save = GameSave.new()


func reset() -> void:
	player = Player.new()
	encounters = SingleRun.new()
	unused_journal_texts.clear()
	current_encounter = null
	journal = null


func quit_to_main() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(CFConst.PATH_CUSTOM + 'MainMenu/MainMenu.tscn')
	if "current_shop" in current_encounter:
		current_encounter.current_shop.queue_free()	
	cfc.quit_game()
	reset()


func hide_all_previews() -> void:
	cfc.hide_all_previews()
	for artifact_preview_node in cfc.get_tree().get_nodes_in_group("artifact_preview"):
		artifact_preview_node.hide_preview_artifact()

func set_current_encounter(value) -> void:
	current_encounter = value
	emit_signal("encounter_selected", value)

# Pause/Unpause music function
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		SoundManager.unpause_streams('BGM')
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		SoundManager.pause_streams('BGM')

func _exit_tree():
	print("Hypnagonia Exited Gracefully.")

func take_state_snapshot() -> float:
	var snapshot_id = rand_range(1,10000000)
	get_tree().call_group_flags(
			get_tree().GROUP_CALL_REALTIME, 
			"combat_effects", 
			"take_snapshot", 
			snapshot_id)
	get_tree().call_group_flags(
			get_tree().GROUP_CALL_REALTIME, 
			"CombatEntities", 
			"take_snapshot", 
			snapshot_id)
	return(snapshot_id)

func clear_state_snapshot(snapshot_id) -> void:
	get_tree().call_group_flags(
			get_tree().GROUP_CALL_REALTIME, 
			"combat_effects", 
			"clear_snapshot", 
			snapshot_id)
	get_tree().call_group_flags(
			get_tree().GROUP_CALL_REALTIME, 
			"CombatEntities", 
			"clear_snapshot", 
			snapshot_id)
