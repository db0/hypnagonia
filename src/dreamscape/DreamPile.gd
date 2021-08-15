class_name DreamPile
extends Pile

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore:return_value_discarded
	$Control.connect("gui_input", self, "_on_DreamPile_input_event")
	# warning-ignore:return_value_discarded
	$Control.connect("mouse_entered", self, "_on_DreamPile_mouse_entered")
	# warning-ignore:return_value_discarded
	$Control.connect("mouse_exited", self, "_on_DreamPile_mouse_exited")

func _on_DreamPile_input_event(event) -> void:
	if event.is_pressed()\
			and not cfc.game_paused\
			and get_card_count() > 0\
			and position == Vector2(0,0)\
			and not are_cards_still_animating()\
			and event.get_button_index() == 1:
		populate_popup()

func _on_DreamPile_mouse_entered() -> void:
	if not are_cards_still_animating():
		highlight.set_highlight(true)
	
func _on_DreamPile_mouse_exited() -> void:
	if not are_cards_still_animating():
		highlight.set_highlight(false)
