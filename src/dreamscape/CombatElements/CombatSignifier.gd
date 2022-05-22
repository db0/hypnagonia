class_name CombatSignifier
extends Control

export(StreamTexture) var icon_container_texture :StreamTexture
export(StreamTexture) var icon_extra_container_texture :StreamTexture
var amount : int setget update_amount

onready var signifier_label := $Signifier/Label
onready var signifier_icon := $Signifier/Icon
onready var signifier_icon_container := $Signifier/IconContainer
onready var signifier_extra_container := $Signifier/ExtraContainer
onready var signifier_amount := $MC/Amount
onready var decription_popup := $Description
onready var decription_label := $Description/VBC/Label
onready var focus_info := $Description/VBC/DetailPanels
onready var anims = $AnimationPlayer

var canonical_name: String

func _ready() -> void:
	if icon_container_texture:
		signifier_icon_container.texture = CFUtils.convert_texture_to_image(
				icon_container_texture, true)
	if icon_extra_container_texture:
		signifier_extra_container.texture = CFUtils.convert_texture_to_image(
				icon_extra_container_texture, true)

func setup(signifier_details: Dictionary, signifier_name: String) -> void:
#	print_debug("Setting up intent: " + intent_name)
	canonical_name = signifier_name
	if signifier_details.has("icon") and signifier_details.icon:
		signifier_icon.texture = CFUtils.convert_texture_to_image(signifier_details.icon, true)
		signifier_label.visible = false
	else:		
		signifier_icon.visible = false
		signifier_label.text = signifier_name[0]
	if signifier_details.has("amount") and not signifier_details.get("hide_amount_in_intent"):
		update_amount(signifier_details.amount)
	elif signifier_details.has("modification") and signifier_details.get("show_modification_in_intent"):
		update_amount(signifier_details.modification)
	else:
		signifier_amount.visible = false
	if signifier_details.has("description"):
		decription_label.bbcode_text = signifier_details.description.format(Terms.get_bbcode_formats(18))
	else:
		decription_label.text = signifier_name


func _on_CombatSingifier_mouse_entered() -> void:
	decription_popup.visible = true
	decription_popup.rect_global_position = rect_global_position + Vector2(20,-decription_popup.rect_size.y)
	if decription_popup.rect_global_position.x + decription_popup.rect_size.x > get_viewport().size.x:
		decription_popup.rect_global_position.x = get_viewport().size.x - decription_popup.rect_size.x - 10


func _on_CombatSingifier_mouse_exited() -> void:
	decription_popup.visible = false

func update_amount(value) -> void:
	# If the value we're trying to assign is a string
	# It's propable a per definition, so we don't show it
	# We'll wait for the proper integer from the recalculations instead.
	if typeof(value) == TYPE_STRING:
		return
	amount = value
	signifier_amount.text = str(value)

func update_amount_animated(value, increase := true) -> void:
	if typeof(value) == TYPE_STRING:
		return
	var animation = "Increased"
	if not increase:
		animation = "Decreased"
	amount = value
	anims.play(animation)

func set_amount_from_int() -> void:
	signifier_amount.text = str(amount)
