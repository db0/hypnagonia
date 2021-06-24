class_name CombatEffect
extends CombatSignifier

enum SELF_DECREASE {
	FALSE
	TURN_START
	TURN_END
}

export(SELF_DECREASE) var self_decreasing

var entity_type: String
var stacks: int = 0 setget set_stacks


func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	.setup(signifier_details, signifier_name)
	entity_type = signifier_details["entity_type"]


func _ready() -> void:
	var turn: Turn = cfc.NMAP.board.turn
	turn.connect("turn_ended",self,"_on_turn_ended")
	turn.connect("turn_started",self,"_on_turn_started")


func set_stacks(value: int) -> void:
	if value > 0:
		signifier_amount.text = str(value)
		stacks = value
	else:
		queue_free()


func _on_CombatSingifier_mouse_entered() -> void:
	_set_current_description()
	._on_CombatSingifier_mouse_entered()


# To override
func _set_current_description() -> void:
	pass


# Returns the lowercase name of the token
func get_effect_name() -> String:
	return(name.to_lower())


func _on_turn_ended(turn: Turn) -> void:
	if self_decreasing == SELF_DECREASE.TURN_START:
		set_stacks(stacks - 1)


func _on_turn_started(turn: Turn) -> void:
	if self_decreasing == SELF_DECREASE.TURN_END:
		set_stacks(stacks - 1)
