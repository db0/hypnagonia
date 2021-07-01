extends CombatEffect

# This is effectively like poison in other vg-deckbuilders

func _on_enemy_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.ENEMY:
		poison_courses()

func _on_player_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.PLAYER:
		poison_courses()

func poison_courses() -> void:
	var script = [{
		"name": "modify_damage",
		"subject": "self",
		"amount": stacks,
		"tags": ["Poison"],
	}]
	execute_script(script)
	set_stacks(stacks - 1)
