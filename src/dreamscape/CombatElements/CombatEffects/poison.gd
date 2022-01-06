extends CombatEffect


func _decrease_stacks() -> void:
	var script : Array
	var poison_damage = stacks
	# If Poison was going to kill the player, it tend to be a not fun-situation
	# (as the player can't do anything to prevent it)
	# So instead, we leave the player at 1, but we instead start burning their
	# highest released pathos at 5 times the damage they would take
	if owning_entity.type == Terms.PLAYER and owning_entity.damage + stacks > owning_entity.health:
		poison_damage = owning_entity.health - owning_entity.damage - 1
		var pathos_org = globals.player.pathos.get_pathos_org()
		var pathos = pathos_org.highest_pathos.selected
		var amount : float = (stacks - poison_damage) * -5
		var mid_pathos: String
		var mid_amount: float
		script = [{
				"name": "modify_pathos",
				"tags": ["Poison", "Combat Effect", "Debuff", "Poison"],
				"pathos": pathos,
				"pathos_type": "released",
				"amount": amount,
			}]
		if globals.player.pathos.released[pathos] + amount < 0:
			mid_pathos = pathos_org.middle_pathos.selected
			mid_amount = globals.player.pathos.released[pathos] + amount
			script.append({
					"name": "modify_pathos",
					"tags": ["Poison", "Combat Effect", "Debuff", "Poison"],
					"pathos": mid_pathos,
					"pathos_type": "released",
					"amount": mid_amount,
				})
		if poison_damage > 0:
			script.append({
				"name": "modify_damage",
				"subject": "self",
				"amount": poison_damage,
				"tags": ["Poison", "Combat Effect", "Debuff", "Poison"],
			})
		if OS.has_feature("debug"):
			print("DEBUG INFO:Effect: Player losing %s released %s instead of taking %s anxiety due to poison."\
					% [amount, pathos, stacks - poison_damage])
			if mid_amount < 0:
				print("DEBUG INFO:Effect: Player is also losing %s released %s to poison as they didn't have enough %s."\
						% [mid_amount, mid_pathos, pathos])
					
	else:
		script = [{
			"name": "modify_damage",
			"subject": "self",
			"amount": poison_damage,
			"tags": ["Poison", "Combat Effect", "Debuff", "Poison"],
		}]
	execute_script(script)
	set_stacks(stacks - 1, ["Turn Decrease"])
