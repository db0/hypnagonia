class_name CostDiscount
extends Node

var card_filters: Array
var counter := "Immersion"
var discount_amount := -1
# If it is not permanent, it will be removed at the end of the round
var is_permanent := false
var uses := 1
var canonical_name := 'Cost Discounter'

func _init(
		_discount_amount = -1,
		_uses = 1,
		_card_filters = [],
		_counter = counter,
		_is_permanent = false) -> void:
	discount_amount = _discount_amount
	uses = _uses
	card_filters = _card_filters
	counter = _counter
	is_permanent = is_permanent

func _ready() -> void:
	add_to_group("scriptables")
	cfc.signal_propagator.connect("signal_received", self, "_on_signal_received")
	if not is_permanent:
		cfc.NMAP.board.turn.connect("enemy_turn_started", self, "_enemy_turn_started")

func retrieve_scripts(trigger: String) -> Dictionary:
	if uses == 0:
		return({})
	if trigger != SP.KEY_ALTERANTS:
		return({})
	var alterant := {
		"discount": [
			{
				"filter_task": "get_property",
				"filter_property_name": "Cost",
				"alteration": discount_amount,
				"filter_state_trigger": [
					{"filter_cardfilters": card_filters}
				],
			},
		]
	}
	return(alterant)


func get_state_exec() -> String:
	return("discount")



func _on_signal_received(trigger_card, trigger, details) -> void:
	if not trigger == "card_played":
		return
	var card_matches = true
	for filter in card_filters:
		if not filter.check_card(trigger_card.properties):
			card_matches = false
	if card_matches:
		uses -= 1
	if uses == 0:
		_remove_discounter()


func _enemy_turn_started(turn) -> void:
	_remove_discounter()

func execute_scripts(_trigger_card,_trigger,_details) -> void:
	return

func _clear_visible_discounts() -> void:
	for card in get_tree().get_nodes_in_group("cards"):
		card.refresh_card_front()

func _remove_discounter() -> void:
	queue_free()
	cfc.flush_cache()
	
