extends Node

const PLAYER_COMBAT_ENTITY_SIZE = Vector2(70,100)

var player: Player

# Test setup. This should happen at game start
func _ready() -> void:
	player = Player.new()
