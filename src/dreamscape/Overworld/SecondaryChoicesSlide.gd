class_name SecondaryChoiceSlide
extends MarginContainer

signal secondary_choice_selected(choice_key)

onready var scroll_container := $SC
onready var secondary_choices_container := $SC/SecondaryChoices
onready var _tween := $SC/Tween
# The current encounter is the default, but any other node might be connected to the result of
# the choices instead.
# To do so, it has to have a "continue_encounter" method defined
onready var calling_node = globals.current_encounter

func display() -> void:
	visible = true
	_tween.interpolate_property(scroll_container,
			'rect_min_size:y', 0, secondary_choices_container.rect_size.y, 1.0,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	_tween.start()
#	print_debug(secondary_choices_container.rect_size.y)
#	for c in secondary_choices_container.get_children():
#		print_debug(c.text, c.rect_size.y)

func populate_choices(nested_choices: Dictionary, _journal, disabled_choices := []) -> void:
	secondary_choices_container.rect_min_size.x = rect_size.x - get("custom_constants/margin_left")
	for choice_key in nested_choices:
			var secondary_choice = JournalNestedChoice.new(_journal, nested_choices[choice_key], choice_key)
			secondary_choice.rect_min_size.x = rect_size.x - get("custom_constants/margin_left")
			secondary_choices_container.add_child(secondary_choice)
			if not choice_key in disabled_choices:
				secondary_choice.connect(
						"pressed", 
						self, 
						"_on_choice_pressed", 
						[secondary_choice, choice_key])
			else:
				secondary_choice.self_modulate = Color(0.1,0.1,0.1)
	call_deferred("display")


func _on_choice_pressed(
		rich_text_choice: JournalNestedChoice,
		choice_key) -> void:
	for choice in secondary_choices_container.get_children():
		if choice != rich_text_choice:
			choice.disable()
		else:
			_tween.interpolate_property(scroll_container,
					'rect_min_size:y', scroll_container.rect_min_size.y, choice.rect_size.y, 1.0,
					Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			_tween.start()
	globals.hide_all_previews()
	calling_node.call_deferred("continue_encounter", choice_key)
	emit_signal("secondary_choice_selected", choice_key)
