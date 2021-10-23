extends CombatEffect

func _ready():
	owning_entity.connect("entity_damaged", self, "_on_entity_damaged")

func _on_entity_damaged(_entity, _amount, trigger: Node, _tags: Array) -> void:
	if cfc.NMAP.board.turn.current_turn != cfc.NMAP.board.turn.Turns.PLAYER_TURN:
		return
	if entity_type != Terms.PLAYER:
		return
	owning_entity.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.armor.name, 1)
