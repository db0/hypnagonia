class_name NewGameMenu
extends PanelContainer

const ARCHETYPE_SCENE := preload("res://src/dreamscape/MainMenu/Archetype.tscn")

onready var _choice_popup := $ChoicePopup
onready var _archetype_starting_cards_display := $ChoicePopup/CC/VBC/StartginCardsDisplay
onready var _archetype_starting_cards_tags := $ChoicePopup/CC/VBC/Tags
onready var _aspect_choices := $ChoicePopup/CC/VBC/CC/ChoiceContainer
onready var _starting_cards_popup := $StartingCardsPopup
onready var _all_starting_cards_display := $StartingCardsPopup/VBC/StartingCards
onready var _all_starting_cards_tags := $StartingCardsPopup/VBC/Tags
onready var _aspect_description_label := $ChoicePopup/CC/VBC/Description
onready var _starting_cards_button := $VBC/ControlButtons/VBC/StartingCards
onready var _start_button := $VBC/ControlButtons/VBC/Start
onready var _choice_tween := $VBC/CC/Choices/Tween
onready var _aspect_buttons := {
	"Ego": $VBC/CC/Choices/Ego/MC/Ego,
	"Disposition": $VBC/CC/Choices/Disposition/MC/Disposition,
	"Instrument": $VBC/CC/Choices/Instrument/MC/Instrument,
	"Injustice": $VBC/CC/Choices/Injustice/MC/Injustice,
}
onready var _aspect_icons := {
	"Ego": $VBC/CC/Choices/Ego/MC/Icon,
	"Disposition": $VBC/CC/Choices/Disposition/MC/Icon,
	"Instrument": $VBC/CC/Choices/Instrument/MC/Icon,
	"Injustice": $VBC/CC/Choices/Injustice/MC/Icon,
}
onready var back_button := $VBC/ControlButtons/VBC/Back

func _ready() -> void:
	for button_name in _aspect_buttons:
		var choice_button: Button = _aspect_buttons[button_name]
		var choice_icon: TextureRect = _aspect_icons[button_name]
		# warning-ignore:return_value_discarded
		choice_button.connect("pressed", self, "on_aspect_button_pressed", [button_name])
		# warning-ignore:return_value_discarded
		choice_button.connect("mouse_entered", self, "on_aspect_icon_mouse_entered", [choice_icon])
		# warning-ignore:return_value_discarded
		choice_button.connect("mouse_exited", self, "on_aspect_icon_mouse_exited", [choice_icon])
	get_viewport().connect("size_changed", self, '_on_Menu_resized')

func on_aspect_button_pressed(button_name : String):
	populate_choices(button_name)
	_choice_popup.rect_size = Vector2(0,0)
	_choice_popup.popup_centered_minsize()
	_archetype_starting_cards_display.clear()
	_archetype_starting_cards_tags.clear()
	_archetype_starting_cards_display.rect_min_size.x = _choice_popup.rect_size.x


func populate_choices(aspect: String) -> void:
	for node in _aspect_choices.get_children():
		node.queue_free()
	for archetype in Aspects.get_all_archetypes_list(aspect):
		var archetype_button = ARCHETYPE_SCENE.instance()
		_aspect_choices.add_child(archetype_button)
		archetype_button.setup(aspect, archetype)
		_aspect_description_label.text = Aspects.ARCHETYPES[aspect]["Description"]
		archetype_button.button.connect("pressed", self, "_on_archetype_choice_pressed", [archetype, aspect, archetype_button])
		archetype_button.button.connect("mouse_entered", self, "_on_archetype_mouse_entered", [archetype])


static func randomize_aspect_choices() -> Dictionary:
	var randomized_archetypes := {}
	for aspect in Terms.CARD_GROUP_TERMS.values():
		var archetypes: Array = Aspects.get_all_archetypes_list(aspect)
		CFUtils.shuffle_array(archetypes)
		globals.player.deck_groups[aspect] = archetypes[0]
		randomized_archetypes[aspect] = archetypes[0]
	return(randomized_archetypes)

func start_new_game() -> void:
	cfc.game_rng_seed = CFUtils.generate_random_seed()
	globals.player.setup()
	globals.encounters.setup()
	get_parent().menu_tween.interpolate_property(get_parent().get_node("FadeToBlack"),
			'modulate:a', 0, 1, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	get_parent().menu_tween.start()
	yield(get_parent().menu_tween, "tween_all_completed")
	# warning-ignore:return_value_discarded
	get_tree().change_scene(CFConst.PATH_CUSTOM + 'Overworld/Journal.tscn')


func _on_archetype_choice_pressed(archetype: String, _aspect: String, archetype_button) -> void:
	var aspect := _aspect.capitalize()
	var aspect_button = _aspect_buttons[aspect]
	aspect_button.text = archetype
	if archetype_button.archetype_texture:
		_aspect_icons[_aspect].texture = archetype_button.archetype_texture
		_aspect_icons[_aspect].visible = true
	else:
		_aspect_icons[_aspect].visible = false
	_choice_popup.hide()
	globals.player.deck_groups[aspect] = archetype
	if globals.player.is_deck_completed():
		_start_button.disabled = false
	_starting_cards_button.disabled = false


func _on_Start_pressed() -> void:
	start_new_game()


func _on_archetype_mouse_entered(archetype: String) -> void:
	_archetype_starting_cards_display.populate_starting_cards([archetype], _choice_popup)
	var tags : Array = Aspects.get_archetype_value(archetype, "Tags")
	_archetype_starting_cards_tags.populate_tags(tags)


func _on_StartingCards_pressed() -> void:
	_starting_cards_popup.rect_size = Vector2(1000,400)
	_starting_cards_popup.popup_centered()
	_all_starting_cards_display.rect_min_size.x = _starting_cards_popup.rect_size.x
	var current_deck_archetypes : Array = globals.player.get_current_archetypes()
	_all_starting_cards_display.populate_starting_cards(current_deck_archetypes, _starting_cards_popup)
	var all_tags := []
	for archetype in current_deck_archetypes:
		for tag in Aspects.get_archetype_value(archetype, "Tags"):
			if not tag in all_tags:
				all_tags.append(tag)
	_all_starting_cards_tags.populate_tags(all_tags)


func _on_Randomize_pressed() -> void:
	var selected_archetypes := randomize_aspect_choices()
	for aspect in selected_archetypes:
		var aspect_button = _aspect_buttons[aspect]
		aspect_button.text = selected_archetypes[aspect]
		var icon_texture := ArchetypeButton.retrieve_icon(aspect, selected_archetypes[aspect])
		if icon_texture:
			_aspect_icons[aspect].texture = icon_texture
			_aspect_icons[aspect].visible = true
		else:
			_aspect_icons[aspect].visible = false
	_start_button.disabled = false
	_starting_cards_button.disabled = false


func on_aspect_icon_mouse_entered(icon: TextureRect) -> void:
	_choice_tween.interpolate_property(icon, 'modulate:a',
			icon.modulate.a, 0.20, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_choice_tween.start()


func on_aspect_icon_mouse_exited(icon: TextureRect) -> void:
	_choice_tween.interpolate_property(icon, 'modulate:a',
			icon.modulate.a, 1, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_choice_tween.start()
#
func _on_Menu_resized() -> void:
	for button in _aspect_buttons.values():
		button.rect_min_size.x = get_viewport().size.x * 0.185
		button.rect_min_size.y = get_viewport().size.y * 0.43
	for b in $VBC/ControlButtons/VBC.get_children():
		b.rect_min_size.x = get_viewport().size.x * 0.274
		b.rect_min_size.y = get_viewport().size.y * 0.05
	for m in [$VBC/MarginUp, $VBC/MarginDown]:
		m.rect_min_size.y = get_viewport().size.y * 0.05
	$VBC/ControlButtons/VBC.set("custom_constants/separation", get_viewport().size.y * 0.02)
	_archetype_starting_cards_tags.rect_min_size.y = get_viewport().size.y * 0.08
	_archetype_starting_cards_display.rect_min_size.x = get_viewport().size.x * 0.54
	_archetype_starting_cards_display.rect_min_size.y = get_viewport().size.y * 0.31
