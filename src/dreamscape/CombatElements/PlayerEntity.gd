class_name PlayerEntity
extends CombatEntity

signal incoming_signifier_set(signifier)

var upgrades_increased := 0 setget set_upgrades_increased
# Holds the node which shows how much damage is incoming to the player
var incoming_dmg_signifier : Control = null

# This variable will point to the scene which controls the targeting arrow
onready var targeting_arrow = $TargetLine
onready var incoming_background = $CenterContainer/IncomingBackground
onready var damaged_shader := $HBC/MC/DamagedShader
onready var blocked_shader := $HBC/Defence/BlockedShader

func _ready() -> void:
	entity_type = "dreamer"
# warning-ignore:return_value_discarded
	connect("entity_damaged", self, "_on_player_damaged")
# warning-ignore:return_value_discarded
	connect("entity_damage_blocked", self, "_on_entity_damage_blocked")

func _map_nodes() -> void:
	_health_stats = $HBC/MC/HBC
	health_label = $HBC/MC/HBC/Health
	defence_icon = $HBC/Defence/Icon
	defence_label = $HBC/Defence/Amount
	health_bar = $HBC/MC/HealthBar
	health_temp = $HBC/MC/HealthTemp
	health_incoming = $HBC/MC/HealthIncoming
	active_effects = $HBC2/ActiveEffects

func set_upgrades_increased(value) -> void:
	upgrades_increased = value
	# The player can only upgrade a number of cards equal to their deck size
	# This allows us to avoid punishing larger decks
	var upgrade_threshold = globals.player.deck.count_cards()
	if upgrades_increased >= upgrade_threshold:
		stop_upgrades()

func stop_upgrades() -> void:
	active_effects.mod_effect(
		Terms.ACTIVE_EFFECTS.creative_block.name, 1, true, false, ["Core"])


func show_turn_dmg_prediction(dmg_from_intents := 0, removed_defence := 0) -> void:
	var taken_anxiety : int = (
			dmg_from_intents
			+ active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.burn.name)
			- defence
			+ removed_defence)
	if taken_anxiety < 0:
		return
	var poison_stacks = active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name)
	# Because poison will never kill the dreamer, we want to avoid showing it causing anxiety
	# when it would be causing pathos burn
	if poison_stacks > 0 and damage + taken_anxiety + poison_stacks > health:
		poison_stacks = health - damage - taken_anxiety - 1
		if poison_stacks < 0:
			poison_stacks = 0
	taken_anxiety += poison_stacks
	var new_dmg_signifier = show_predictions(taken_anxiety, Terms.get_term_value("Anxiety", "icon"))
	if is_instance_valid(incoming_dmg_signifier):
		incoming_dmg_signifier.call_deferred("queue_free")
	incoming_dmg_signifier = new_dmg_signifier
	emit_signal("incoming_signifier_set",new_dmg_signifier)
	health_incoming.max_value = health
	health_incoming.value = damage + taken_anxiety




# We store how many times the player has been damaged during their own turn
# We also store the cumulative amount of damage the player has taken during their turn.
func _on_player_damaged(_pl, amount, _trigger, _tags) -> void:
	# warning-ignore:return_value_discarded
	TurnEventMessage.new("player_damaged", +1)
	# warning-ignore:return_value_discarded
	TurnEventMessage.new("player_total_damage", amount)
	if cfc.NMAP.board.turn.current_turn == cfc.NMAP.board.turn.Turns.PLAYER_TURN:
		# warning-ignore:return_value_discarded
		TurnEventMessage.new("player_damaged_own_turn", +1)
		# warning-ignore:return_value_discarded
		TurnEventMessage.new("player_total_damage_own_turn", amount)
	damaged_shader.take_damage()


func _on_entity_damage_blocked(_pl, _amount, _trigger, _tags) -> void:
	blocked_shader.take_damage()


func _input(event) -> void:
	if event is InputEventMouseButton and not event.is_pressed():
		if targeting_arrow.is_targeting:
			targeting_arrow.complete_targeting()



func _on_Incoming_resized():
	incoming_background.rect_min_size = incoming.rect_size
	incoming_background.rect_min_size.x += 10
	incoming_background.rect_min_size.y -= 5

