extends Node

const PLAYER_COMBAT_ENTITY_SIZE = Vector2(120,120)

var player: Player
var encounters: SingleRun
var encounter_number := 1

# Test setup. This should happen at game start
func _ready() -> void:
	player = Player.new()
	encounters = SingleRun.new()
	
