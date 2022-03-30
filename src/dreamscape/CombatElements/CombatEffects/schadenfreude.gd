extends CombatEffect

var gathered_damage := 0

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		_connect_entity_signals(enemy)
	cfc.NMAP.board.connect("enemy_spawned", self, "_connect_entity_signals")

func _on_player_turn_started(_turn: Turn) -> void:
	if gathered_damage == 0:
		return
	var divider : int = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_divider")
	var effect_stacks = int(floor(float(stacks) * float(gathered_damage) / divider))
	print_debug([effect_stacks,stacks,gathered_damage,divider])
	var script = [
		{
			"name": "apply_effect",
			"tags": ["Concentration", "Combat Effect"],
			"subject": "dreamer",
			"modification": effect_stacks,
			"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
		},
	]
	execute_script(script)
	gathered_damage = 0

func _on_enemy_effect_damaged(_entity: CombatEntity, amount: int, _trigger, tags: Array) -> void:
	if cfc.NMAP.board.turn.current_turn == cfc.NMAP.board.turn.Turns.PLAYER_TURN:
		return
	gathered_damage += amount

func _connect_entity_signals(enemy: EnemyEntity) -> void:
	# warning-ignore:return_value_discarded
	enemy.connect("entity_damaged", self, "_on_enemy_effect_damaged")
