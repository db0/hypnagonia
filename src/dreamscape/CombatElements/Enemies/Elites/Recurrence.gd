extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "The Recurrence",
	"Health": 107,
	"Type": "Fear",
	"Damage": 0,
	"_texture_size_x": 160,
	"_texture_size_y": 160,
	"_character_art": 'Nobody',
	"_is_ordered": false,
	"_health_variability": 8,
}

var is_learning
var dreamer_attacks := []
var dreamer_defences := 0
var dreamer_heals := 0
var dreamer_damage := 0
var dreamer_effects := {}
var self_effects := {}

func _ready() -> void:
	if not cfc.NMAP.board.dreamer:
		yield(cfc.NMAP.board, "battle_begun")
	print_debug(cfc.NMAP.board.dreamer)
	cfc.NMAP.board.dreamer.connect("effect_modified", self, "_on_dreamer_effect_modified")
	cfc.NMAP.board.dreamer.connect("entity_defended", self, "_on_dreamer_defended")
	cfc.NMAP.board.dreamer.connect("entity_healed", self, "_on_dreamer_healed")
	cfc.NMAP.board.dreamer.connect("entity_damaged", self, "_on_dreamer_damaged")
	connect("effect_modified", self, "_on_self_effect_modified")
	connect("entity_attacked", self, "_on_self_attacked")


func _on_dreamer_effect_modified(
		_entity, _trigger: String, details: Dictionary) -> void:
	var effect_name = details.get("effect_name")
	if effect_name in Terms.get_all_effect_types("Buff", true)\
			or effect_name in Terms.get_all_effect_types("Debuff", true)\
			or effect_name in Terms.get_all_effect_types("Versatile", true):
		var count = details.get(SP.TRIGGER_NEW_COUNT) - details.get(SP.TRIGGER_PREV_COUNT)
		if is_learning and not "Turn Decrease" in details.tags and count > 0:
			dreamer_effects[effect_name] = count
#			print_debug("Recorded: %s : %s" % [details.get("effect_name"),count])


func _on_self_effect_modified(
		_entity, _trigger: String, details: Dictionary) -> void:
	var effect_name = details.get("effect_name")
	if effect_name in Terms.get_all_effect_types("Buff", true)\
			or effect_name in Terms.get_all_effect_types("Debuff", true)\
			or effect_name in Terms.get_all_effect_types("Versatile", true):
		var count = details.get(SP.TRIGGER_NEW_COUNT) - details.get(SP.TRIGGER_PREV_COUNT)
		if is_learning and not "Turn Decrease" in details.tags and count > 0:
			self_effects[effect_name] = count
#			print_debug("Recorded: %s : %s" % [details.get("effect_name"),count])


func _on_dreamer_defended(_entity, amount, _trigger, _tags) -> void:
	if is_learning:
		dreamer_defences += amount
#		print_debug("Defence learned: %s" % [amount])

func _on_dreamer_healed(_entity, amount, _trigger, _tags) -> void:
	if is_learning:
		dreamer_heals += amount
#		print_debug("Healing learned: %s" % [amount])

func _on_dreamer_damaged(_entity, amount, _trigger, tags) -> void:
	if is_learning and "Exert" in tags:
		dreamer_damage += amount
#		print_debug("Exert learned: %s" % [amount])

func _on_self_attacked(_entity, amount, _trigger, _tags) -> void:
	if is_learning:
		dreamer_attacks.append(amount)
#		print_debug("Attack learned: %s" % [amount])


func _on_enemy_turn_started(_turn: Turn) -> void:
	._on_enemy_turn_started(_turn)


func _on_enemy_turn_ended(_turn: Turn) -> void:
#	print_debug("cleaning")
	dreamer_attacks.clear()
	dreamer_defences = 0
	dreamer_heals = 0
	dreamer_damage = 0
	dreamer_effects.clear()
	self_effects.clear()
	._on_enemy_turn_ended(_turn)
