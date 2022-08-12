extends "res://tests/HUTCommon_Journal.gd"

var CE := load("res://src/dreamscape/Run/EnemiesEncounter.gd")
var JOURNAL_ENCOUNTER_CHOICE_SCENE = load("res://src/dreamscape/Overworld/JournalEncounterChoiceScene.tscn")

var gut_enemy_definition = {
	"name": "GUT",
	"title": "This is a Test",
	"journal_description":\
		"This [url={torment_tag1}]is a test[/url].",
	"journal_reward":\
		'GUT Rewards.',
#	"journal_art": preload("res://assets/journal/torments/cringelord.jpeg"),
	"enemies": {
		"easy": [
			{
				"definition": GUT_TORMENT,
			},
		],
		"medium": [
			{
				"definition": GUT_TORMENT,
			},
		],
		"hard": [
			{
				"definition": GUT_TORMENT,
			},
		],
	},
}

var ce: CombatEncounter
var journal_choice_scene
var test_torment : EnemyEntity
var test_torments := []

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	add_ce()
	watch_signals(journal)
	
func add_ce(torments_amount := 1) -> void:
	ce = CE.new(gut_enemy_definition, "medium")
	journal_choice_scene = JOURNAL_ENCOUNTER_CHOICE_SCENE.instance()
	journal.journal_choices.add_child(journal_choice_scene)
	journal_choice_scene.setup(journal, ce)
	journal_choice_scene.journal_choice.connect("pressed", journal, "_on_choice_pressed", [ce, journal_choice_scene])
	journal._reveal_entry(journal_choice_scene.journal_choice)

func add_starting_effect(effect_name: String, stacks: int) -> void:
	var eff_deff = {
		"name": effect_name,
		"stacks": stacks,
	}
	for diff in ['easy','medium', 'hard']:
		for torment in gut_enemy_definition['enemies'][diff]:
			torment["starting_effects"] = torment.get("starting_effects", [])
			torment["starting_effects"].append(eff_deff)
	
func begin_enemy_encounter() -> void:
	ce.begin()
	yield(yield_to(cfc, "all_nodes_mapped", 3), YIELD)
	assert_has(cfc.NMAP, "board")
	if not cfc.NMAP.has("board"):
		return
	yield(yield_to(EventBus, "battle_begun", 2), YIELD)
	test_torments = get_tree().get_nodes_in_group("EnemyEntities")
	if test_torments.size() > 0:
		test_torment = get_tree().get_nodes_in_group("EnemyEntities")[0]
	board = cfc.NMAP.board
	deck = cfc.NMAP.deck
	discard = cfc.NMAP.discard
	forgotten = cfc.NMAP.forgotten
	hand = cfc.NMAP.hand
	main = cfc.NMAP.main
			
func end_enemy_encounter() -> void:
	ce.end()
