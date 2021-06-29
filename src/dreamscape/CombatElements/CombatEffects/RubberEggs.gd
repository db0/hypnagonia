extends CombatEffect

const _description_string := "{effect_name}: At the start of your turn, Interpret a random Confused {enemy} for 6."

func _ready() -> void:
	description_string = _description_string
	cfc.NMAP.board.turn.connect("turn_started", self, "_on_turn_started")


func _on_turn_started(turn: Turn) -> void:
	._on_turn_started(turn)
	var all_enemies := get_tree().get_nodes_in_group("EnemyEntities")
	CFUtils.shuffle_array(all_enemies)
	for rng_enemy in all_enemies:
#		if rng_enemy.active_effects.get_effect(ActiveEffects.NAMES.disempower):
		var script = [{
			"name": "modify_health",
			"subject": "trigger",
			"amount": 6,
			"tags": ["Damage"],
		}]
		execute_script(script, rng_enemy)
		break
	
