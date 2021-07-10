class_name BossEncounter
extends CombatEncounter

var boss_name: String
var boss_scene: PackedScene

func _init(encounter: Dictionary, _boss_name: String):
	type = "boss"
	description = encounter["journal_description"]
	boss_name = _boss_name
	boss_scene = encounter['scene']
