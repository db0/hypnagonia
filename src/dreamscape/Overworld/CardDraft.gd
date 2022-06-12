class_name CardDraft
extends HBoxContainer

signal card_drafted(card_entity)
signal draft_prepared()

const CARD_DRAFT_SCENE = preload("res://src/dreamscape/ChoiceCardObject.tscn")

## Run-modifiable variables
# The following variables can be tweaked through various ways such as artifacts.
# They use the getter to get the final value. They should not be modified manually
# during the run, as they're not reset.
var uncommon_chance : float = 25.0/100 setget ,get_uncommon_chance
var rare_chance : float = 5.0/100 setget ,get_rare_chance
var draft_amount := 3 setget ,get_draft_amount
var upgraded_chance : float = 20.0/100 setget ,get_upgraded_chance
var draft_card_choices : Array
# This will store the final card chosen by the player to draft.
var selected_draft: CardEntry
var card_draft_type: String
var special_draft_payload

func _process(_delta: float) -> void:
	# Stupid thing doesn't update automatically after resizing the children inside it
	rect_size = Vector2(0,0)
	pass

func display(_card_draft_type := 'card_draft') -> void:
	visible = true
	if not draft_card_choices.empty():
		return
#		for c in get_children():
#			if not c as Tween:
#				c.queue_free()
#		yield(get_tree().create_timer(0.1), "timeout")
	card_draft_type = _card_draft_type
	populate_draft_cards()
	$Tween.interpolate_property(get_parent(),
			'rect_min_size:y', 0, CFConst.CARD_SIZE.y * CFConst.THUMBNAIL_SCALE, 1.0,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func populate_draft_cards() -> void:
#	print_debug(card_draft_type)
	match card_draft_type:
		'boss_card_draft':
			retrieve_boss_draft()
		'elite_card_draft':
			retrieve_elite_draft()
		'card_draft':
			retrieve_draft_cards()
		'empty_draft':
			retrieve_nce_cards()
		_:
			retrieve_custom_draft()
	for index in range(draft_card_choices.size()):
		var card_name: String = draft_card_choices[index]
		var draft_card_object = CARD_DRAFT_SCENE.instance()
		add_child(draft_card_object)
		draft_card_object.set_owner(self)
		draft_card_object.setup(card_name)
		draft_card_object.index = index
		draft_card_object.connect("card_selected", self, "_on_card_draft_selected", [draft_card_object])
	globals.journal.card_draft_started(self)
	emit_signal("draft_prepared")

#	yield(get_tree().create_timer(0.15), "timeout")
#	call_deferred('set_size',Vector2(0,0))


func reroll_card_draft() -> void:
	for child in get_children():
		if not child as Tween:
			child.queue_free()
	populate_draft_cards()


func _on_card_draft_selected(option: int, draft_card_object) -> void:
	for child in get_children():
		if child != draft_card_object:
			$Tween.interpolate_property(child,
					'modulate:a', 1, 0, 0.7,
					Tween.TRANS_SINE, Tween.EASE_IN)
		else:
			child.disconnect("card_selected", self, "_on_card_draft_selected")
			child.display_card.card_front.apply_shader("res://shaders/grayscale.shader")
	$Tween.start()
	yield($Tween, "tween_all_completed")
	for child in get_children():
		if child != draft_card_object:
			child.queue_free()
	selected_draft = globals.player.deck.add_new_card(draft_card_choices[option])
	emit_signal("card_drafted", selected_draft)
	EventBus.emit_signal("card_drafted", selected_draft)


func retrieve_draft_cards() -> void:
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= get_rare_chance():
#			print_debug('Rare: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Rare')
		elif chance <= get_rare_chance() + get_uncommon_chance():
#			print_debug('Uncommon: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Uncommon')
		else:
#			print_debug('common: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Common')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if _card_draft_choice_exists(card_name):
					continue
				_add_draft_choice(card_name)
				break
	# Normally this should always exist, but might not, in GUT
	if globals.current_encounter:
		draft_card_choices += globals.current_encounter.return_extra_draft_cards()

func _card_draft_choice_exists(card_name: String) -> bool:
	var all_draft_choice_variants := []
	for dcard in draft_card_choices:
		all_draft_choice_variants += HUtils.get_all_card_variants(dcard)
	for card_variant in HUtils.get_all_card_variants(card_name):
		if all_draft_choice_variants.has(card_variant):
			return(true)
	return(false)

func _get_random_upgrade(card_name: String) -> String:
	var upgrade_options : Array = cfc.card_definitions[card_name].get("_upgrades", []).duplicate(true)
	if upgrade_options.size() > 2:
		CFUtils.shuffle_array(upgrade_options)
	return(upgrade_options.front())

func retrieve_elite_draft() -> void:
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= (get_rare_chance() * 2):
#			print_debug('Rare: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Rare')
		elif chance <= (get_rare_chance() * 2) + (get_uncommon_chance() * 1.75):
#			print_debug('Uncommon: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Uncommon')
		else:
#			print_debug('common: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Common')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not _card_draft_choice_exists(card_name):
					_add_draft_choice(card_name)
					break

func retrieve_boss_draft() -> void:
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array = globals.player.compile_rarity_cards('Rare')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					_add_draft_choice(card_name)
					break

# This draft doesn't add any cards from the cardpool, but just cards from the encounter.
# Useful for giving the player the choice of getting a special card
func retrieve_nce_cards() -> void:
	draft_card_choices.clear()
	# Normally this should always exist, but might not, in GUT
	if globals.current_encounter:
		draft_card_choices += globals.current_encounter.return_extra_draft_cards()

func retrieve_custom_draft() -> void:
	match card_draft_type:
		"artifact_boss_draft":
			_initiate_artifact_boss_draft()
		"nce_subconscious_processing":
			_initiate_nce_subconscious_processing_draft()
		"nce_underwater_cave":
			_initiate_nce_underwater_cave_draft()
		"artifact_birdhouse_draft":
			_initiate_artifact_birdhouse_draft()


func get_uncommon_chance() -> float:
	var value := uncommon_chance
	for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
		var multiplier = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_UNCOMMON_CHANCE)
		if multiplier:
			value *= multiplier
	return(value)

func get_draft_card_count() -> int:
	var count := 0
	for child in get_children():
		if not child as Tween:
			count += 1
	return(count)

func get_rare_chance() -> float:
	var value := rare_chance
	for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
		var multiplier = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_RARE_CHANCE)
		if multiplier:
			value *= multiplier
	return(value)


func get_upgraded_chance() -> float:
	var value := upgraded_chance
	if globals.difficulty.lower_upgraded_draft_chance:
		value *= 0.5
	for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
		var multiplier = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_UPGRADE_CHANCE)
		if multiplier:
			value *= multiplier
	return(value)


func get_draft_amount() -> int:
	var value := draft_amount
	for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
		var addition = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_DRAFT_AMOUNT)
		if addition:
			value += addition
	return(value)


func _initiate_artifact_boss_draft() -> void:
	var aspect = special_draft_payload
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= get_rare_chance():
#			print_debug('Rare: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Rare', aspect)
		elif chance <= get_rare_chance() + get_uncommon_chance():
#			print_debug('Uncommon: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Uncommon', aspect)
		else:
#			print_debug('common: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Common', aspect)
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					_add_draft_choice(card_name)
					# This break ensures we only add one card from the pool
					# of available cards of that rarity
					break

func _initiate_nce_subconscious_processing_draft() -> void:
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array = globals.player.compile_card_type('Understanding')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					_add_draft_choice(card_name)
					# This break ensures we only add one card from the pool
					# of available understandings for this run
					break

func _initiate_nce_underwater_cave_draft() -> void:
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= (get_rare_chance() * 3):
#			print_debug('Rare: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Rare')
		elif chance <= (get_rare_chance() * 3) + (get_uncommon_chance() * 2):
#			print_debug('Uncommon: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Uncommon')
		else:
#			print_debug('common: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Common')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					_add_draft_choice(card_name)
					break


func _initiate_artifact_birdhouse_draft() -> void:
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= get_rare_chance():
#			print_debug('Rare: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Rare')
		elif chance <= get_rare_chance() + get_uncommon_chance():
#			print_debug('Uncommon: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Uncommon')
		else:
#			print_debug('common: ' + str(chance))
			card_names = globals.player.compile_rarity_cards('Common')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					_add_draft_choice(card_name)
					# This break ensures we only add one card from the pool
					# of available cards of that rarity
					break


func _add_draft_choice(card_name) -> void:
	var upgraded_roll = CFUtils.randf_range(0.0, 1.0)
	var upgraded_name = null
	if globals.encounters.current_act.get_act_number() == 2 and upgraded_roll <= get_upgraded_chance():
		upgraded_name =  _get_random_upgrade(card_name)
	if globals.encounters.current_act.get_act_number() == 3 and upgraded_roll <= get_upgraded_chance() * 2:
		upgraded_name =  _get_random_upgrade(card_name)
	if upgraded_name:
		draft_card_choices.append(upgraded_name)
	else:
		draft_card_choices.append(card_name)
