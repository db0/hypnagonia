class_name Journal
extends PanelContainer

const NESTED_CHOICES_SCENE = preload("res://src/dreamscape/Overworld/SecondaryChoicesSlide.tscn")

onready var page_illustration := $HBC/JournalPageIllustration
onready var journal_intro := $HBC/JournalEntry/VBC/DayIntro
onready var journal_choices := $HBC/JournalEntry/VBC/JournalChoices
onready var card_storage := $EnemyCardStorage
onready var reward_journal := $HBC/JournalEntry/VBC/RewardJournal
onready var upgrade_journal := $HBC/JournalEntry/VBC/UpgradeJournal
onready var card_draft := $HBC/JournalEntry/VBC/CardDraftSlide/CardDraft
onready var card_upgrade := $HBC/JournalEntry/VBC/UgradetSlide/CardUpgrade
onready var proceed := $HBC/JournalEntry/VBC/Proceed
onready var _tween := $Tween
onready var _description_label := $MetaDescription/Label
onready var _description_popup := $MetaDescription

var enemy_cards := {}
var pre_highlight_bbcode_texts := {}

func _ready() -> void:
#	cfc.game_rng_seed = CFUtils.generate_random_seed() # Debug
#	globals.encounters.setup() # Debug
	globals.journal = self
	journal_intro.bbcode_text = _get_intro()
	_reveal_entry(journal_intro)
	yield(_tween, "tween_all_completed")
	var encounter_choices: Array
	globals.encounter_number += 1
	encounter_choices = globals.encounters.generate_journal_choices()
	for encounter in encounter_choices:
		var journal_choice = JournalEncounterChoice.new(self, encounter)
		journal_choices.add_child(journal_choice)
		journal_choice.connect("pressed", self, "_on_choice_pressed", [encounter, journal_choice])
		_reveal_entry(journal_choice)
		yield(_tween, "tween_all_completed")


func display_rewards(reward_text: String) -> void:
	if reward_text != '':
		reward_journal.bbcode_text = reward_text
		_reveal_entry(reward_journal, true, "card_draft")
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
	proceed.bbcode_text = _get_entry_texts('PROCEED_TEXTS')
	_reveal_entry(proceed, true)


func display_boss_rewards(reward_text: String) -> void:
	reward_journal.bbcode_text = reward_text
	_reveal_entry(reward_journal, true, "boss_card_draft")
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
	proceed.bbcode_text = "And I woke up from the most restful sleep I had in months!\n\n"\
		+ "[b]Note from Developer:[/b]\nThanks for playing this early version of Project Dreams. This is all we have at the moment. "\
		+ "Please check back regularly for new updates! And remember, we're actively looking for collaborators.\n"\
		+ "If you're a character artist, graphics designer, storyteller, card game designer, illustrator, or just someone who wants to give feedback, "\
		+ "do hit us up on our discord server: [url=discord]https://discord.gg/KFKHt6Ch[/url].\n\n"\
		+ "[url=main_menu]Back to Main Menu[/url]."
	_reveal_entry(proceed, true)

func display_loss() -> void:
	proceed.bbcode_text = "And at this point I woke up in cold sweat!!\n\n"\
		+ "[b]Note from Developer:[/b]\nThanks for playing this early version of Project Dreams."\
		+ "There's still more to play. Can you reach and defeat the first 'Boss'?\n\n"\
		+ "Please check back regularly for new updates! And remember, we're actively looking for collaborators.\n"\
		+ "If you're a character artist, graphics designer, storyteller, card game designer, illustrator, or just someone who wants to give feedback, "\
		+ "do hit us up on our discord server: [url=discord]https://discord.gg/KFKHt6Ch[/url].\n\n"\
		+ "[url=main_menu]Back to Main Menu[/url]."
# warning-ignore:return_value_discarded
	proceed.connect("meta_clicked", self, "_on_proceed_clicked")
	_reveal_entry(proceed, true)


func set_illustration(image: ImageTexture) -> void:
	page_illustration.texture = image


func unset_illustration() -> void:
	page_illustration.texture = null


func add_nested_choices(nested_choices: Dictionary) -> void:
	var nested_choices_scene := NESTED_CHOICES_SCENE.instance()
	journal_choices.add_child(nested_choices_scene)
	nested_choices_scene.call_deferred("populate_choices", nested_choices, self)



func _on_meta_clicked(meta_text: String) -> void:
# warning-ignore:unused_variable
	var meta_tag := _parse_meta_tag(meta_text)
	pass


func _on_meta_hover_started(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		"torment_card":
			var torment_name : String = meta_tag["name"]
			enemy_cards[torment_name]._on_GridCardObject_mouse_entered()
		"nce":
			_show_description_popup(
					globals.current_encounter.get_meta_hover_description(
						meta_tag["name"]))


func _on_meta_hover_ended(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		"torment_card":
			var torment_name : String = meta_tag["name"]
			enemy_cards[torment_name]._on_GridCardObject_mouse_exited()
		"nce":
			_description_popup.visible = false


func _parse_meta_tag(meta_text: String) -> Dictionary:
	var json_parse: JSONParseResult = JSON.parse(meta_text)
	if not json_parse or json_parse.error_string:
		print_debug("WARN: Malformated json result:" + meta_text)
		return({"meta_type": "FAULTED:"})
	return(json_parse.result)


func _on_choice_pressed(encounter: SingleEncounter, rich_text_choice: JournalChoice) -> void:
	for choice in journal_choices.get_children():
		if choice != rich_text_choice:
			choice.visible = false
	# To ensure card previews are hidden in case the player is too fast.
	_description_popup.visible = false
	for torment_name in enemy_cards:
		enemy_cards[torment_name]._on_GridCardObject_mouse_exited()
	encounter.begin()


func _reveal_entry(
		rich_text_node: RichTextLabel, 
		connect_rte_signals := false, 
		extra_gui_input_args = null) -> void:
	pre_highlight_bbcode_texts[rich_text_node] = rich_text_node.bbcode_text
	rich_text_node.show()
	if connect_rte_signals:
		# warning-ignore:return_value_discarded
		rich_text_node.connect("mouse_entered", self, "_on_rte_mouse_entered", [rich_text_node] )
		# warning-ignore:return_value_discarded
		rich_text_node.connect("mouse_exited", self, "_on_rte_mouse_exited", [rich_text_node] )
		# warning-ignore:return_value_discarded
		rich_text_node.connect("gui_input", self, "_on_rte_gui_input", [rich_text_node, extra_gui_input_args] )
	_tween.interpolate_property(rich_text_node,
			'modulate:a', 0, 1, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()


func _disconnect_gui_inputs(rich_text_node: RichTextLabel) -> void:
	# warning-ignore:return_value_discarded
	rich_text_node.disconnect("mouse_entered", self, "_on_rte_mouse_entered")
	# warning-ignore:return_value_discarded
	rich_text_node.disconnect("mouse_exited", self, "_on_rte_mouse_exited")
	# warning-ignore:return_value_discarded
	rich_text_node.disconnect("gui_input", self, "_on_rte_gui_input")


func _on_RewardJournal_meta_clicked(_meta: String) -> void:
	match _meta:
		"card_draft":
			pass
		"boss_card_draft":
			card_draft.display(true)
			reward_journal.bbcode_text = "[color=grey]" + reward_journal.text + "[/color]"


func _on_UpgradeJournal_meta_clicked(_meta):
	pass # Replace with function body.


func _on_rte_mouse_entered(rt_label: RichTextLabel) -> void:
	# We store this so we can revert the bbcode text without the yello highlight
	rt_label.bbcode_text = "[color=yellow]" + rt_label.bbcode_text + "[/color]"


func _on_rte_mouse_exited(rt_label: RichTextLabel) -> void:
	rt_label.bbcode_text = pre_highlight_bbcode_texts[rt_label]


func _on_rte_gui_input(event, rt_label: RichTextLabel, type = 'card_draft') -> void:
	if event.is_pressed() and event.get_button_index() == 1:
		match rt_label.name:
			"RewardJournal":
				_disconnect_gui_inputs(rt_label)
				if type == "boss_card_draft":
					card_draft.display(true)
				else:
					card_draft.display()
				reward_journal.bbcode_text = "[color=grey]" + pre_highlight_bbcode_texts[rt_label] + "[/color]"
			"UpgradeJournal":
				_disconnect_gui_inputs(rt_label)
				card_upgrade.display()
				upgrade_journal.bbcode_text = "[color=grey]" + pre_highlight_bbcode_texts[rt_label] + "[/color]"
			"Loss":
				pass
			"Proceed":
				if globals.encounter_number >= 7:
# warning-ignore:return_value_discarded
					get_tree().change_scene(CFConst.PATH_CUSTOM + 'MainMenu/MainMenu.tscn')
				else:
# warning-ignore:return_value_discarded
					get_tree().change_scene(CFConst.PATH_CUSTOM + 'Overworld/Journal.tscn')


func _get_intro() -> String:
# warning-ignore:unused_variable
	var intro_texts_array: Array
	if globals.encounter_number == 0:
		return(_get_entry_texts('OPENING_JOURNAL_INTROS'))
	else:
		return(_get_entry_texts('FOLLOWUP_PAGE_INTROS'))


func _get_entry_texts(entries_key: String) -> String:
	if not globals.unused_journal_texts.has(entries_key)\
			or not globals.unused_journal_texts[entries_key].size():
		globals.unused_journal_texts[entries_key] = JournalTexts[entries_key].duplicate()
		CFUtils.shuffle_array(globals.unused_journal_texts[entries_key])
	return(globals.unused_journal_texts[entries_key].pop_back())


func _on_proceed_clicked(_meta: String) -> void:
	match _meta:
		"discord":
# warning-ignore:return_value_discarded
			OS.shell_open("https://discord.gg/KFKHt6Ch")
		"main_menu":
# warning-ignore:return_value_discarded
			get_tree().change_scene(CFConst.PATH_CUSTOM + 'MainMenu/MainMenu.tscn')
			globals.reset()

func _show_description_popup(description_text: String) -> void:
	_description_label.text = description_text
	_description_popup.visible = true
	_description_popup.rect_size = Vector2(0,0)
	_description_popup.rect_global_position = get_local_mouse_position() + Vector2(20,-50)
	if _description_popup.rect_global_position.x + _description_popup.rect_size.x > get_viewport().size.x:
		_description_popup.rect_global_position.x = get_viewport().size.x - _description_popup.rect_size.x

