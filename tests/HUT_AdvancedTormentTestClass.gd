extends "res://tests/HUTCommon.gd"

var advanced_torment_scene: PackedScene
var difficulty := 'normal'
var advanced_torment: EnemyEntity
var torments := []
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
	advanced_torment = advanced_torment_scene.instance()
	advanced_torment.setup_advanced(difficulty)
	board._enemy_area.add_child(advanced_torment)
	advanced_torment.connect("finished_activation", board, "_on_finished_enemy_activation")
