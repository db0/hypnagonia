extends CombatEffect


func _decrease_stacks() -> void:
	var script : Array = []
	var poison_damage = stacks
	# If Poison was going to kill the player, it tend to be a not fun-situation
	# (as the player can't do anything to prevent it)
	# So instead, we leave the player at 1, but we instead start burning their
	# pathos masteries equal to 1 for every 5 damage (min 1)
	if owning_entity.type == Terms.PLAYER and owning_entity.damage + stacks > owning_entity.health:
		poison_damage = owning_entity.health - owning_entity.damage - 1
		var amount : float = ceil((stacks - poison_damage) / 3)
		globals.player.pathos.available_masteries -= amount
		if poison_damage > 0:
			script.append({
				"name": "modify_damage",
				"subject": "self",
				"amount": poison_damage,
				"tags": ["Poison", "Combat Effect", "Debuff"],
			})
		if OS.has_feature("debug") and not cfc.is_testing:
			print("DEBUG INFO:Effect: Player losing %s pathos masteries instead of taking %s anxiety due to poison."\
					% [amount, stacks - poison_damage])
					
	else:
		script = [{
			"name": "modify_damage",
			"subject": "self",
			"amount": poison_damage,
			"tags": ["Poison", "Combat Effect", "Debuff", "Poison"],
		}]
	execute_script(script)
	set_stacks(stacks - 1, ["Turn Decrease"])
