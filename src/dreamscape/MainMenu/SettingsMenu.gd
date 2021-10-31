extends CenterContainer

onready var back_button = $PC/VBC/HBoxContainer/Back
onready var animate_in_hand = $PC/VBC/AnimateHand
onready var focus_style = $PC/VBC/FocusStyle
onready var fancy_movement = $PC/VBC/FancyAnimations
onready var recover_prebuilts = $PC/VBC/PreBuilts

func _ready() -> void:
#	cfc.game_settings['animate_in_hand'] = cfc.game_settings.get('animate_in_hand', false)
	cfc.game_settings['focus_style'] = cfc.game_settings.get('focus_style', 2)
	cfc.game_settings['fancy_movement'] = cfc.game_settings.get('fancy_movement', CFConst.FANCY_MOVEMENT)
	cfc.game_settings['enable_visible_shuffle'] = cfc.game_settings.get('enable_visible_shuffle', CFConst.FANCY_MOVEMENT)
#	animate_in_hand.pressed = cfc.game_settings.animate_in_hand
	if cfc.game_settings.focus_style == 2:
		focus_style.pressed = true
	else:
		focus_style.pressed = false
	fancy_movement.pressed = cfc.game_settings.fancy_movement

#func _on_AnimateBoard_toggled(button_pressed: bool) -> void:
#	cfc.set_setting('animate_on_board',button_pressed)
#
#
#func _on_AnimateHand_toggled(button_pressed: bool) -> void:
#	cfc.set_setting('animate_in_hand',button_pressed)


func _on_FancAnimations_toggled(button_pressed: bool) -> void:
	cfc.set_setting('fancy_movement',button_pressed)
	cfc.set_setting('enable_visible_shuffle',button_pressed)
	if button_pressed:
		get_tree().call_group("piles", "enable_shuffle")
	else:
		get_tree().call_group("piles", "disable_shuffle")


func _on_FocusStyle_toggled(button_pressed: bool) -> void:
	if not button_pressed:
		cfc.set_setting('focus_style', 0)
	else:
		cfc.set_setting('focus_style', 2)
