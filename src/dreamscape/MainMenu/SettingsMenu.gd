extends CenterContainer

onready var back_button = $PC/VBC/HBoxContainer/Back
onready var animate_in_hand = $PC/VBC/AnimateHand
onready var focus_style = $PC/VBC/FocusStyle
onready var fancy_movement = $PC/VBC/FancyAnimations
onready var interrupt_music = $PC/VBC/InterruptMusic
onready var recover_prebuilts = $PC/VBC/PreBuilts
onready var main_vol_slider = $PC/VBC/MainVolSlider
onready var music_vol_slider = $PC/VBC/MusicVolSlider

var sound_effect_enabled = false

func _ready() -> void:
#	cfc.game_settings['animate_in_hand'] = cfc.game_settings.get('animate_in_hand', false)
	cfc.game_settings['focus_style'] = cfc.game_settings.get('focus_style', 2)
	cfc.game_settings['fancy_movement'] = cfc.game_settings.get('fancy_movement', CFConst.FANCY_MOVEMENT)
	cfc.game_settings['enable_visible_shuffle'] = cfc.game_settings.get('enable_visible_shuffle', CFConst.FANCY_MOVEMENT)
	cfc.game_settings['main_volume'] = cfc.game_settings.get('main_volume', 0)
	cfc.game_settings['music_volume'] = cfc.game_settings.get('music_volume', 0)
	cfc.game_settings['sounds_volume'] = cfc.game_settings.get('sounds_volume', 0)
	cfc.game_settings['interrupt_music'] = cfc.game_settings.get('interrupt_music', true)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), cfc.game_settings.main_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"), cfc.game_settings.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("se"), cfc.game_settings.sounds_volume)
#	animate_in_hand.pressed = cfc.game_settings.animate_in_hand
	focus_style.selected = focus_style.get_item_index(cfc.game_settings.focus_style)
	fancy_movement.pressed = cfc.game_settings.fancy_movement
	interrupt_music.pressed = cfc.game_settings.interrupt_music
	main_vol_slider.value = cfc.game_settings.main_volume
	music_vol_slider.value = cfc.game_settings.music_volume
	# To avoid the slider adjust sound sounding from the initial setting
	sound_effect_enabled = true


func _on_FancAnimations_toggled(button_pressed: bool) -> void:
	cfc.set_setting('fancy_movement',button_pressed)
	cfc.set_setting('enable_visible_shuffle',button_pressed)
	if button_pressed:
		get_tree().call_group("piles", "enable_shuffle")
	else:
		get_tree().call_group("piles", "disable_shuffle")
	if sound_effect_enabled:
		SoundManager.play_se('setting_toggle')


func _on_FocusStyle_item_selected(index: int) -> void:
	cfc.set_setting('focus_style', focus_style.get_item_id(index))
	if sound_effect_enabled:
		SoundManager.play_se('setting_toggle')


func _on_ExitToMain_pressed() -> void:
	globals.quit_to_main()
	if sound_effect_enabled:
		SoundManager.play_se('back')


func _on_MusicVolSlider_value_changed(value: float) -> void:
	cfc.set_setting('music_volume', value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"), value)
	if sound_effect_enabled:
		SoundManager.play_se('volume_adjust')


func _on_MainVolSlider_value_changed(value: float) -> void:
	cfc.set_setting('main_volume', value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	if sound_effect_enabled:
		SoundManager.play_se('volume_adjust')


func _on_SoundVolSlider_value_changed(value: float) -> void:
	cfc.set_setting('sounds_volume', value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("se"), value)
	if sound_effect_enabled:
		SoundManager.play_se('volume_adjust')


func _on_InterruptMusic_toggled(button_pressed: bool) -> void:
	cfc.set_setting('interrupt_music',button_pressed)
	if sound_effect_enabled:
		SoundManager.play_se('setting_toggle')
