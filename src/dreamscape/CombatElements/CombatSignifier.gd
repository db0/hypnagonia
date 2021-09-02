class_name CombatSignifier
extends Control

export(StreamTexture) var icon_container_texture :StreamTexture
var amount : int setget update_amount

onready var signifier_label := $Signifier/Label
onready var signifier_icon := $Signifier/Icon
onready var signifier_icon_container := $Signifier/IconContainer
onready var signifier_amount := $MC/Amount
onready var decription_popup := $Description
onready var decription_label := $Description/Label

var canonical_name: String

func _ready() -> void:
	if icon_container_texture:
		signifier_icon_container.texture = CFUtils.convert_texture_to_image(
				icon_container_texture, true)

func setup(signifier_details: Dictionary, signifier_name: String) -> void:
#	print_debug("Setting up intent: " + intent_name)
	canonical_name = signifier_name
	if signifier_details.has("icon") and signifier_details.icon:
		signifier_icon.texture = CFUtils.convert_texture_to_image(signifier_details.icon, true)
		signifier_label.visible = false
	else:		
		signifier_icon.visible = false
		signifier_label.text = signifier_name[0]
	if signifier_details.get("amount") != null:
		signifier_amount.text = str(signifier_details.amount)
	else:
		signifier_amount.visible = false
	if signifier_details.has("description"):
		decription_label.bbcode_text = signifier_details.description.format(Terms.get_bbcode_formats(18))
	else:
		decription_label.text = signifier_name


func _on_CombatSingifier_mouse_entered() -> void:
	decription_popup.visible = true
	decription_popup.rect_global_position = rect_global_position + Vector2(20,-decription_label.rect_size.y)
	if decription_popup.rect_global_position.x + decription_popup.rect_size.x > get_viewport().size.x:
		decription_popup.rect_global_position.x = get_viewport().size.x - decription_popup.rect_size.x - 10


func _on_CombatSingifier_mouse_exited() -> void:
	decription_popup.visible = false

func update_amount(value) -> void:
	amount = value
	signifier_amount.text = str(value)
