class_name Journal
extends PanelContainer

signal card_draft_started(card_draft_node)
signal card_upgrade_started(card_upgrade_node)
signal artifact_selection_started(artifact_selection_node)
signal memory_selection_started(memory_selection_node)
signal choice_entry_added(choice_entry)
signal secondary_entry_added(choice_entry)
signal encounter_start(encounter)
signal page_turned()
signal selection_deck_spawned(selection_deck)
signal entry_displayed(entry)

const NESTED_CHOICES_SCENE = preload("res://src/dreamscape/Overworld/SecondaryChoicesSlide.tscn")
const SELECTION_DECK_SCENE = preload("res://src/dreamscape/SelectionDeck.tscn")
const CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")
const ARTIFACT_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/ArtifactPreviewPopup.tscn")
const JOURNAL_ENCOUNTER_CHOICE_SCENE = preload("res://src/dreamscape/Overworld/JournalEncounterChoiceScene.tscn")
const PATHOS_INFO_SCENE = preload("res://src/dreamscape/PathosChangeInfo.tscn")

const WORD_DEFINITIONS := {
	"scar": "Will permanently degrade a card in a random manner",
	"enhance": "Will permanently improve a card in a random manner",
	"anxiety_up": "Will increase the dreamer's Anxiety. If this reaches the max, the dreamer will wake up and the game is over.",
	"anxiety_down": "Will decrease the anxiety. This avoids losing the game.",
	"anxiety": "Max Anxiety: When your anxiety reaches this threshold, the dreamer wakes up and you lose the game.",
	"masteries": "You use masteries to purchase different things in the shop.",
	"mastery": "You use masteries to purchase different things in the shop.",
}

var pathos_infos := {}
# This is set to fase a millisecond after a popup closes
# to avoid the click which closes it, selecting a choice
var popups_active := false
# This dictionary holds links to card nodes which have been instanced as preview cards
var popup_cards := {}
var pre_highlight_bbcode_texts := {}
var reward_choices_unpreviewed := []

onready var page_illustration := $HBC/MC/JournalPageIllustration
onready var page_shader := $HBC/MC/JournalPageShader
onready var journal_intro := $HBC/JournalEntry/VBC/DayIntro
onready var journal_choices := $HBC/JournalEntry/VBC/JournalChoices
onready var card_storage := $EnemyCardStorage
onready var reward_journal := $HBC/JournalEntry/VBC/RewardJournal
onready var upgrade_journal := $HBC/JournalEntry/VBC/UpgradeJournal
onready var artifact_journal := $HBC/JournalEntry/VBC/ArtifactJournal
onready var memory_journal := $HBC/JournalEntry/VBC/MemoryJournal
onready var card_draft := $HBC/JournalEntry/VBC/CardDraftSlide/CardDraft
onready var card_upgrade := $HBC/JournalEntry/VBC/UgradeSlide/CardUpgrade
onready var artifact_choice := $HBC/JournalEntry/VBC/ArtifactSlide/ArtifactChoice
onready var memory_choice := $HBC/JournalEntry/VBC/MemorySlide/MemoryChoice
onready var proceed := $HBC/JournalEntry/VBC/Proceed
onready var entries_list := $HBC/JournalEntry/VBC
onready var custom_entries_pointer := $HBC/JournalEntry/VBC/CustomEntriesPointer
onready var _tween := $Tween
onready var _description_label := $MetaDescription/Label
onready var _description_popup := $MetaDescription
onready var pathos_details_popup := $PathosDetails
onready var _pathos_details_list := $PathosDetails/VBC
onready var _pathos_description := $PathosDetails/VBC/Description
onready var player_info := $"../PlayerInfo"
onready var journal_cover := $"../../FadeToBlack"


func _ready() -> void:
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Journal: Entering Journal")
	if globals.player.pathos:
		for entry in Terms.RUN_ACCUMULATION_NAMES.values():
			var pinfo = PATHOS_INFO_SCENE.instance()
			_pathos_details_list.add_child_below_node($PathosDetails/VBC/Header, pinfo)
			pathos_infos[entry] = pinfo
			pinfo.setup(entry)
#	cfc.game_rng_seed = CFUtils.generate_random_seed() # Debug
#	globals.encounters.setup() # Debug
	globals.journal = self
	player_info.owner_node = self
	# warning-ignore:return_value_discarded
	player_info.connect("popup_opened", self, "_on_playerinfo_popup_opened")
	_setup()

# This is split from ready() so that it can be extended in RestoredJournal
func _setup() -> void:
	journal_intro.bbcode_text = _get_intro()
	_reveal_entry(journal_intro)
	if not globals.test_flags.get("no_journal_fade"):
		yield(_tween, "tween_all_completed")
	var encounter_choices: Array
	globals.encounters.encounter_number += 1
	journal_choices.set_owner(self)
	encounter_choices = globals.encounters.generate_journal_choices()
	for encounter in encounter_choices:
		var journal_choice_scene = JOURNAL_ENCOUNTER_CHOICE_SCENE.instance()
		journal_choices.add_child(journal_choice_scene)
		journal_choice_scene.setup(self, encounter)
		journal_choice_scene.journal_choice.connect(
				"pressed",
				self,
				"_on_choice_pressed",
				[encounter, journal_choice_scene])
		_reveal_entry(journal_choice_scene.journal_choice)
		emit_signal("choice_entry_added", journal_choice_scene)
		if not globals.test_flags.get("no_journal_fade"):
			yield(_tween, "tween_all_completed")
	if not cfc.game_settings.get('first_journal_tutorial_done'):
		player_info._on_Help_pressed()
		cfc.set_setting('first_journal_tutorial_done', true)
	globals.music.switch_scene_music('journal')
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Journal: Journal Loaded")

func display_nce_rewards(reward_text: String, add_draft_type = null) -> void:
	# This catches the player losing in an NCE
	if globals.player.damage >= globals.player.health:
		display_loss()
		return
	if add_draft_type:
		match add_draft_type:
			"empty_draft":
				reward_text = '[Card Reward] ' + reward_text
			"card_draft":
				reward_text = '[Card Draft] ' + reward_text
		_reveal_entry(reward_journal, true, add_draft_type)
	if reward_text != '':
		reward_journal.bbcode_text = reward_text
		_reveal_entry(reward_journal, false)
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
		reward_choices_unpreviewed.append(upgrade_journal.name)
	proceed.bbcode_text = _get_entry_texts('PROCEED_TEXTS')
	_reveal_entry(proceed, true)


func display_enemy_rewards(reward_text: String = '') -> void:
	if reward_text != '':
		reward_journal.bbcode_text = "[Card Draft] " + reward_text
		_reveal_entry(reward_journal, true, "card_draft")
		reward_choices_unpreviewed.append(reward_journal.name)
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
		reward_choices_unpreviewed.append(upgrade_journal.name)
	proceed.bbcode_text = _get_entry_texts('PROCEED_TEXTS')
	_reveal_entry(proceed, true)


func display_elite_rewards(reward_text: String) -> void:
	reward_journal.bbcode_text = "[Card Draft] " + reward_text
	_reveal_entry(reward_journal, true, "elite_card_draft")
	reward_choices_unpreviewed.append(reward_journal.name)
	_reveal_entry(artifact_journal, true, "elite_artifact")
	reward_choices_unpreviewed.append(artifact_journal.name)
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
		reward_choices_unpreviewed.append(upgrade_journal.name)
	proceed.bbcode_text = _get_entry_texts('PROCEED_TEXTS')
	_reveal_entry(proceed, true)


func display_boss_rewards(reward_text: String) -> void:
	if globals.encounters.current_act == Act3:
		end_dev_version()
		return
	reward_journal.bbcode_text = "[Card Draft] " + reward_text
	_reveal_entry(reward_journal, true, "boss_card_draft")
	reward_choices_unpreviewed.append(reward_journal.name)
	_reveal_entry(artifact_journal, true, "boss_artifact")
	reward_choices_unpreviewed.append(artifact_journal.name)
	if globals.player.deck.get_upgradeable_cards().size():
		_reveal_entry(upgrade_journal, true)
		reward_choices_unpreviewed.append(upgrade_journal.name)
	globals.encounters.prepare_next_act(self)

# This reward is a bit more special, as it doesn't have many types
# so instead we pass it the amount of memories instead
func display_memory_rewards(memory_payload:= {"quantity": 1}) -> void:
	_reveal_entry(memory_journal, true, memory_payload)
	reward_choices_unpreviewed.append(memory_journal.name)

# This reward is a bit more special, as it doesn't have many types
# so instead we pass it the amount of memories instead
func display_empty_card_rewards() -> void:
	reward_journal.bbcode_text = "[Card Reward]"
	_reveal_entry(reward_journal, true, "empty_draft")
	reward_choices_unpreviewed.append(reward_journal.name)


func end_dev_version() -> void:
	globals.game_save.delete_save()
	var victory_texts = JournalTexts.VICTORY_TEXTS.get(
			globals.player.deck_groups[Terms.CARD_GROUP_TERMS.life_goal],
			JournalTexts.VICTORY_TEXTS.generic)
	CFUtils.shuffle_array(victory_texts, true)
	proceed.bbcode_text = victory_texts[0] + "\n\n"\
		+ "[b]Note from Developer:[/b]\nThanks for playing this early version of Hypnagonia and we hope that you enjoyed the experience. "\
		+ "Keep playing to see all the game has to offer and the various playstyles. Each run is completely different!\n\n"\
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
	globals.game_save.delete_save()
	proceed.bbcode_text = "And at this point I woke up in cold sweat!!\n\n"\
		+ "[b]Note from Developer:[/b]\nThanks for playing this early version of Hypnagonia."\
		+ "There's still more to play. Can you reach and defeat the third act 'Boss'?\n\n"\
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
		# If the follow-up node has a `secondary_choices` var, and it's a VBoxContainer node
		# it expects the new choices we're adding to be placed under it.
		if 'secondary_choices' in follow_up_node:
			choices_selection_vbc = follow_up_node.secondary_choices
		else:
			choices_selection_vbc = VBoxContainer.new()
			entries_list.add_child_below_node(follow_up_node, choices_selection_vbc)
			entries_list.set_owner(choices_selection_vbc)
		choices_selection_vbc.rect_size = journal_choices.rect_size
		choices_selection_vbc.add_child(nested_choices_scene)
		nested_choices_scene.set_owner(choices_selection_vbc)
		nested_choices_scene.calling_node = follow_up_node
	else:
		journal_choices.add_child(nested_choices_scene)
		nested_choices_scene.set_owner(journal_choices)
	nested_choices_scene.call_deferred("populate_choices", nested_choices, self, disabled_choices)
	emit_signal("secondary_entry_added", nested_choices_scene)


func spawn_selection_deck() -> SelectionDeck:
	var selection_deck = SELECTION_DECK_SCENE.instance()
	if globals.current_encounter\
			and globals.current_encounter as ShopEncounter\
			and globals.current_encounter.current_shop:
		globals.current_encounter.current_shop.add_child(selection_deck)
	else:
		add_child(selection_deck)
		selection_deck.set_owner(self)
	emit_signal("selection_deck_spawned", selection_deck)
	return(selection_deck)


func prepare_popup_card(card) -> void:
	var popup_card = CARD_PREVIEW_SCENE.instance()
	card_storage.add_child(popup_card)
	popup_card.set_owner(card_storage)
	if typeof(card) == TYPE_STRING:
		if not popup_cards.has(card):
			popup_card.setup(card)
			popup_cards[card] = popup_card
	else:
		if not popup_cards.has(card.get_instance_id()):
			popup_card.setup(card.instance_self(true))
			popup_cards[card.get_instance_id()] = popup_card


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
	entry_scene.set_owner(entries_list)
	emit_signal("choice_entry_added", entry_scene)


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
		"popup_card_entry":
			var card_entry_id : int = meta_tag["name"]
			popup_cards[card_entry_id]._on_GridCardObject_mouse_entered()
		"popup_artifact":
			var artifact_name : String = meta_tag["name"]
			popup_cards[artifact_name].show_preview_artifact()
		"nce":
			show_description_popup(
					globals.current_encounter.get_meta_hover_description(
						meta_tag["name"]))
		"definition":
			var pathos_descriptions = Terms.get_pathos_descriptions_formats()
			if WORD_DEFINITIONS.has(meta_tag["definition"]):
				show_description_popup(WORD_DEFINITIONS[meta_tag["definition"]])
			if pathos_descriptions.has(meta_tag["definition"]):
				show_description_popup(pathos_descriptions[meta_tag["definition"]])



func _on_meta_hover_ended(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		"popup_card":
			var card_name : String = meta_tag["name"]
			popup_cards[card_name]._on_GridCardObject_mouse_exited()
		"popup_card_entry":
			var card_entry_id : int = meta_tag["name"]
			popup_cards[card_entry_id]._on_GridCardObject_mouse_exited()
		"popup_artifact":
			var artifact_name : String = meta_tag["name"]
			popup_cards[artifact_name].hide_preview_artifact()
		"nce", "definition":
			_description_popup.visible = false


func _parse_meta_tag(meta_text: String) -> Dictionary:
	var json_parse: JSONParseResult = JSON.parse(meta_text)
	if not json_parse or json_parse.error_string:
		print_debug("WARN: Malformated json result:" + meta_text)
		return({"meta_type": "FAULTED:"})
	return(json_parse.result)


func _on_choice_pressed(encounter: SingleEncounter, rich_text_choice) -> void:
	if _tween.is_active():
		yield(_tween, "tween_all_completed")
	for choice in journal_choices.get_children():
		if choice != rich_text_choice:
			choice.visible = false
			choice.journal_choice.encounter.ignore()
		elif choice.has_method("disable_mouse_inputs"):
			choice.disable_mouse_inputs()
	# To ensure card previews are hidden in case the player is too fast.
	_description_popup.visible = false
	for popup in popup_cards:
		if popup_cards[popup].has_method("_on_GridCardObject_mouse_exited"):
			popup_cards[popup]._on_GridCardObject_mouse_exited()
		if popup_cards[popup].has_method("hide_preview_artifact"):
			popup_cards[popup].hide_preview_artifact()
	encounter.begin()
	emit_signal("encounter_start", encounter)


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
	emit_signal("entry_displayed", rich_text_node)


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


func _on_MemoryJournal_meta_clicked() -> void:
	pass # Replace with function body.


func _on_rte_mouse_entered(rt_label: RichTextLabel) -> void:
	# We store this so we can revert the bbcode text without the yello highlight
	rt_label.bbcode_text = "[color=yellow]" + rt_label.bbcode_text + "[/color]"


func _on_rte_mouse_exited(rt_label: RichTextLabel) -> void:
	rt_label.bbcode_text = pre_highlight_bbcode_texts[rt_label]


func _on_rte_gui_input(event, rt_label: RichTextLabel, type = 'card_draft') -> void:
	if event.is_pressed() and event.get_button_index() == 1:
		if popups_active:
			return
		reward_choices_unpreviewed.erase(rt_label.name)
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
			"MemoryJournal":
				_disconnect_gui_inputs(rt_label)
				memory_choice.display(type)
				grey_out_label(rt_label)
			"Proceed":
				if reward_choices_unpreviewed.size() > 0:
					var popup = AcceptDialog.new()
					popup.dialog_text = "Warning: You have not yet reviewed all the rewards from this encounter."
					add_child(popup)
					popup.popup_centered_minsize()
					reward_choices_unpreviewed.clear()
					return
				emit_signal("page_turned")
				SoundManager.play_se(Sounds.get_next_journal_page_sound())
				# warning-ignore:return_value_discarded
				globals.game_save.save_state()
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
		CFUtils.shuffle_array(globals.unused_journal_texts[entries_key], true)
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


func show_description_popup(description_text: String) -> void:
	_description_label.bbcode_text = description_text
	_description_popup.visible = true
	_description_popup.rect_size = Vector2(0,0)
	_description_popup.rect_global_position = get_local_mouse_position()\
			+ Vector2(-_description_popup.rect_size.x/1.5,-_description_popup.rect_size.y/1.5)
#	if _description_popup.rect_global_position.x + _description_popup.rect_size.x > get_viewport().size.x:
#		_description_popup.rect_global_position.x = get_viewport().size.x - _description_popup.rect_size.x


func show_pathos_popup(description_text: String, pathos_dict: Dictionary) -> void:
	_pathos_description.bbcode_text = description_text
	for child in journal_choices.get_children():
		if pathos_dict[child.pathos_released]["repress_mod"] == 0:
			var pathos_type: PathosType = globals.player.pathos.pathi[child.pathos_released]
			pathos_dict[child.pathos_released]["repress_mod"] = -pathos_type.get_final_release_amount()
	var highest_chance: int
	for entry in pathos_infos:
		var chance = pathos_infos[entry].update_labels(pathos_dict)
		if chance > highest_chance:
			highest_chance = chance
#	print_debug(total_chance)
	if highest_chance == 0:
		pathos_infos[Terms.RUN_ACCUMULATION_NAMES.enemy].set_max_chance()
	# If I use the popup() function, it takes priority on mouse inputs on the whole screen
	# Which means when I move the mouse, it consider it "exited" from the pathos icon
	# so it them immediately hides then popup, causing a flickering effect.
	pathos_details_popup.visible = true
#	pathos_details_popup.visible = true
	pathos_details_popup.rect_size = Vector2(0,0)
	pathos_details_popup.rect_global_position = get_local_mouse_position() + Vector2(-pathos_details_popup.rect_size.x - 20,-5)


func _input(event):
	### Debug ###
	if event.is_action_pressed("Show FPS"):
		print(Engine.get_frames_per_second())
	if event.is_action_pressed("init_debug_game"):
		pass
#		globals.player.deck.add_new_card("Guilt")
		# Upgrade cards debug
#		for c in globals.player.deck.get_progressing_cards():
#			c.upgrade_progress = c.upgrade_threshold
#			if c.card_name == "Noisy Whip":
#				globals.player.deck.remove_card(c)
#		_reveal_entry(upgrade_journal, true)
#	d	globals.player.deck.add_new_card("Guilt")
#		globals.player.deck.add_new_card("Catatonia")
		globals.player.add_artifact(ArtifactDefinitions.BufferedSpawns.canonical_name)
#		globals.player.add_artifact(ArtifactDefinitions.EnhanceOnRest.canonical_name)
#		globals.player.add_artifact(ArtifactDefinitions.PerturbationHeal.canonical_name)
#		globals.player.add_artifact(ArtifactDefinitions.CostlyUpgrades.canonical_name)
		globals.player.add_memory(MemoryDefinitions.DamageAll.canonical_name)
#		globals.player.add_memory(MemoryDefinitions.BossFaster.canonical_name)
#		globals.player.add_memory(MemoryDefinitions.RerollDraft.canonical_name)
#		globals.player.add_memory(MemoryDefinitions.ImmerseSelf.canonical_name)
		# warning-ignore:return_value_discarded
#		globals.player.add_memory(MemoryDefinitions.FreezeCard.canonical_name)
#		var card_entry = globals.player.deck.add_new_card("Towering Presence")
#		card_entry.upgrade_progress = card_entry.upgrade_threshold - 1
#		var new_card = globals.player.deck.add_new_card("Store in Mind")
#		new_card.modify_property("_amounts", {"amount_key": "beneficial_integer", "amount_value": "+1"})
#		globals.player.deck.add_new_card("A Fine Specimen")
#		globals.player.deck.add_new_card("Chasm")
#		globals.player.deck.add_new_card("Chasm")
#		globals.player.deck.add_new_card("Prejudice")
#		globals.player.damage += 20
#		globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact].repressed = 100
#		globals.player.damage = 85
#		globals.player.pathos.available_masteries += 6
		var debug_encounters = [
#			EnemyEncounter.new(Act1.Clown, "hard"),
#			EnemyEncounter.new(Act2.ENEMIES.Lotustus, "medium"),
#			EnemyEncounter.new(Act3.Cringelord, "hard"),
#			load(AllActs.NCE.risky.OstrichEggs).new(),
#			load(Act1.NCE.risky.Spider).new(),
#			load(Act1.NCE.easy.MonsterTrain).new(),
#			load(Act2.NCE.easy.Subconscious).new(),
#			load(Act3.NCE.easy.BeastMirror).new(),
			load(Act3.NCE.risky.UnderwaterCave).new(),
#			load("res://src/dreamscape/Run/NCE/Artifact.gd").new(),
#			load("res://src/dreamscape/Run/NCE/Rest.gd").new(),
#			load("res://src/dreamscape/Run/NCE/Shop.gd").new(),
#			BossEncounter.new(Act1.BOSSES["Narcissus"]),
#			BossEncounter.new(Act2.BOSSES["Surreality"]),
#			BossEncounter.new(Act3.BOSSES["Fear_and_Phobia"]),
#			EliteEncounter.new(Act1.Leviathan, "hard"),
#			EliteEncounter.new(Act2.IndescribableAbsurdity, "medium"),
#			EliteEncounter.new(Act3.TheGatherer, "medium"),
#			load("res://src/dreamscape/Run/NCE/Shop.gd").new(),
#			load("res://src/dreamscape/Run/NCE/Rest.gd").new(),
			load("res://src/dreamscape/Run/NCE/Artifact.gd").new(),
		]
		for encounter in debug_encounters:
			var journal_choice_scene = JOURNAL_ENCOUNTER_CHOICE_SCENE.instance()
			journal_choices.add_child(journal_choice_scene)
			journal_choice_scene.set_owner(journal_choices)
			journal_choice_scene.setup(self, encounter)
			journal_choice_scene.journal_choice.connect("pressed", self, "_on_choice_pressed", [encounter, journal_choice_scene])
			_reveal_entry(journal_choice_scene.journal_choice)
			emit_signal("choice_entry_added", journal_choice_scene)
#		print_debug(SoundManager._get_all_playing_type_steams('BGM'))

# These three functions,prevent warnings in the compiler
# as opposed to calling the emit signal from the other node directly
func card_draft_started(card_draft_node) -> void:
	emit_signal("card_draft_started", card_draft_node)


func artifact_selection_started(artifact_selection_node) -> void:
	emit_signal("artifact_selection_started", artifact_selection_node)


func memory_selection_started(memory_selection_node) -> void:
	emit_signal("memory_selection_started", memory_selection_node)


func card_upgrade_started(card_upgrade_node) -> void:
	emit_signal("card_upgrade_started", card_upgrade_node)


func _exit_tree():
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Journal: Exiting/Changing Journal")


func _on_playerinfo_popup_hidden() -> void:
	popups_active = false

func _on_playerinfo_popup_opened(popup_node: Popup) -> void:
	popups_active = true
	if popup_node.is_connected("popup_hide", self, "_on_playerinfo_popup_hidden"):
		return
	# warning-ignore:return_value_discarded
	popup_node.connect("popup_hide", self, "_on_playerinfo_popup_hidden", [], CONNECT_DEFERRED)
