class_name PlayerEntity
extends CombatEntity

var upgrades_increased := 0 setget set_upgrades_increased

func _ready() -> void:
	entity_type = "dreamer"

func set_upgrades_increased(value) -> void:
	upgrades_increased = value
	# The player can only upgrade a number of cards equal to their deck size
	# This allows us to avoid punishing larger decks
	if upgrades_increased >= globals.player.deck.count_cards():
		active_effects.mod_effect(
			"Creative Block",
			1,
			true,
			false,
			["Core"])
