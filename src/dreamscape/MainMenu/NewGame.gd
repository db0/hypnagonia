extends PanelContainer

const ARCHETYPE_SCENE := preload("res://src/dreamscape/MainMenu/Archetype.tscn")

onready var _choice_popup := $ChoicePopup
onready var _archetype_starting_cards_display := $ChoicePopup/CC/VBC/StartginCardsDisplay
onready var _archetype_starting_cards_tags := $ChoicePopup/CC/VBC/Tags
onready var _archetype_choices := $ChoicePopup/CC/VBC/CC/ChoiceContainer
onready var _starting_cards_popup := $StartingCardsPopup
onready var _all_starting_cards_display := $StartingCardsPopup/VBC/StartingCards
onready var _all_starting_cards_tags := $StartingCardsPopup/VBC/Tags
onready var _archetype_description_label := $ChoicePopup/CC/VBC/Description
onready var _starting_cards_button := $VBC/ControlButtons/VBC/StartingCards
onready var _start_button := $VBC/ControlButtons/VBC/Start
onready var _choice_tween := $VBC/CC/Choices/Tween
onready var _choice_buttons := {
	"Ego": $VBC/CC/Choices/Ego/MC/Ego,
	"Disposition": $VBC/CC/Choices/Disposition/MC/Disposition,
	"Instrument": $VBC/CC/Choices/Instrument/MC/Instrument,
	"Injustice": $VBC/CC/Choices/Injustice/MC/Injustice,
}
onready var _choice_icons := {
	"Ego": $VBC/CC/Choices/Ego/MC/Icon,
	"Disposition": $VBC/CC/Choices/Disposition/MC/Icon,
	"Instrument": $VBC/CC/Choices/Instrument/MC/Icon,
	"Injustice": $VBC/CC/Choices/Injustice/MC/Icon,
}
onready var back_button := $VBC/ControlButtons/VBC/Back

func _ready() -> void:
	for button_name in _choice_buttons:
		var choice_button: Button = _choice_buttons[button_name]
		var choice_icon: TextureRect = _choice_icons[button_name]
		# warning-ignore:return_value_discarded
		choice_button.connect("pressed", self, "on_choice_button_pressed", [button_name])
		# warning-ignore:return_value_discarded
		choice_button.connect("mouse_entered", self, "on_choice_icon_mouse_entered", [choice_icon])
		# warning-ignore:return_value_discarded
		choice_button.connect("mouse_exited", self, "on_choice_icon_mouse_exited", [choice_icon])


func on_choice_button_pressed(button_name : String):
	populate_choices(button_name)
	_choice_popup.rect_size = Vector2(0,0)
	_choice_popup.popup_centered_minsize()
	_archetype_starting_cards_display.rect_min_size.x = _choice_popup.rect_size.x


func populate_choices(archetype: String) -> void:
	for node in _archetype_choices.get_children():
		node.queue_free()
	for type in get_all_types_list(archetype):
		var archetype_button = ARCHETYPE_SCENE.instance()
		_archetype_choices.add_child(archetype_button)
		archetype_button.setup(archetype, type)
		_archetype_description_label.text = CardGroupDefinitions.ARCHETYPES[archetype]
		archetype_button.button.connect("pressed", self, "_on_archetype_choice_pressed", [type, archetype, archetype_button])
		archetype_button.button.connect("mouse_entered", self, "_on_archetype_mouse_entered", [type])


func randomize_archetype_choices() -> Dictionary:
	var randomized_archetypes := {}
	for archetype in Terms.CARD_GROUP_TERMS.values():
		var types: Array = get_all_types_list(archetype)
		CFUtils.shuffle_array(types)
		globals.player.deck_groups[archetype] = types[0]
		randomized_archetypes[archetype] = types[0]
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


func _on_archetype_choice_pressed(type: String, _archetype: String, type_button) -> void:
	var archetype := _archetype.capitalize()
	var archetype_button = _choice_buttons[archetype]
	archetype_button.text = type
	if type_button.archetype_texture:
		_choice_icons[_archetype].texture = type_button.archetype_texture
		_choice_icons[_archetype].visible = true
	_choice_popup.hide()
	globals.player.deck_groups[archetype] = type
	if globals.player.is_deck_completed():
		_start_button.disabled = false
	_starting_cards_button.disabled = false


func _on_Start_pressed() -> void:
	start_new_game()


func _on_archetype_mouse_entered(type: String) -> void:
	_archetype_starting_cards_display.populate_starting_cards([type], _choice_popup)
	var tags : Array = CardGroupDefinitions.get_archetype_value(type, "Tags")
	_archetype_starting_cards_tags.populate_tags(tags)


func _on_StartingCards_pressed() -> void:
	_starting_cards_popup.rect_size = Vector2(1000,400)
	_starting_cards_popup.popup_centered()
	_all_starting_cards_display.rect_min_size.x = _starting_cards_popup.rect_size.x
	var current_deck_archetypes := globals.player.get_currrent_archetypes()
	_all_starting_cards_display.populate_starting_cards(current_deck_archetypes, _starting_cards_popup)
	var all_tags := []
	for archetype in current_deck_archetypes:
		for tag in CardGroupDefinitions.get_archetype_value(archetype, "Tags"):
			if not tag in all_tags:
				all_tags.append(tag)
	_all_starting_cards_tags.populate_tags(all_tags)


func _on_Randomize_pressed() -> void:
	var selected_archetypes := randomize_archetype_choices()
	for archetype in selected_archetypes:
		var archetype_button = _choice_buttons[archetype]
		archetype_button.text = selected_archetypes[archetype]
		var icon_texture := ArchetypeButton.retrieve_icon(archetype, selected_archetypes[archetype])
		if icon_texture:
			_choice_icons[archetype].texture = icon_texture
			_choice_icons[archetype].visible = true
	_start_button.disabled = false
	_starting_cards_button.disabled = false


static func get_all_types_list(archetype: String) -> Array:
	var valid_types_list := []
	for type in CardGroupDefinitions[archetype.to_upper()]:
		if not CardGroupDefinitions[archetype.to_upper()][type].get("_is_inactive"):
			valid_types_list.append(type)
	return(valid_types_list)


func on_choice_icon_mouse_entered(icon: TextureRect) -> void:
	_choice_tween.interpolate_property(icon, 'modulate:a',
			icon.modulate.a, 0.20, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_choice_tween.start()


func on_choice_icon_mouse_exited(icon: TextureRect) -> void:
	_choice_tween.interpolate_property(icon, 'modulate:a',
			icon.modulate.a, 1, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_choice_tween.start()
