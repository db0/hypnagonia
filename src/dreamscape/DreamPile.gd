class_name DreamPile
extends Pile

var _prev_shuffle_style


# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore:return_value_discarded
	$Control.connect("gui_input", self, "_on_DreamPile_input_event")
	# warning-ignore:return_value_discarded
	$Control.connect("mouse_entered", self, "_on_DreamPile_mouse_entered")
	# warning-ignore:return_value_discarded
	$Control.connect("mouse_exited", self, "_on_DreamPile_mouse_exited")
	if not cfc.game_settings.get('enable_visible_shuffle'):
		disable_shuffle()

func disable_shuffle() -> void:
	_prev_shuffle_style = shuffle_style
	shuffle_style = CFConst.ShuffleStyle.NONE

func enable_shuffle() -> void:
	shuffle_style = _prev_shuffle_style

func _on_DreamPile_input_event(event) -> void:
	if event.is_pressed() and event.get_button_index() == 1:
		if cfc.game_paused:
			return
		if get_card_count() == 0:
			return
		if position != Vector2(0,0):
			return
		if are_cards_still_animating():
			return
		if is_popup_open:
			return
		populate_popup()

func _on_DreamPile_mouse_entered() -> void:
	if not are_cards_still_animating():
		highlight.set_highlight(true)
	
func _on_DreamPile_mouse_exited() -> void:
	if not are_cards_still_animating():
		highlight.set_highlight(false)

