class_name CombatEffect
extends CombatSignifier

var entity_type: String
var stacks: int setget set_stacks


func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	.setup(signifier_details, signifier_name)
	entity_type = signifier_details["entity_type"]
		
func set_stacks(value: int) -> void:
	signifier_amount.text = str(value)
	stacks = value


func _on_SingleIntent_mouse_entered() -> void:
	_set_current_description()
	._on_SingleIntent_mouse_entered()

# To override
func _set_current_description() -> void:
	pass


# Returns the lowercase name of the token
func get_effect_name() -> String:
	return(name.to_lower())
