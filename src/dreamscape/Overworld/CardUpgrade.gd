extends HBoxContainer

const CARD_UPGRADE_SCENE = preload("res://src/dreamscape/ChoiceCardObject.tscn")

var upgradable_cards: Array

func _process(_delta: float) -> void:
	# Stupid thing doesn't update automatically after resizing the children inside it
	rect_size = Vector2(0,0)
	pass

func display() -> void:
	visible = true
	populate_upgrade_cards()
	$Tween.interpolate_property(get_parent(),
			'rect_min_size:y', 0, CFConst.CARD_SIZE.y * CFConst.THUMBNAIL_SCALE, 1.0,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func populate_upgrade_cards() -> void:
	upgradable_cards = globals.player.deck.get_upgradeable_cards()
	for index in range(upgradable_cards.size()):
#		var card_name: String = upgradable_cards[index].card_name
		var upgrade_card_object = CARD_UPGRADE_SCENE.instance()
		add_child(upgrade_card_object)
		upgrade_card_object.setup(upgradable_cards[index].instance_self(true))
		upgrade_card_object.index = index
		upgrade_card_object.connect("card_selected", self, "_on_card_upgrade_selected", [upgrade_card_object])
#	yield(get_tree().create_timer(0.15), "timeout")
#	call_deferred('set_size',Vector2(0,0))
	globals.journal.card_upgrade_started(self)

func _on_card_upgrade_selected(option: int, draft_card_object) -> void:
	var upgrade_options : Array = upgradable_cards[option].upgrade_options
	var select_return
	if ArtifactDefinitions.RandomUpgrades.name in globals.player.get_all_artifact_names():
		CFUtils.shuffle_array(upgrade_options)
		select_return = upgrade_options
	else:
		select_return = cfc.ov_utils.select_card(
				upgrade_options, 1, "equal", true, globals.journal)
		if select_return is GDScriptFunctionState: # Still working.
			select_return = yield(select_return, "completed")
	if typeof(select_return) == TYPE_ARRAY:
		draft_card_object.disconnect("card_selected", self, "_on_card_upgrade_selected")
		draft_card_object.display_card.card_front.apply_shader("res://shaders/grayscale.shader")
		globals.player.deck.upgrade_card(upgradable_cards[option], select_return[0])
