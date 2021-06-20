class_name SingleIntent
extends HBoxContainer

onready var intent_label := $IntentIcon/Label
onready var intent_icon := $IntentIcon/Icon
onready var intent_amount := $Amount
onready var decription_popup := $Description
onready var decription_label := $Description/Label

func setup(intent_details: Dictionary, intent_name: String) -> void:
#	print_debug("Setting up intent: " + intent_name)
	if intent_details.has("icon") and intent_details.icon:
		pass
	else:
		intent_icon.visible = false
		intent_label.text = intent_name[0]
	if intent_details.get("amount") != null:
		intent_amount.text = str(intent_details.amount)
	else:
		intent_amount.visible = false
	if intent_details.has("description"):
		decription_label.text = intent_details.description
	else:
		decription_label.text = intent_name
		


func _on_SingleIntent_mouse_entered() -> void:
	decription_popup.visible = true
	decription_popup.rect_global_position = rect_global_position - Vector2(0,30)


func _on_SingleIntent_mouse_exited() -> void:
	decription_popup.visible = false
