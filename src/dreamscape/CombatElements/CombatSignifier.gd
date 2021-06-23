class_name CombatSignifier
extends HBoxContainer

onready var signifier_label := $Signifier/Label
onready var signifier_icon := $Signifier/Icon
onready var signifier_amount := $Amount
onready var decription_popup := $Description
onready var decription_label := $Description/Label

func setup(signifier_details: Dictionary, signifier_name: String) -> void:
#	print_debug("Setting up intent: " + intent_name)
	if signifier_details.has("icon") and signifier_details.icon:
		pass
	else:
		signifier_icon.visible = false
		signifier_label.text = signifier_name[0]
	if signifier_details.get("amount") != null:
		signifier_amount.text = str(signifier_details.amount)
	else:
		signifier_amount.visible = false
	if signifier_details.has("description"):
		decription_label.text = signifier_details.description
	else:
		decription_label.text = signifier_name
		


func _on_SingleIntent_mouse_entered() -> void:
	decription_popup.visible = true
	decription_popup.rect_global_position = rect_global_position - Vector2(0,30)


func _on_SingleIntent_mouse_exited() -> void:
	decription_popup.visible = false
