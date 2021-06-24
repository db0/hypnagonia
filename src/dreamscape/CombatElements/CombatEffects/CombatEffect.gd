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
var description_string := ''

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

# To override. This is called by the scripting engine
# Is source is telling this script whether we're checking for alterants affecting the 
# entity applying this effect, or the antity receiving this effect.
func get_effect_alteration(script: ScriptTask, value: int, sceng, is_source: bool, dry_run:= true) -> int:
	return(0)

func _on_CombatSingifier_mouse_entered() -> void:
	_set_current_description()
	._on_CombatSingifier_mouse_entered()


func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[entity_type].duplicate()
	format["effect_name"] = name
	format["amount"] = str(stacks)
	decription_label.text = description_string.format(format)

# Returns the lowercase name of the token
func get_effect_name() -> String:
	return(name.to_lower())


func _on_turn_ended(turn: Turn) -> void:
	if self_decreasing == SELF_DECREASE.TURN_START:
		set_stacks(stacks - 1)


func _on_turn_started(turn: Turn) -> void:
	if self_decreasing == SELF_DECREASE.TURN_END:
		set_stacks(stacks - 1)
