extends Panel

const README := "Thank you for trying out Dreams!\n\n"\
		+ "This game is a Free Software 'Spire-like' deckbuilder. "\
		+ "This means it's free to download, use, modify and redistribute\n\n"\
		+ "This game is a heavy work in progress. At the poing bugs are expected "\
		+ "and most of the expected features are missing.\n"\
		+ "However whatever is there is fully playable.\n\n"\
		+ "Tutorials, Campaign and lots more card groups will be coming out soon."

# The time it takes to switch from one menu tab to another
const menu_switch_time = 0.35

onready var v_buttons := $MainMenu/VBox/Center/VButtons
onready var main_menu := $MainMenu
#onready var settings_menu := $SettingsMenu
onready var deck_builder := $DeckBuilder
onready var new_game := $NewGame
onready var _readme_label := $ReadMe/Label
onready var _readme_popup := $ReadMe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for option_button in v_buttons.get_children():
		if option_button.has_signal('pressed'):
			option_button.connect('pressed', self, 'on_button_pressed', [option_button.name])
	new_game.rect_position.x = get_viewport().size.x
	deck_builder.rect_position.x = -get_viewport().size.x
	new_game.back_button.connect("pressed", self, "switch_to_main_menu", [new_game])
#	new_game.recover_prebuilts.connect("pressed", self, "_on_PreBuilts_pressed")
	deck_builder.back_button.connect("pressed", self, "switch_to_main_menu", [deck_builder])
	get_viewport().connect("size_changed", self, '_on_Menu_resized')
	_readme_label.text = README


func on_button_pressed(_button_name : String) -> void:
	match _button_name:
		"NewGame":
			switch_to_tab(new_game)
#			get_tree().change_scene(CFConst.PATH_CUSTOM + 'Main.tscn')
		"QuickStart":
			new_game.randomize_archetype_choices()
			new_game.start_new_game()
		"Readme":
			_readme_popup.rect_size = _readme_label.rect_size
			_readme_popup.popup_centered_minsize()
		"Deckbuilder":
			switch_to_tab(deck_builder)
		"Exit":
			get_tree().quit()


func switch_to_tab(tab: Control) -> void:
	var main_position_x : float
	match tab:
		new_game:
			main_position_x = -get_viewport().size.x
		deck_builder:
			main_position_x = get_viewport().size.x
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, main_position_x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(tab,'rect_position:x',
			tab.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()


func switch_to_main_menu(tab: Control) -> void:
	var tab_position_x : float
	match tab:
		new_game:
			tab_position_x = get_viewport().size.x
		deck_builder:
			tab_position_x = -get_viewport().size.x
	$MenuTween.interpolate_property(tab,'rect_position:x',
			tab.rect_position.x, tab_position_x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$MenuTween.start()


func _on_DeckBuilder_Back_pressed() -> void:
	switch_to_main_menu(deck_builder)


func _on_Menu_resized() -> void:
	for tab in [main_menu, deck_builder]:
		if is_instance_valid(tab):
			tab.rect_size = get_viewport().size
			if tab.rect_position.x < 0.0:
					tab.rect_position.x = -get_viewport().size.x
			elif tab.rect_position.x > 0.0:
					tab.rect_position.x = get_viewport().size.x
