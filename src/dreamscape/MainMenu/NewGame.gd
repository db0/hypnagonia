extends PanelContainer

const ARCHETYPE_SCENE := preload("res://src/dreamscape/MainMenu/Archetype.tscn")

onready var _choice_popup = $ChoicePopup
onready var _archetype_starting_cards_display = $ChoicePopup/CC/VBC/StartginCardsDisplay
onready var _archetype_choices = $ChoicePopup/CC/VBC/CC/ChoiceContainer
onready var _starting_cards_popup = $StartingCardsPopup
onready var _all_starting_cards_display = $StartingCardsPopup/StartingCards
onready var _starting_cards_button = $VBC/ControlButtons/VBC/StartingCards
onready var _start_button = $VBC/ControlButtons/VBC/Start
onready var _choice_buttons := {
	"Ego": $VBC/CC/Choices/Ego/Ego,
	"Disposition": $VBC/CC/Choices/Disposition/Disposition,
	"Instrument": $VBC/CC/Choices/Instrument/Instrument,
	"Injustice": $VBC/CC/Choices/Injustice/Injustice,
}
onready var back_button = $VBC/ControlButtons/VBC/Back

func _ready() -> void:
	for choice_button in _choice_buttons:
		_choice_buttons[choice_button].connect("pressed", self, "on_choice_button_pressed", [choice_button])


func on_choice_button_pressed(button_name : String):
	populate_choices(button_name)
	_choice_popup.rect_size = Vector2(0,0)
	_choice_popup.popup_centered_minsize()
	_archetype_starting_cards_display.rect_min_size.x = _choice_popup.rect_size.x


func populate_choices(_archetype: String) -> void:
	for node in _archetype_choices.get_children():
		node.queue_free()
	var archetype := _archetype.to_upper()
	for type in CardGroupDefinitions[archetype]:
		if CardGroupDefinitions[archetype][type].get("_is_inactive"):
			continue
		var archetype_button = ARCHETYPE_SCENE.instance()
		archetype_button.name = type
		archetype_button.text = type
		_archetype_choices.add_child(archetype_button)
		archetype_button.connect("pressed", self, "_on_archetype_choice_pressed", [type, archetype])
		archetype_button.connect("mouse_entered", self, "_on_archetype_mouse_entered", [type])	


func _on_archetype_choice_pressed(type: String, _archetype: String) -> void:
	var archetype := _archetype.capitalize()
	var archetype_button = _choice_buttons[archetype]
	archetype_button.text = type
	_choice_popup.hide()
	globals.player.deck_groups[archetype] = type
	if globals.player.is_deck_completed():
		_start_button.disabled = false
	_starting_cards_button.disabled = false

func _on_Start_pressed() -> void:
	globals.player.setup()
	get_tree().change_scene(CFConst.PATH_CUSTOM + 'Main.tscn')

func _on_archetype_mouse_entered(type: String) -> void:
	_archetype_starting_cards_display.populate_starting_cards([type], _choice_popup)


func _on_StartingCards_pressed() -> void:
	_starting_cards_popup.rect_size = Vector2(1000,240)
	_starting_cards_popup.popup_centered()
	_all_starting_cards_display.rect_min_size.x = _starting_cards_popup.rect_size.x
	_all_starting_cards_display.populate_starting_cards(globals.player.get_currrent_archetypes(), _starting_cards_popup)
