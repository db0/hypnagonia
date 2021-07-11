extends HBoxContainer

const CARD_DRAFT_SCENE = preload("res://src/dreamscape/DraftCardObject.tscn")

var uncommon_chance : float = 25.0/100
var rare_chance : float = 5.0/100
var draft_amount := 3
var draft_card_choices : Array

func _process(_delta: float) -> void:
	# Stupid thing doesn't update automatically after resizing the children inside it
	rect_size = Vector2(0,0)
	pass

func display() -> void:
	visible = true
	if not draft_card_choices.empty():
		return
#		for c in get_children():
#			if not c as Tween:
#				c.queue_free()
#		yield(get_tree().create_timer(0.1), "timeout")
	populate_draft_cards()
	$Tween.interpolate_property(get_parent(),
			'rect_min_size:y', 0, CFConst.CARD_SIZE.y * CFConst.THUMBNAIL_SCALE, 1.0,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func populate_draft_cards() -> void:
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
			child.display_card.card_front.apply_sharer()
	$Tween.start()
	yield($Tween, "tween_all_completed")			
	for child in get_children():
		if child != draft_card_object:
			child.queue_free()
	globals.player.deck.add_new_card(draft_card_choices[option])


func retrieve_draft_cards() -> void:
	draft_card_choices.clear()
	for _iter in range(draft_amount):
		var card_names: Array
		var chance := CFUtils.randf_range(0.0, 1.0)
#		print_debug(str(rare_chance) + ' : ' + str(rare_chance + uncommon_chance))
		if chance <= rare_chance:
#			print_debug('Rare: ' + str(chance))
			card_names = compile_rarity_cards('Rares')
		elif chance <= rare_chance + uncommon_chance:
#			print_debug('Uncommon: ' + str(chance))
			card_names = compile_rarity_cards('Uncommons')
		else:
#			print_debug('common: ' + str(chance))
			card_names = compile_rarity_cards('Commons')
		CFUtils.shuffle_array(card_names)
		if card_names.size():
			for card_name in card_names:
				if not card_name in draft_card_choices:
					draft_card_choices.append(card_name)
					break
	draft_card_choices += globals.current_encounter.return_extra_draft_cards()


func compile_rarity_cards(rarity: String) -> Array:
	var rarity_cards := []
	for key in globals.player.deck.deck_groups:
		rarity_cards += CardGroupDefinitions[key.to_upper()][globals.player.deck.deck_groups[key]][rarity]
	return(rarity_cards)
