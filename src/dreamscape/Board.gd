extends Board

signal battle_begun
signal battle_ended

const ENEMY_ENTITY_SCENE = preload("res://src/dreamscape/CombatElements/Enemies/EnemyEntity.tscn")

var end_turn : Button
var turn := Turn.new()
var dreamer: PlayerEntity
var activated_enemies: Array
var boss_battle := false
var bgm_tracks : Array
# This tracks if the ordeal is over. We use it to avoid crashing when the dreamer kills themselves
# at the same time as ending the last Torment
var battle_ended: bool

var enemies_at_start_of_turn

var _debug_enemies_at_end_of_turn
var _debug_enemies_started_activation := []
var _debug_enemy_states := {}

onready var bottom_gui := $VBC/HBC
onready var _player_area := $VBC/CombatArena/PlayerArea
onready var _enemy_area := $VBC/CombatArena/EnemyArea/Enemies
onready var _combat_arena := $VBC/CombatArena
onready var _background := $Background
onready var _bg_tint := $BackgroundTint
onready var _board_cover := $FadeToBlack
onready var _tween := $Tween
onready var player_info := $VBC/PlayerInfo
onready var _debug_timer := $EnemyTurnStuckTimer
onready var _debug_warning := $VBC/DebugWarning

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	print_debug("Board Enter Ready:" + str(OS.get_ticks_msec() - load_start_time) + 'ms')
	if OS.has_feature("debug"):
		print("DEBUG INFO:Board: Entering Ordeal")
	player_info.owner_node = self
	_board_cover.visible = true
	counters = $VBC/HBC/Counters
	end_turn = $VBC/HBC/EndTurn
	cfc.map_node(self)
#	print_debug("Board All Nodes Mapped:" + str(OS.get_ticks_msec() - load_start_time) + 'ms')
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed",self,"_on_viewport_resized")
	# We use the below while to wait until all the nodes we need have been mapped
	# "hand" should be one of them.
	# We're assigning our positions programmatically,
	# instead of defining them on the scene.
	# This way any they will work with any size of viewport in a game.
	# Discard pile goes bottom right
	if not get_tree().get_root().has_node('Gut'):
		load_deck()
	turn.setup()
	dreamer = preload("res://src/dreamscape/CombatElements/PlayerEntity.tscn").instance()
	var dreamer_properties := {
		"Health": globals.player.health,
		"Damage": globals.player.damage,
		"Type": Terms.PLAYER,
		"_texture_size_x": globals.PLAYER_COMBAT_ENTITY_SIZE.x,
		"_texture_size_y": globals.PLAYER_COMBAT_ENTITY_SIZE.y,
	}
	dreamer.setup(Terms.PLAYER, dreamer_properties)
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_killed", self, "_dreamer_died")
	_player_area.add_child(dreamer)
	dreamer.rect_position = Vector2(100,100)
	_on_viewport_resized()
# warning-ignore:return_value_discarded
	cfc.connect("cache_cleared", self, '_recalculate_predictions')
	player_info.connect_dreamer_signals(dreamer)
#	begin_encounter()
#
func _process(_delta: float) -> void:
	if cfc.game_paused and cfc.NMAP.has("main") and cfc.NMAP.main._current_focus_source:
		cfc.NMAP.main.unfocus_all()
	if _debug_warning.visible:
		if _debug_timer.time_left > 0:
			_debug_warning.text = "The enemy turn appears to be stuck. Force unsticking in: " + str(round(_debug_timer.time_left))
		else:
			_debug_warning.text = "Game force-unstuck. Please check the debug console and consider opening a bug report"

func begin_encounter() -> void:
	cfc.game_paused = false
	randomize_background()
	_fade_from_black()
	yield(_tween, "tween_all_completed")
	_prepare_omega()
	cfc.NMAP.hand.refill_hand(5 - _retrieve_alpha())
#	_on_player_turn_started(turn)
#	turn._reset_turn()
	turn.encounter_event_count.clear()
	while not cfc.NMAP.hand.is_hand_refilled:
		yield(cfc.NMAP.hand, "hand_refilled")
	emit_signal("battle_begun")
	turn.start_player_turn()
	if not cfc.game_settings.get('first_ordeal_tutorial_done'):
		player_info._on_Help_pressed()
		cfc.set_setting('first_ordeal_tutorial_done', true)
	if OS.has_feature("debug"):
			print("DEBUG INFO:Board: Ordeal Encounter Loaded")


func _retrieve_alpha() -> int:
	var alpha_count := 0
	for card in cfc.NMAP.deck.get_all_cards():
		if Terms.GENERIC_TAGS.alpha.name in card.get_property("Tags"):
			card.move_to(cfc.NMAP.hand)
			alpha_count += 1
	return(alpha_count)


func _prepare_omega() -> void:
	var omega_count := 0
	for card in cfc.NMAP.deck.get_all_cards():
		if Terms.GENERIC_TAGS.omega.name in card.get_property("Tags"):
			# Index 0 is the "bottom" of the deck.
			cfc.NMAP.deck.move_child(card,0)
			omega_count += 1
	if omega_count > 0:
		cfc.NMAP.deck.reorganize_stack()


func randomize_background() -> void:
	var dark_backgrounds := CFUtils.list_imported_in_directory("res://assets/backgrounds/dark/")
	var bright_backgrounds := CFUtils.list_imported_in_directory("res://assets/backgrounds/bright/")
	var all_backgrounds := bright_backgrounds + dark_backgrounds
	CFUtils.shuffle_array(all_backgrounds)
	var selected_background :String = all_backgrounds[0]
	var bpath: String
	if selected_background in bright_backgrounds:
		bpath = "res://assets/backgrounds/bright/"
		_bg_tint.visible = true
	else:
		bpath = "res://assets/backgrounds/dark/"
	var background_resource: String = bpath + selected_background
	var tex = load(background_resource)
	var new_texture = ImageTexture.new();
	var image = tex.get_data()
	new_texture.create_from_image(image)
	_background.texture = new_texture


func spawn_enemy_encounter(encounter: EnemyEncounter) -> void:
	for enemy_entry in encounter.enemies:
		if OS.has_feature("debug"):
			print("DEBUG INFO:Board: Spawning Normal Enemy: " + enemy_entry['definition'].get("Name"))
		var new_enemy = spawn_enemy(enemy_entry['definition'])
		if enemy_entry.has('starting_intent'):
			# This delay is needed to allow the starting intent to be added
			# so that it can be seen to be queued_free
			yield(get_tree().create_timer(0.1), "timeout")
			new_enemy.intents.prepare_intents(enemy_entry['starting_intent'])
		if enemy_entry.has('starting_effects'):
			for effect in enemy_entry['starting_effects']:
				new_enemy.active_effects.mod_effect(effect["name"],effect["stacks"])
		if enemy_entry.has('rebalancing'):
			new_enemy.intents.rebalancing = enemy_entry['rebalancing']
		if enemy_entry.has('health_modifier'):
				new_enemy.health += enemy_entry['health_modifier']
		if enemy_entry.has('starting_defence'):
				new_enemy.defence += enemy_entry['starting_defence']


func spawn_enemy(enemy_properties) -> EnemyEntity:
	if get_tree().get_nodes_in_group("EnemyEntities").size() >= 5:
		return(null)
	var enemy : EnemyEntity = ENEMY_ENTITY_SCENE.instance()
	enemy.setup(enemy_properties.Name, enemy_properties)
	_enemy_area.add_child(enemy)
	# warning-ignore:return_value_discarded
	enemy.connect("finished_activation", self, "_on_finished_enemy_activation")
	# warning-ignore:return_value_discarded
	enemy.connect("entity_killed", self, "_enemy_died")
	cfc.flush_cache()
	return(enemy)


func spawn_advanced_enemy(encounter: CombatEncounter) -> EnemyEntity:
	if OS.has_feature("debug"):
		print("DEBUG INFO:Board: Spawning Advanced Enemy: " + encounter.enemy_scene.get_path())
	var advanced_entity: EnemyEntity = encounter.enemy_scene.instance()
	advanced_entity.setup_advanced(encounter.difficulty)
	_enemy_area.add_child(advanced_entity)
	# warning-ignore:return_value_discarded
	advanced_entity.connect("finished_activation", self, "_on_finished_enemy_activation")
	# warning-ignore:return_value_discarded
	advanced_entity.connect("entity_killed", self, "_enemy_died")
	return(advanced_entity)

# Reshuffles all Card objects created back into the deck
func _on_ReshuffleAllDeck_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.deck)


func _on_ReshuffleAllDiscard_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.discard)


func reshuffle_all_in_pile(pile = cfc.NMAP.deck):
	for c in get_tree().get_nodes_in_group("cards"):
		if c.get_parent() != pile:
			c.move_to(pile)
			yield(get_tree().create_timer(0.1), "timeout")
	# Last card in, is the top card of the pile
	var last_card : Card = pile.get_top_card()
	if last_card._tween.is_active():
		yield(last_card._tween, "tween_all_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	pile.shuffle_cards()


# Button to make all cards act as attachments
func _on_EnableAttach_toggled(button_pressed: bool) -> void:
	for c in get_tree().get_nodes_in_group("cards"):
		c.is_attachment = button_pressed


func _on_Debug_toggled(button_pressed: bool) -> void:
	cfc._debug = button_pressed


func get_all_scriptables() -> Array:
	return(get_tree().get_nodes_in_group("CombatEntities") + get_all_cards())


# Loads the player's deck
func load_deck() -> void:
	if not globals.player.deck:
		# warning-ignore:return_value_discarded
		NewGameMenu.randomize_aspect_choices()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		globals.player.setup()
		globals.encounters.prepare_next_act()
	for card in globals.player.deck.instance_cards():
		cfc.NMAP.deck.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
		cfc.NMAP.deck.shuffle_cards(false)


func _on_player_turn_started(_turn: Turn) -> void:
	_debug_timer.stop()
	if is_instance_valid(dreamer) and not dreamer.is_dead:
		end_turn.disabled = false


func _on_player_turn_ended(_turn: Turn) -> void:
	_debug_warning.visible = false
	_debug_enemies_at_end_of_turn = get_tree().get_nodes_in_group("EnemyEntities").size()
	_store_debug_enemy_states()
	_debug_timer.start(10)
	end_turn.disabled = true
	yield(get_tree().create_timer(0.3), "timeout")
	while not cfc.NMAP.hand.is_hand_refilled:
		yield(cfc.NMAP.hand, "hand_refilled")
	turn.start_enemy_turn()


func _on_enemy_turn_started(_turn: Turn) -> void:
	# We delay, to allow effects like poison to activate first
	yield(get_tree().create_timer(1), "timeout")
	# I want the enemies to activate serially
	enemies_at_start_of_turn = get_tree().get_nodes_in_group("EnemyEntities")
	_debug_enemies_started_activation.clear()
	for enemy in enemies_at_start_of_turn:
		# It might have died of poison in the meantime
		if is_instance_valid(enemy):
#		print_debug("Activating Intents: " + enemy.canonical_name)
			_debug_enemies_started_activation.append(enemy)
			enemy.activate()
			if enemy.is_activating:
				yield(enemy, "finished_activation")
		else:
			_on_finished_enemy_activation(enemy)


func _on_enemy_turn_ended(_turn: Turn) -> void:
	activated_enemies.clear()


func _on_finished_enemy_activation(enemy: EnemyEntity) -> void:
	if not enemy in activated_enemies:
		activated_enemies.append(enemy)
	if activated_enemies.size() == enemies_at_start_of_turn.size():
		# Small wait to allow dying enemies to deinstance
		yield(get_tree().create_timer(1), "timeout")
		turn.end_enemy_turn()
		turn.start_player_turn()


func _enemy_died(_final_damage) -> void:
	yield(get_tree().create_timer(2), "timeout")
	if get_tree().get_nodes_in_group("EnemyEntities").size()\
			- get_tree().get_nodes_in_group("Minions").size() == 0:
		complete_battle()


func _dreamer_died(final_damage) -> void:
	battle_ended = true
	globals.player.damage = final_damage
	yield(get_tree().create_timer(1), "timeout")
	game_over()


func complete_battle() -> void:
	if not battle_ended:
		battle_ended = true
		globals.player.damage = dreamer.damage
		_fade_to_transparent()
		yield(_tween, "tween_all_completed")
		globals.current_encounter.end()
		emit_signal("battle_ended")
#	cfc.game_paused = true
#	mouse_pointer.forget_focus()
#	end_turn.disabled = true
#	post_battle_menu.display()
#	for card in get_tree().get_nodes_in_group("cards"):
#		card.set_to_idle()


func game_over() -> void:
	_fade_to_transparent()
	yield(_tween, "tween_all_completed")
	globals.current_encounter.game_over()
#	cfc.game_paused = true
#	mouse_pointer.forget_focus()
#	end_turn.disabled = true
#	game_over_notice.rect_global_position = get_viewport().size/2 - game_over_notice.rect_size/2
#	game_over_notice.visible = true
#	for card in get_tree().get_nodes_in_group("cards"):
#		card.set_to_idle()


func _on_viewport_resized() -> void:
	_background.rect_min_size = get_viewport().size
	_background.rect_size = get_viewport().size
	_bg_tint.rect_min_size = get_viewport().size
	_bg_tint.rect_size = get_viewport().size
#	bottom_gui.rect_position = cfc.NMAP.deck.position - Vector2(0,50)


func _on_BackToMain_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(CFConst.PATH_CUSTOM + "MainMenu/MainMenu.tscn")
	globals.reset()
	cfc.NMAP.clear()


func _fade_to_black() -> void:
	_board_cover.visible = true
	_tween.interpolate_property(_board_cover,
			'modulate:a', 0, 1, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()


func _fade_from_black() -> void:
	_tween.interpolate_property(_board_cover,
			'modulate:a', 1, 0, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()
	yield(_tween, "tween_all_completed")
	_board_cover.visible = false


func _fade_to_transparent() -> void:
	_tween.interpolate_property(cfc.NMAP.main,
			'modulate:a', 1, 0, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()


func _recalculate_predictions() -> void:
	# We do not want to recalculate for every card discard and refill
	# rather we'll recalculate once, once the player's turn starts again
	if end_turn.disabled:
		return
	yield(get_tree(), "idle_frame")
	var snapshot_id = CFUtils.randi_range(1,100000)
	get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "combat_effects", "take_snapshot", snapshot_id)
	# I want the enemies to be predicted serially
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		# It might have died of poison in the meantime
		if is_instance_valid(enemy):
#		print_debug("Activating Intents: " + enemy.canonical_name)
			enemy.intents.predict_intents(snapshot_id)
			yield(enemy.intents, "intents_predicted")


func _input(event):
	if event.is_action_pressed("init_debug_game"):
		Music.prepare_background_music('ordeal')
#		var bgm_tracks = SoundManagerClass.get_sound_files_in_dir("res://assets/music/ordeal/")
#		CFUtils.shuffle_array(bgm_tracks)
#		SoundManager.play_bgm(bgm_tracks[0])
#		SoundManager.fade_in(bgm_tracks[0])
		# warning-ignore:unused_variable
		_debug_advanced_enemy()
		var _torment1
		var _torment2
		var _torment3
#		_torment1 = spawn_enemy(EnemyDefinitions.THE_LIGHT_CALLING)
#		_torment2 = spawn_enemy(EnemyDefinitions.THE_LAUGHING_ONE)
#		_torment3 = spawn_enemy(EnemyDefinitions.THE_LAUGHING_ONE)
#		_torment3 = spawn_enemy(EnemyDefinitions.THE_LIGHT_CALLING)
		if _torment1:
			_torment1.health = 180
			_torment1.damage = 19
			_torment1.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, 2)
			_torment1.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.disempower.name, 2)
#			_torment1.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.effect_resistance.name, 1, false, false, ["Init"], Terms.ACTIVE_EFFECTS.poison.name)
#			_torment1.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, 1)
		if _torment2:
			_torment2.health = 110
			_torment2.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.disempower.name, 2)
#			_torment2.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.marked.name, 1)
#			_torment2.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, 1)
			_torment2.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, 15)
#			_torment2.defence = 10
		if _torment3:
			_torment3.health = 100
			_torment3.damage = 18
#			_torment3.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, 1)
#			_torment3.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.burn.name, 3)
#			_torment3.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, 1)
		dreamer.health = 1000
		dreamer.damage = 100
#		globals.player.add_artifact(ArtifactDefinitions.ThickExplosion.canonical_name)
#		globals.player.add_artifact(ArtifactDefinitions.PurpleWave.canonical_name)
		globals.player.add_artifact(ArtifactDefinitions.RedWave.canonical_name)
		globals.player.add_memory(MemoryDefinitions.SpikeEnemy.canonical_name)
		globals.player.add_memory(MemoryDefinitions.BufferSelf.canonical_name)
		dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, 12)
		dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, 1, false, false, ['Debug'], 'thick')
		for pathos in Terms.RUN_ACCUMULATION_NAMES.values():
			if pathos != Terms.RUN_ACCUMULATION_NAMES.boss:
				globals.player.pathos.modify_released_pathos(pathos, globals.player.pathos.get_threshold(pathos))
		# Hand Cards
		for c in [
			# Need to look into these two later
#			"Fowl Language",
#			"A Thousand Squeaks",
			"Towering Presence",
		]:
			var card = cfc.instance_card(c)
			cfc.NMAP.hand.add_child(card)
			#card.set_is_faceup(false,true)
			card._determine_idle_state()
		cfc.NMAP.deck.shuffle_cards(false)
		# Deck Cards
		begin_encounter()
		player_info._on_Settings_pressed()
		yield(get_tree().create_timer(0.1), "timeout")
		player_info._on_Settings_hide()
	if event.is_action_pressed("debug"):
		_on_Debug_pressed()
	if event.is_action_pressed("complete_battle"):
		complete_battle()
#	if event.is_action_pressed("lose_battle"):
#		game_over()


func _debug_advanced_enemy() -> void:
	pass
#	var advanced_entity: EnemyEntity =\
#			preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn").instance()
	var advanced_entity: EnemyEntity =\
			preload("res://src/dreamscape/CombatElements/Enemies/Elites/Dentist.tscn").instance()
	advanced_entity.setup_advanced("hard")
	_enemy_area.add_child(advanced_entity)
#	advanced_entity.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.self_cleaning.name, 1)
	# warning-ignore:return_value_discarded
	advanced_entity.connect("finished_activation", self, "_on_finished_enemy_activation")


func _on_Debug_pressed() -> void:
	# warning-ignore:return_value_discarded
	dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.buffer.name, 3)
#	dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.vulnerable.name, 2)
#	dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.drain.name, 5)
#	dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.introspection.name, 6)
#	dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.nunclucks.name, 1)
	dreamer.defence += 30
	for c in [
		"Dubious Painkillers",
	]:
		var card = cfc.instance_card(c)
		cfc.NMAP.hand.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
	counters.mod_counter("immersion",3)
#	for _iter in range(3):
#		cfc.NMAP.hand.draw_card(cfc.NMAP.deck)
	# Deck cards
	for c in [
		"Hyperfocus",
		"Hyperfocus",
	]:
		var card = cfc.instance_card(c)
		cfc.NMAP.deck.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
		


func _on_EnemyTurnStuckTimer_timeout() -> void:
	if not _debug_warning.visible:
		_debug_warning.visible = true
		_debug_timer.start(10)
		return
	print("Oops, it seems the enemy turn is stuck! Who coded this thing? Unleashing the trained monkeys after the developers. Please wait...")
	print(":::Activated Torments: ", activated_enemies)
	print(":::Available Torments: ", get_tree().get_nodes_in_group("EnemyEntities").size())
	print(":::Torments available at start of Torment turn: ", _debug_enemies_at_end_of_turn)
	var unfinished_enemies := []
	for e in _debug_enemies_started_activation:
		if not e in activated_enemies:
			unfinished_enemies.append(e)
	print(":::Torments who started activating but never finished: ", unfinished_enemies)
	var undead_enemies = 0
	for t in get_tree().get_nodes_in_group("EnemyEntities"):
		if t.is_dead:
			undead_enemies += 1
	print(":::Torments who think they're dead: ", undead_enemies)
	for t in _debug_enemy_states:
		var effects := ''
		for e in _debug_enemy_states[t]["effects"]:
			effects += "\t\t%s: %s\n" % [e, _debug_enemy_states[t]["effects"][e]]
		print(":::%s state:\n\t:::Interpretation max: %s\n\t:::Interpretation taken: %s\n\t:::Combat Effects:\n%s" % [
			t,
			_debug_enemy_states[t].health,
			_debug_enemy_states[t].damage,
			effects
		])
	var effects := ""
	for e in dreamer.active_effects.get_all_effects_nodes():
		effects += "\t\t%s: %s\n" % [e.canonical_name, e.stacks]
	print(":::Dreamer state:\n\t:::Interpretation Max: %s\n\t:::Interpretation taken: %s\n\t:::Combat Effects:\n %s\n\t:::Curios: %s\n\t:::Memories: %s" % [
		dreamer.health,
		dreamer.damage,
		effects,
		globals.player.get_all_artifact_names(),
		globals.player.get_all_memory_names()
	])
	print("Whipping the developers with the rubber chicken to unstick the game forcefully. Sorry for the inconvenience and please open a bug report!")
	turn.end_enemy_turn()
	turn.start_player_turn()


func _exit_tree():
	if OS.has_feature("debug"):
		print("DEBUG INFO:Board: Exiting Ordeal")

func _store_debug_enemy_states() -> void:
	_debug_enemy_states.clear()
	for t in get_tree().get_nodes_in_group("EnemyEntities"):
		_debug_enemy_states[t] = {}
		var effects := {}
		for e in t.active_effects.get_all_effects_nodes():
			effects[e.canonical_name] = e.stacks
		_debug_enemy_states[t]["health"] = t.health
		_debug_enemy_states[t]["damage"] = t.damage
		_debug_enemy_states[t]["effects"] = effects
