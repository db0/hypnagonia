class_name CardDraft
extends HBoxContainer

enum AlterantTypes {
	UNCOMMON_CHANCE
	RARE_CHANCE
	DRAFT_AMOUNT
}

const CARD_DRAFT_SCENE = preload("res://src/dreamscape/ChoiceCardObject.tscn")

## Run-modifiable variables
# The following variables can be tweaked through various ways such as artifacts.
# They use the getter to get the final value. They should not be modified manually
# during the run, as they're not reset.
var uncommon_chance : float = 25.0/100 setget ,get_uncommon_chance
var rare_chance : float = 5.0/100 setget ,get_rare_chance
var draft_amount := 3 setget ,get_draft_amount
var draft_card_choices : Array

func _process(_delta: float) -> void:
	# Stupid thing doesn't update automatically after resizing the children inside it
	rect_size = Vector2(0,0)
	pass

func display(card_draft_type := 'card_draft') -> void:
	visible = true
	if not draft_card_choices.empty():
		return
#		for c in get_children():
#			if not c as Tween:
#				c.queue_free()
#		yield(get_tree().create_timer(0.1), "timeout")
	populate_draft_cards(card_draft_type)
	$Tween.interpolate_property(get_parent(),
			'rect_min_size:y', 0, CFConst.CARD_SIZE.y * CFConst.THUMBNAIL_SCALE, 1.0,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func populate_draft_cards(card_draft_type := 'card_draft') -> void:
#	print_debug(card_draft_type)
	match card_draft_type:
		'boss_card_draft':
			retrieve_boss_draft()
		'elite_card_draft':
			retrieve_elite_draft()
		'card_draft':
			retrieve_draft_cards()
	for index in range(draft_card_choices.size()):
		var card_name: String = draft_card_choices[index]
		var draft_card_object = CARD_DRAFT_SCENE.instance()
		add_child(draft_card_object)
		draft_card_object.setup(card_name)
		draft_card_object.index = index
		draft_card_object.connect("card_selected", self, "_on_card_draft_selected", [draft_card_object])
#	yield(get_tree().create_timer(0.15), "timeout")
#	call_deferred('set_size',Vector2(0,0))


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
	globals.player.deck.add_new_card(draft_card_choices[option])


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
				if not card_name in draft_card_choices:
					draft_card_choices.append(card_name)
					# This break ensures we only add one card from the pool
					# of availabkle cards of that rarity
					break
	draft_card_choices += globals.current_encounter.return_extra_draft_cards()

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
				if not card_name in draft_card_choices:
					draft_card_choices.append(card_name)
					break

func retrieve_boss_draft() -> void:
	draft_card_choices.clear()
	for _iter in range(get_draft_amount()):
		var card_names: Array = globals.player.compile_rarity_cards('Rare')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					draft_card_choices.append(card_name)
					break


func get_uncommon_chance() -> float:
	var value := uncommon_chance
	for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
		var multiplier = artifact.get_global_alterant(value, AlterantTypes.UNCOMMON_CHANCE)
		if multiplier:
			value *= multiplier
	return(value)


func get_rare_chance() -> float:
	var value := rare_chance
	for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
		var multiplier = artifact.get_global_alterant(value, AlterantTypes.RARE_CHANCE)
		if multiplier:
			value *= multiplier
	return(value)


func get_draft_amount() -> int:
	var value := draft_amount
	for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
		var addition = artifact.get_global_alterant(value, AlterantTypes.DRAFT_AMOUNT)
		if addition:
			value += addition
	return(value)
