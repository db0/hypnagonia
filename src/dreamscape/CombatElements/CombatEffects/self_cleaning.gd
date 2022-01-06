extends CombatEffect

func _on_player_turn_ended(_turn: Turn) -> void:
	._on_player_turn_ended(_turn)
	if entity_type == Terms.PLAYER:
		_reduce_highest_stack()


func _on_enemy_turn_ended(_turn: Turn) -> void:
	._on_enemy_turn_ended(_turn)
	if entity_type == Terms.ENEMY:
		_reduce_highest_stack()


func _reduce_highest_stack():
	var effect = owning_entity.active_effects.get_effect_with_most_stacks("Debuff")
	if effect:
		 owning_entity.active_effects.mod_effect(effect, -stacks , false, false, ["Trigger"])
