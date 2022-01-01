extends Panel

const README := "Thank you for trying out Hypnagonia!\n\n"\
		+ "This game is a Free Software 'Spire-like' deckbuilder. "\
		+ "This means it's free to download, use, modify and redistribute\n\n"\
		+ "This game is a heavy work in progress. At this point many bugs are expected "\
		+ "and most of the expected features are missing.\n"\
		+ "However whatever is there is fully playable.\n\n"\
		+ "Tutorials, Campaign and lots more card groups will be coming out soon."

const SUBTITLES := [
	"A deckbuilding therapy session",
	"Therapy through nightmares",
	"That sinking stone in your heart",
	"The weight of the mind",
	"A rhapsody of reverie and retrospection",
]

# The time it takes to switch from one menu tab to another
const menu_switch_time = 0.35

onready var v_buttons := $MainMenu/VBox/Center/VButtons
onready var main_menu := $MainMenu
#onready var settings_menu := $SettingsMenu
onready var card_library := $CardLibrary
onready var settings := $Settings
onready var new_game := $NewGame
onready var _readme_label := $ReadMe/Label
onready var _readme_popup := $ReadMe
onready var menu_tween := $MenuTween
onready var _subtitle := $MainMenu/VBox/Margin/VBoxContainer/Subtitle
onready var _version := $MainMenu/VBox/Version

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hypnagonia Version: " + CFConst.GAME_VERSION)
	for option_button in v_buttons.get_children():
		if option_button.has_signal('pressed'):
			option_button.connect('pressed', self, 'on_button_pressed', [option_button.name])
	new_game.rect_position.x = get_viewport().size.x
	card_library.rect_position.x = -get_viewport().size.x
	settings.rect_position.x = -get_viewport().size.x
	new_game.back_button.connect("pressed", self, "switch_to_main_menu", [new_game])
#	new_game.recover_prebuilts.connect("pressed", self, "_on_PreBuilts_pressed")
	card_library.back_button.connect("pressed", self, "switch_to_main_menu", [card_library])
	settings.get_node("SettingsMenu").back_button.connect("pressed", self, "switch_to_main_menu", [settings])
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, '_on_Menu_resized')
	_readme_label.text = README
	randomize()
	cfc.game_rng_seed = CFUtils.generate_random_seed()
	SUBTITLES.shuffle()
	_subtitle.text = SUBTITLES[0]
	_version.text = CFConst.GAME_VERSION
	globals.music.switch_scene_music('main')


func on_button_pressed(_button_name : String) -> void:
	match _button_name:
		"NewGame":
			SoundManager.play_se('click')
			switch_to_tab(new_game)
#			get_tree().change_scene(CFConst.PATH_CUSTOM + 'Main.tscn')
		"QuickStart":
			SoundManager.play_se(Sounds.get_randomize_sound())
			new_game.randomize_aspect_choices()
			new_game.start_new_game()
		"Readme":
			SoundManager.play_se('click')
			_readme_popup.rect_size = _readme_label.rect_size
			_readme_popup.popup_centered_minsize()
		"CardLibrary":
			SoundManager.play_se(Sounds.get_shove_sound())
			switch_to_tab(card_library)
		"Settings":
			SoundManager.play_se(Sounds.get_shove_sound())
			switch_to_tab(settings)
		"Exit":
			SoundManager.play_se('click')
			get_tree().quit()


func switch_to_tab(tab: Control) -> void:
	var main_position_x : float
	match tab:
		new_game:
			main_position_x = -get_viewport().size.x
		card_library, settings:
			main_position_x = get_viewport().size.x
	menu_tween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, main_position_x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.interpolate_property(tab,'rect_position:x',
			tab.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.start()


func switch_to_main_menu(tab: Control) -> void:
	SoundManager.play_se(Sounds.get_shove_sound())
	var tab_position_x : float
	match tab:
		new_game:
			tab_position_x = get_viewport().size.x
		card_library, settings:
			tab_position_x = -get_viewport().size.x
	menu_tween.interpolate_property(tab,'rect_position:x',
			tab.rect_position.x, tab_position_x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.start()


func _on_DeckBuilder_Back_pressed() -> void:
	switch_to_main_menu(card_library)


func _on_Menu_resized() -> void:
	for tab in [main_menu, card_library, new_game, settings]:
		if is_instance_valid(tab):
			tab.rect_size = get_viewport().size
			if tab.rect_position.x < 0.0:
					tab.rect_position.x = -get_viewport().size.x
			elif tab.rect_position.x > 0.0:
					tab.rect_position.x = get_viewport().size.x


func _input(event):
	if event.is_action_pressed("init_debug_game"):
		match OS.get_name():
			"Windows":
				print('Card Library Saved in %APPDATA%\\Godot\\app_userdata\\Hypnagonia\\library.json')
			"X11":
				print('Card Library Saved in ${HOME}/.local/share/godot/app_userdata/Hypnagonia/library.json')
		var ordered_list := []
		for libcard in cfc.card_definitions:
			var card_export := _process_card_export(libcard)
			if card_export.get("_is_upgrade", false):
				continue
			ordered_list.append(card_export)
			if card_export.has("_upgrades"):
				for upgrade_name in card_export["_upgrades"]:
					ordered_list.append(_process_card_export(upgrade_name))
		var library_export = File.new()
		library_export.open("user://library.json",File.WRITE)
		library_export.store_line(to_json(ordered_list))

func _process_card_export(card_name: String) -> Dictionary:
	var card_entry = cfc.card_definitions[card_name].duplicate(true)
	card_entry['Name'] = card_name
	card_entry['Abilities'] = card_entry['Abilities'].format(card_entry.get('_amounts', {}))
	card_entry.erase("_amounts")
	card_entry.erase("_effects_info")
	card_entry.erase("_illustration")
	card_entry.erase("_keywords")
	card_entry['archetypes'] = []
	for aspect in [
			Aspects.EGO,
			Aspects.DISPOSITION,
			Aspects.INSTRUMENT,
			Aspects.INJUSTICE]:
		for archetype in aspect:
			for rarity in ['Basic','Common','Uncommon','Rare']:
				for card in aspect[archetype].get(rarity,[]):
					if card_name == card:
						if not archetype in card_entry['archetypes']:
							card_entry['archetypes'].append(archetype)
	return(card_entry)

