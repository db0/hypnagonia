extends Node

const PLAYER_COMBAT_ENTITY_SIZE = Vector2(120,120)

var player: Player
var encounters: SingleRun
var current_encounter: SingleEncounter
var journal: Journal
# I use this to keep track of which journal texts I haven't used yet in this run
# to avoid writing always the same thing
var unused_journal_texts := {}

# Test setup. This should happen at game start
func _ready() -> void:
	player = Player.new()
	encounters = SingleRun.new()

func reset() -> void:
	player = Player.new()
	encounters = SingleRun.new()
	current_encounter = null
	journal = null
