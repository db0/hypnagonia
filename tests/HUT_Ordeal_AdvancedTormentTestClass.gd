extends "res://tests/HUTCommon_Ordeal.gd"

var advanced_torment_scene: PackedScene
var advanced_torment_scenes: Array
var difficulty := 'medium'
var advanced_torment: EnemyEntity
var advanced_torments := []
var intents_to_test := [
#	{
#		"intent_scripts": ["Stress:10"],
#		"reshuffle": true,
#	},
]

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	if advanced_torment_scenes.size() > 0:
		for atorment in advanced_torment_scenes:
			setup_advanced_torment(atorment)
	else:
		setup_advanced_torment(advanced_torment_scene)

func after_each():
	advanced_torments.clear()
	.after_each()
	yield(yield_for(0.1), YIELD)
	
func setup_advanced_torment(ascene: PackedScene) -> void:
	advanced_torment = ascene.instance()
	advanced_torment.setup_advanced(difficulty)
	board._enemy_area.add_child(advanced_torment)
	board.emit_signal("enemy_spawned",advanced_torment)
	advanced_torment.connect("finished_activation", board, "_on_finished_enemy_activation")
	advanced_torments.append(advanced_torment)
