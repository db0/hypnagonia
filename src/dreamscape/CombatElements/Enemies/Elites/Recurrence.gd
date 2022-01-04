extends AdvancedEnemyEntity

signal learning_finished(reports)

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

var countermeasures = globals.encounters.run_changes.store.get("Recurrence", [])
# Countermeasure flags to be used by intents (to avoid adding dozens of vars)
var cm_flags := {}

var is_learning = true
var dreamer_attacks := []
var dreamer_defences := 0
var dreamer_heals := 0
var dreamer_damage := 0
var dreamer_effects := {}
var self_effects := {}
var cards_played := 0

func _ready() -> void:
	if not cfc.NMAP.board.dreamer:
		yield(cfc.NMAP.board, "battle_begun")
	cfc.NMAP.board.dreamer.connect("effect_modified", self, "_on_dreamer_effect_modified")
	cfc.NMAP.board.dreamer.connect("entity_defended", self, "_on_dreamer_defended")
	cfc.NMAP.board.dreamer.connect("entity_healed", self, "_on_dreamer_healed")
	cfc.NMAP.board.dreamer.connect("entity_damaged", self, "_on_dreamer_damaged")
	cfc.signal_propagator.connect("signal_received", self, "_on_card_signal_received")
# warning-ignore:return_value_discarded
	connect("effect_modified", self, "_on_self_effect_modified")
# warning-ignore:return_value_discarded
	connect("entity_attacked", self, "_on_self_attacked")
	_prepare_countermeasures()
	if get_property("_difficulty") == "medium":
		set_health(health * 2)
	elif get_property("_difficulty") == "hard":
		set_health(health * 3)


func _on_dreamer_effect_modified(
		_entity, _trigger: String, details: Dictionary) -> void:
	var effect_name = details.get("effect_name")
	if effect_name in Terms.get_all_effect_types("Buff", true)\
			or effect_name in Terms.get_all_effect_types("Debuff", true)\
			or effect_name in Terms.get_all_effect_types("Versatile", true):
		var count = details.get(SP.TRIGGER_NEW_COUNT) - details.get(SP.TRIGGER_PREV_COUNT)
		if is_learning and not "Turn Decrease" in details.tags and count > 0:
			dreamer_effects[effect_name] = dreamer_effects.get(effect_name, 0) + count
#			print_debug("Recorded: %s : %s" % [details.get("effect_name"),count])


func _on_self_effect_modified(
		_entity, _trigger: String, details: Dictionary) -> void:
	var effect_name = details.get("effect_name")
	if effect_name in Terms.get_all_effect_types("Buff", true)\
			or effect_name in Terms.get_all_effect_types("Debuff", true)\
			or effect_name in Terms.get_all_effect_types("Versatile", true):
		var count = details.get(SP.TRIGGER_NEW_COUNT) - details.get(SP.TRIGGER_PREV_COUNT)
		if is_learning and not "Turn Decrease" in details.tags and count > 0:
			self_effects[effect_name] = self_effects.get(effect_name,0) + count
#			print_debug("Recorded: %s : %s" % [details.get("effect_name"),count])


func _on_dreamer_defended(_entity, amount, _trigger, _tags) -> void:
	if is_learning:
		dreamer_defences += amount
#	print_debug("Defence learned: %s" % [amount])

func _on_dreamer_healed(_entity, amount, _trigger, _tags) -> void:
	if is_learning:
		dreamer_heals += amount
#		print_debug("Healing learned: %s" % [amount])

func _on_dreamer_damaged(_entity, amount, _trigger, _tags) -> void:
	if is_learning:
		dreamer_damage += amount
#		print_debug("Exert learned: %s" % [amount])

func _on_self_attacked(_entity, amount, _trigger, _tags) -> void:
	if is_learning:
		dreamer_attacks.append(amount)
#		print_debug("Attack learned: %s" % [amount])

func _on_card_signal_received(_trigger_card, trigger, _details) -> void:
	if is_learning and trigger == "card_played":
		cards_played += 1
#		print_debug("Card played")

func _on_enemy_turn_started(_turn: Turn) -> void:
	# It is not learning from its own cards
	is_learning = false
	._on_enemy_turn_started(_turn)


func _on_enemy_turn_ended(_turn: Turn) -> void:
	is_learning = true
	_digest_learning()
	dreamer_attacks.clear()
	dreamer_defences = 0
	dreamer_heals = 0
	dreamer_damage = 0
	dreamer_effects.clear()
	self_effects.clear()
	cards_played = 0
	._on_enemy_turn_ended(_turn)


func _digest_learning() -> void:
	var lessons_learned := {
		"attacks": dreamer_attacks.duplicate(),
		"defences": dreamer_defences,
		"heals": dreamer_heals,
		"buffs": dreamer_effects.duplicate(),
		"debuffs": self_effects.duplicate(),
		"cards": cards_played
	}
	emit_signal("learning_finished", lessons_learned)


func _exit_tree():
	_digest_learning()

func _prepare_countermeasures() -> void:
	# Normally we wouldn't need to do these conditions, but until we have enough torments
	# to never repeat encounters, we need to take care of this.
	if get_property("_difficulty") == "easy":
		return
	var immunities := []
	var resistances := []
	for cm in countermeasures:
		match cm:
			"high_attacks":
				cm_flags["high_attacks"] = cm_flags.get("high_attacks",0) + 1
			"high_defences":
				cm_flags["high_defences"] = cm_flags.get("high_defences",0) + 1
			"average_attacks":
				cm_flags["average_attacks"] = cm_flags.get("average_attacks",0) + 1
			Terms.ACTIVE_EFFECTS.thorns.name:
				cm_flags[Terms.ACTIVE_EFFECTS.thorns.name] = cm_flags.get(Terms.ACTIVE_EFFECTS.thorns.name,0) + 1
			Terms.ACTIVE_EFFECTS.poison.name,\
			Terms.ACTIVE_EFFECTS.burn.name,\
			Terms.ACTIVE_EFFECTS.disempower.name,\
			Terms.ACTIVE_EFFECTS.marked.name:
				if cm in resistances:
					immunities.append(cm)
					resistances.erase(cm)
				else:
					resistances.append(cm)
		# Again, only need this while we have only a few risky NCEs and there's
		# a chance this encounter will repeat in Act2
		if get_property("_difficulty") != "medium":
			break
	for cm in immunities:
		active_effects.mod_effect(Terms.ACTIVE_EFFECTS.effect_immunity.name, 1, false, false, ["Init"], cm)
	for cm in resistances:
		active_effects.mod_effect(Terms.ACTIVE_EFFECTS.effect_resistance.name, 1, false, false, ["Init"], cm)
