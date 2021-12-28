class_name Journal
extends PanelContainer

const NESTED_CHOICES_SCENE = preload("res://src/dreamscape/Overworld/SecondaryChoicesSlide.tscn")
const SELECTION_DECK_SCENE = preload("res://src/dreamscape/SelectionDeck.tscn")
const CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")
const ARTIFACT_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/ArtifactPreviewPopup.tscn")

onready var page_illustration := $HBC/MC/JournalPageIllustration
onready var page_shader := $HBC/MC/JournalPageShader
onready var journal_intro := $HBC/JournalEntry/VBC/DayIntro
onready var journal_choices := $HBC/JournalEntry/VBC/JournalChoices
onready var card_storage := $EnemyCardStorage
onready var reward_journal := $HBC/JournalEntry/VBC/RewardJournal
onready var upgrade_journal := $HBC/JournalEntry/VBC/UpgradeJournal
onready var artifact_journal := $HBC/JournalEntry/VBC/ArtifactJournal
onready var card_draft := $HBC/JournalEntry/VBC/CardDraftSlide/CardDraft
onready var card_upgrade := $HBC/JournalEntry/VBC/UgradeSlide/CardUpgrade
onready var artifact_choice := $HBC/JournalEntry/VBC/ArtifactSlide/ArtifactChoice
onready var proceed := $HBC/JournalEntry/VBC/Proceed
onready var entries_list := $HBC/JournalEntry/VBC
onready var custom_entries_pointer := $HBC/JournalEntry/VBC/CustomEntriesPointer
onready var _tween := $Tween
onready var _description_label := $MetaDescription/Label
onready var _description_popup := $MetaDescription
onready var player_info := $"../PlayerInfo"
onready var journal_cover := $"../../FadeToBlack"

# This dictionary holds links to card nodes which have been instanced as preview cards
var popup_cards := {}
var pre_highlight_bbcode_texts := {}

func _ready() -> void:
#	cfc.game_rng_seed = CFUtils.generate_random_seed() # Debug
#	globals.encounters.setup() # Debug
	globals.journal = self
	journal_intro.bbcode_text = _get_intro()
	_reveal_entry(journal_intro)
	yield(_tween, "tween_all_completed")
	var encounter_choices: Array
	globals.encounters.encounter_number += 1
	encounter_choices = globals.encounters.generate_journal_choices()
	for encounter in encounter_choices:
		var journal_choice = JournalEncounterChoice.new(self, encounter)
		journal_choices.add_child(journal_choice)
		journal_choice.connect("pressed", self, "_on_choice_pressed", [encounter, journal_choice])
		_reveal_entry(journal_choice)
		yield(_tween, "tween_all_completed")
	if not cfc.game_settings.get('first_journal_tutorial_done'):
		player_info._on_Help_pressed()
		cfc.set_setting('first_journal_tutorial_done', true)
	globals.music.switch_scene_music('journal')


func display_nce_rewards(reward_text: String) -> void:
	# This catches the player losing in an NCE
	if globals.player.damage >= globals.player.health:
		display_loss()
		return
	if reward_text != '':
		reward_journal.bbcode_text = reward_text
		_reveal_entry(reward_journal, false)
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
	proceed.bbcode_text = _get_entry_texts('PROCEED_TEXTS')
	_reveal_entry(proceed, true)

func display_enemy_rewards(reward_text: String) -> void:
	if reward_text != '':
		reward_journal.bbcode_text = "[Card Draft] " + reward_text
		_reveal_entry(reward_journal, true, "card_draft")
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
	proceed.bbcode_text = _get_entry_texts('PROCEED_TEXTS')
	_reveal_entry(proceed, true)


func display_elite_rewards(reward_text: String) -> void:
	reward_journal.bbcode_text = "[Card Draft] " + reward_text
	_reveal_entry(reward_journal, true, "elite_card_draft")
	_reveal_entry(artifact_journal, true, "elite_artifact")
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
	proceed.bbcode_text = _get_entry_texts('PROCEED_TEXTS')
	_reveal_entry(proceed, true)


func display_boss_rewards(reward_text: String) -> void:
	reward_journal.bbcode_text = "[Card Draft] " + reward_text
	_reveal_entry(reward_journal, true, "boss_card_draft")
	_reveal_entry(artifact_journal, true, "boss_artifact")
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
	globals.encounters.prepare_next_act(self)


func end_dev_version() -> void:
	proceed.bbcode_text = "And I woke up from the most restful sleep I had in months!\n\n"\
		+ "[b]Note from Developer:[/b]\nThanks for playing this early version of Hypnagonia. This is all we have at the moment. "\
		+ "Please check back regularly for new updates! And remember, we're actively looking for collaborators.\n"\
		+ "If you're a character artist, graphics designer, storyteller, card game designer, illustrator, or just someone who wants to give feedback, "\
		+ "do hit us up on our discord server: [url=discord]https://discord.gg/MqTMVDCbR3[/url] or Matrix [url=matrix]https://matrix.to/#/#hypnagonia:matrix.org[/url].\n\n"\
		+ "[url=main_menu]Back to Main Menu[/url]."
	# warning-ignore:return_value_discarded
	proceed.connect("meta_clicked", self, "_on_proceed_clicked")
	_reveal_entry(proceed, false)


func proceed_to_next_act() -> void:
	proceed.bbcode_text = _get_entry_texts('ACT_CHANGE_TEXTS')
	_reveal_entry(proceed, true)


func display_loss() -> void:
	proceed.bbcode_text = "And at this point I woke up in cold sweat!!\n\n"\
		+ "[b]Note from Developer:[/b]\nThanks for playing this early version of Hypnagonia."\
		+ "There's still more to play. Can you reach and defeat the first 'Boss'?\n\n"\
		+ "Please check back regularly for new updates! And remember, we're actively looking for collaborators.\n"\
		+ "If you're a character artist, graphics designer, storyteller, card game designer, illustrator, or just someone who wants to give feedback, "\
		+ "do hit us up on our discord server: [url=discord]https://discord.gg/MqTMVDCbR3[/url] or Matrix [url=matrix]https://matrix.to/#/#hypnagonia:matrix.org[/url].\n\n"\
		+ "[url=main_menu]Back to Main Menu[/url]."
# warning-ignore:return_value_discarded
	proceed.connect("meta_clicked", self, "_on_proceed_clicked")
	_reveal_entry(proceed, false)


func set_illustration(image: ImageTexture) -> void:
	page_illustration.texture = image


func unset_illustration() -> void:
	page_illustration.texture = null


func set_shader(shader, shader_params) -> void:
	page_shader.visible = true
	page_shader.material.shader = shader
	for param in shader_params:
		page_shader.material.set_shader_param(param, shader_params[param])


func unset_shader() -> void:
	page_shader.visible = false


# Adds more choices to the journal.
# Choices keys passed in the disabled_choices will not be clickable using gui_input
func add_nested_choices(nested_choices: Dictionary, disabled_choices := [], follow_up_node = null) -> void:
	var nested_choices_scene := NESTED_CHOICES_SCENE.instance()
	# If we're using a follow-up node, then we try to place the nested choices below it
	if follow_up_node as Node:
		var choices_selection_vbc : VBoxContainer
		if 'secondary_choices' in follow_up_node:
			choices_selection_vbc = follow_up_node.secondary_choices
		else: 
			choices_selection_vbc = VBoxContainer.new()
			entries_list.add_child_below_node(follow_up_node, choices_selection_vbc)
		choices_selection_vbc.rect_size = journal_choices.rect_size
		choices_selection_vbc.add_child(nested_choices_scene)
		nested_choices_scene.calling_node = follow_up_node
	else:
		journal_choices.add_child(nested_choices_scene)
	nested_choices_scene.call_deferred("populate_choices", nested_choices, self, disabled_choices)


func spawn_selection_deck() -> SelectionDeck:
	var selection_deck = SELECTION_DECK_SCENE.instance()
	add_child(selection_deck)
	return(selection_deck)


func prepare_popup_card(card_name: String) -> void:
	if not popup_cards.has(card_name):
		var popup_card = CARD_PREVIEW_SCENE.instance()
		card_storage.add_child(popup_card)
		popup_card.setup(card_name)
		popup_cards[card_name] = popup_card


func prepare_popup_artifact(artifact_name: String) -> void:
	if not popup_cards.has(artifact_name):
		var popup_artifact = ARTIFACT_PREVIEW_SCENE.instance()
		card_storage.add_child(popup_artifact)
		popup_artifact.setup(artifact_name)
		popup_cards[artifact_name] = popup_artifact


func grey_out_label(rt_label: RichTextLabel) -> void:
	rt_label.bbcode_text = "[color=grey]" + pre_highlight_bbcode_texts[rt_label] + "[/color]"

func add_custom_entry(entry_scene: Control) -> void:
	entries_list.add_child_below_node(custom_entries_pointer, entry_scene, true)


func _on_meta_clicked(meta_text: String) -> void:
# warning-ignore:unused_variable
	var meta_tag := _parse_meta_tag(meta_text)
	pass


func _on_meta_hover_started(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
#	print_debug(meta_tag)
	match meta_tag["meta_type"]:
		"popup_card":
			var card_name : String = meta_tag["name"]
			popup_cards[card_name]._on_GridCardObject_mouse_entered()
		"popup_artifact":
			var artifact_name : String = meta_tag["name"]
			popup_cards[artifact_name].show_preview_artifact()
		"nce":
			_show_description_popup(
					globals.current_encounter.get_meta_hover_description(
						meta_tag["name"]))


func _on_meta_hover_ended(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		"popup_card":
			var card_name : String = meta_tag["name"]
			popup_cards[card_name]._on_GridCardObject_mouse_exited()
		"popup_artifact":
			var artifact_name : String = meta_tag["name"]
			popup_cards[artifact_name].hide_preview_artifact()
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
	for popup in popup_cards:
		if popup_cards[popup].has_method("_on_GridCardObject_mouse_exited"):
			popup_cards[popup]._on_GridCardObject_mouse_exited()
		if popup_cards[popup].has_method("hide_preview_artifact"):
			popup_cards[popup].hide_preview_artifact()
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
	# Now handled in _on_rte_gui_input()
	match _meta:
		"card_draft":
			pass
		"boss_card_draft":
			pass


func _on_UpgradeJournal_meta_clicked(_meta):
	pass # Replace with function body.


func _on_ArtifactJournal_meta_clicked() -> void:
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
				card_draft.display(type)
				grey_out_label(rt_label)
			"UpgradeJournal":
				_disconnect_gui_inputs(rt_label)
				card_upgrade.display()
				grey_out_label(rt_label)
			"ArtifactJournal":
				_disconnect_gui_inputs(rt_label)
				artifact_choice.display(type)
				grey_out_label(rt_label)
			"Proceed":
				SoundManager.play_se(Sounds.get_next_journal_page_sound())
				# warning-ignore:return_value_discarded
				get_tree().change_scene(CFConst.PATH_CUSTOM + 'Overworld/Journal.tscn')


func _get_intro() -> String:
# warning-ignore:unused_variable
	var intro_texts_array: Array
	if globals.encounters.encounter_number == 0:
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
			OS.shell_open("https://discord.gg/MqTMVDCbR3")
		"matrix":
			# warning-ignore:return_value_discarded
			OS.shell_open("https://matrix.to/#/#hypnagonia:matrix.org")
		"main_menu":
			SoundManager.play_se('book_close')
			# warning-ignore:return_value_discarded
			globals.quit_to_main()


func _show_description_popup(description_text: String) -> void:
	_description_label.text = description_text
	_description_popup.visible = true
	_description_popup.rect_size = Vector2(0,0)
	_description_popup.rect_global_position = get_local_mouse_position() + Vector2(20,-50)
	if _description_popup.rect_global_position.x + _description_popup.rect_size.x > get_viewport().size.x:
		_description_popup.rect_global_position.x = get_viewport().size.x - _description_popup.rect_size.x


func _input(event):
	### Debug ###
	if event.is_action_pressed("init_debug_game"):
		# Upgrade cards debug
#		for c in  globals.player.deck.get_progressing_cards():
#			c.upgrade_progress = 100
#		_reveal_entry(upgrade_journal, true)
		globals.player.add_artifact(ArtifactDefinitions.BossDraft.canonical_name)
		globals.player.add_memory("FortifySelf")
#		globals.player.add_artifact("AccumulateShop")
#		globals.player.damage += 20
#		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.nce, 200)
		var debug_encounters = [
#			EnemyEncounter.new(Act2.ClownShow, "hard"),
			preload("res://src/dreamscape/Run/NCE/Act2/BannersOfRuin.gd").new(),
			BossEncounter.new(Act1.BOSSES["Narcissus"], "Narcissus"),
#			EliteEncounter.new(Act2.IndescribableAbsurdity, "medium"),
#			preload("res://src/dreamscape/Run/NCE/Shop.gd").new()
		]
		for encounter in debug_encounters:
			var journal_choice = JournalEncounterChoice.new(self, encounter)
			journal_choices.add_child(journal_choice)
			journal_choice.connect("pressed", self, "_on_choice_pressed", [encounter, journal_choice])
			_reveal_entry(journal_choice)
#		print_debug(SoundManager._get_all_playing_type_steams('BGM'))

