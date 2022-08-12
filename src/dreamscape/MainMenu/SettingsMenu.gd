extends CenterContainer

onready var back_button = find_node('Back')
onready var focus_style = find_node('FocusStyle')
onready var expand_linked_terms = find_node('ExpandLinkedTerms')
onready var fast_icon_speed = find_node('FastIconSpeed')
onready var async_icon_animations = find_node('AsyncIconAnimations')
onready var fancy_movement = find_node('FancyAnimations')
onready var animated_text_backgrounds = find_node('AnimatedTextBackgrounds')
onready var enable_glow = find_node('EnableGlow')
onready var interrupt_music = find_node('InterruptMusic')
onready var main_vol_slider = find_node('MainVolSlider')
onready var music_vol_slider = find_node('MusicVolSlider')
onready var use_ai = $"%UseAI"
onready var judge_ai = $"%JudgeAI"
onready var generate_ai = $"%GenerateAI"
onready var urlvbc = $"%URLVBC"
onready var kaiurl_input = $"%KAIURLInput"
onready var kai_port_input = $"%KAIPortInput"
onready var ai_label = $"%AILabel"
onready var ai_genre = $"%AIGenre"

var sound_effect_enabled = false

func _ready() -> void:
#	cfc.game_settings['animate_in_hand'] = cfc.game_settings.get('animate_in_hand', false)
	cfc.game_settings['focus_style'] = cfc.game_settings.get('focus_style', 2)
	cfc.game_settings['fancy_movement'] = cfc.game_settings.get('fancy_movement', CFConst.FANCY_MOVEMENT)
	cfc.game_settings['anim_text_backgrounds'] = cfc.game_settings.get('anim_text_backgrounds', CFConst.FANCY_MOVEMENT)
	cfc.game_settings['glow_enabled'] = cfc.game_settings.get('glow_enabled', true)
	cfc.game_settings['enable_visible_shuffle'] = cfc.game_settings.get('enable_visible_shuffle', CFConst.FANCY_MOVEMENT)
	cfc.game_settings['main_volume'] = cfc.game_settings.get('main_volume', 0)
	cfc.game_settings['music_volume'] = cfc.game_settings.get('music_volume', 0)
	cfc.game_settings['sounds_volume'] = cfc.game_settings.get('sounds_volume', 0)
	cfc.game_settings['interrupt_music'] = cfc.game_settings.get('interrupt_music', true)
	cfc.game_settings['expand_linked_terms'] = cfc.game_settings.get('expand_linked_terms', true)
	cfc.game_settings['fast_icon_speed'] = cfc.game_settings.get('fast_icon_speed', false)
	cfc.game_settings['async_icon_animations'] = cfc.game_settings.get('async_icon_animations', false)
	# We disable the AI stuff on HTML as it requires connecting to other sites
	# and that runs into XSS protections and shit which I don't want to deal with
	cfc.game_settings['use_ai'] = cfc.game_settings.get('use_ai', OS.get_name() != "HTML5")
	cfc.game_settings['judge_ai'] = cfc.game_settings.get('judge_ai', true)
	cfc.game_settings['generate_ai'] = cfc.game_settings.get('generate_ai', false)
	cfc.game_settings['kai_url'] = cfc.game_settings.get('kai_url', "http://127.0.0.1")
	cfc.game_settings['kai_port'] = cfc.game_settings.get('kai_port', 5000)
	cfc.game_settings['ai_genre'] = cfc.game_settings.get('ai_genre', HConst.AIGenres.RANDOM)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), cfc.game_settings.main_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"), cfc.game_settings.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("se"), cfc.game_settings.sounds_volume)
#	animate_in_hand.pressed = cfc.game_settings.animate_in_hand
	focus_style.selected = focus_style.get_item_index(cfc.game_settings.focus_style)
	fancy_movement.pressed = cfc.game_settings.fancy_movement
	expand_linked_terms.pressed = cfc.game_settings.expand_linked_terms
	fast_icon_speed.pressed = cfc.game_settings.fast_icon_speed
	async_icon_animations.pressed = cfc.game_settings.async_icon_animations
	animated_text_backgrounds.pressed = cfc.game_settings.anim_text_backgrounds
	enable_glow.pressed = cfc.game_settings.glow_enabled
	interrupt_music.pressed = cfc.game_settings.interrupt_music
	main_vol_slider.value = cfc.game_settings.main_volume
	music_vol_slider.value = cfc.game_settings.music_volume
	use_ai.pressed = cfc.game_settings.use_ai
	if OS.get_name() == "HTML5":
		use_ai.disabled = true
		ai_label.text = ai_label.text + "\n(AI unsupported in HTML5)"
	judge_ai.pressed = cfc.game_settings.judge_ai
	judge_ai.disabled = !use_ai.pressed
	generate_ai.pressed = cfc.game_settings.generate_ai
	generate_ai.disabled = !use_ai.pressed
	urlvbc.visible = generate_ai.pressed
	kaiurl_input.text = cfc.game_settings.kai_url
	kai_port_input.text = str(cfc.game_settings.kai_port)
	for genre_desc in HConst.AIGenres:
		if HConst.AIGenres[genre_desc] == HConst.AIGenres.DISLIKE:
			continue
		ai_genre.add_item(genre_desc.capitalize(), HConst.AIGenres[genre_desc])
	ai_genre.selected = ai_genre.get_item_index(cfc.game_settings.ai_genre)
	print_debug([HConst.AIGenres.RANDOM,cfc.game_settings.ai_genre,ai_genre.get_item_index(cfc.game_settings.ai_genre),ai_genre.get_item_id(0)])
	# To avoid the slider adjust sound sounding from the initial setting
	sound_effect_enabled = true


func _on_FancAnimations_toggled(button_pressed: bool) -> void:
	cfc.set_setting('fancy_movement',button_pressed)
	cfc.set_setting('enable_visible_shuffle',button_pressed)
	if button_pressed:
		get_tree().call_group("piles", "enable_shuffle")
	else:
		get_tree().call_group("piles", "disable_shuffle")
	_play_toggle_sound(button_pressed)


func _on_FocusStyle_item_selected(index: int) -> void:
	cfc.set_setting('focus_style', focus_style.get_item_id(index))
	if sound_effect_enabled:
		SoundManager.play_se('selection_done')


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
	_play_toggle_sound(button_pressed)

func _play_toggle_sound(button_pressed: bool) -> void:
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_AnimatedTextBackgrounds_toggled(button_pressed: bool) -> void:
	cfc.set_setting('anim_text_backgrounds',button_pressed)
	get_tree().call_group("card_fronts", "toggle_text_shader_visible", button_pressed)
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_EnableGlow_toggled(button_pressed: bool) -> void:
	cfc.set_setting('glow_enabled',button_pressed)
	if cfc.NMAP.has('main'):
		cfc.NMAP.main.toggle_glow(button_pressed)
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_ExpandLinkedTerms_toggled(button_pressed: bool):
	cfc.set_setting('expand_linked_terms',button_pressed)
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_FastIconSpeed_toggled(button_pressed: bool):
	cfc.set_setting('fast_icon_speed',button_pressed)
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_AsyncIcons_toggled(button_pressed: bool):
	cfc.set_setting('async_icon_animations',button_pressed)
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_JudgeAI_toggled(button_pressed):
	cfc.set_setting('judge_ai',button_pressed)
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_GenerateAI_toggled(button_pressed):
	cfc.set_setting('generate_ai',button_pressed)
	urlvbc.visible = generate_ai.pressed
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_KAIURLInput_text_changed():
	kaiurl_input.text = kaiurl_input.text.rstrip('\n')
	cfc.set_setting('kai_url',kaiurl_input.text)


func _on_KAIPortInput_text_changed():
	kai_port_input.text = kai_port_input.text.rstrip('\n')
	cfc.set_setting('kai_port',int(kai_port_input.text))


func _on_UseAI_toggled(button_pressed):
	cfc.set_setting('use_ai',button_pressed)
	generate_ai.disabled = !button_pressed
	judge_ai.disabled = !button_pressed
	if sound_effect_enabled:
		if button_pressed:
			SoundManager.play_se('setting_toggle_on')
		else:
			SoundManager.play_se('setting_toggle_off')


func _on_AIGenre_item_selected(index):
	cfc.set_setting('ai_genre', ai_genre.get_item_id(index))
	if sound_effect_enabled:
		SoundManager.play_se('selection_done')
