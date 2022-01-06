class_name PlayerInfo
extends PanelContainer


const CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")
const PATHOS_INFO_SCENE = preload("res://src/dreamscape/PathosEntryInfo.tscn")
const SETTINGS_SCENE = preload("res://src/dreamscape/MainMenu/SettingsMenu.tscn")

# Because we do not have a common PlayerInfo node throughout the whole game
# but rather we have different instances for it for each scene which
# covers the whole screen, we need to define the context in which a
# PlayerInfo scene added. We do that using this enum.
# This allows us to know which artifacts effect to turn off/on in the overall scene.
# This allows us to avoid a combat artifact node added to the Journal PlayerInfo
# triggering during battle.
export(ArtifactDefinitions.EffectContext) var context

var current_decklist_cache: Array
var pathos_infos := {}
var popup_settings : PopupPanel
var owner_node: Control

onready var _deck_preview_popup := $DeckPreview
onready var _deck_preview_scroll := $DeckPreview/ScrollContainer/
onready var _deck_preview_grid := $DeckPreview/ScrollContainer/GridContainer
onready var _player_health_label := $HBC/Health
onready var _encounter_label := $HBC/Encounter
onready var _deck_button := $HBC/Deck
onready var _artifact_popup := $ArtifactsPopup
onready var _artifact_button := $HBC/Curios
onready var _tutorial_button := $HBC/Help
onready var _settings_button := $HBC/Settings
onready var _button_desc_popup := $ButtonDescriptionPopup
onready var _button_description := $ButtonDescriptionPopup/ButtonDescription
onready var _pathos_details := $PathosDetails
onready var _pathos_details_list := $PathosDetails/VBC
onready var _pathos_description := $PathosDetails/VBC/Description
onready var _pathos_button := $HBC/Pathos
onready var _help := $Help
onready var _tutorial := $Help/Tutorial
onready var _artifacts := $ArtifactsPopup/Artifacts
onready var _memories := $HBC/Memories
onready var _version := $HBC/Version

func _ready() -> void:
	$PathosDetails/VBC/Header.description = _pathos_description
	if globals.player.pathos:
		for entry in globals.player.pathos.repressed:
			var pinfo = PATHOS_INFO_SCENE.instance()
#			_pathos_details_list.add_child(pinfo)
			_pathos_details_list.add_child_below_node($PathosDetails/VBC/Header, pinfo)
			pathos_infos[entry] = pinfo
			pinfo.setup(entry, _pathos_description)
	for button in [_artifact_button,_pathos_button,_deck_button, _tutorial_button, _settings_button]:
		button.connect("mouse_entered", self, "_on_button_mouse_entered", [button])
		button.connect("mouse_exited", self, "_on_button_mouse_exited", [button])
	# warning-ignore:return_value_discarded
	globals.player.connect("artifact_added", self, "_on_artifact_added")
	# warning-ignore:return_value_discarded
	globals.player.connect("memory_added", self, "_on_memory_added")
	_init_artifacts()
	_init_memories()
	_version.text = CFConst.GAME_VERSION
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed",self,"_on_Viewport_size_changed")
	# warning-ignore:return_value_discarded
	globals.player.connect("health_changed", self, "_update_health_label")
	# Using a conditional for debugging purposes
	if globals.player.deck:
		# warning-ignore:return_value_discarded
		globals.player.deck.connect("card_added", self, "_update_deck_count")
		# warning-ignore:return_value_discarded
		globals.player.deck.connect("card_removed", self, "_update_deck_count")
		_update_deck_count()
	if globals.encounters:
		# warning-ignore:return_value_discarded
		globals.encounters.connect("encounter_changed", self, "_update_encounter_label")
		if globals.encounters.current_act:
			_update_encounter_label(globals.encounters.current_act.get_act_name(), globals.encounters.encounter_number)
	_update_health_label()
#	cfc.game_settings['show_artifacts'] = cfc.game_settings.get('show_artifacts', false)
#	_artifact_button.pressed = cfc.game_settings.show_artifacts
#	_on_ArtifactsShowButton_toggled(_artifact_button.pressed, false)


func _on_Settings_pressed() -> void:
	SoundManager.play_se('click')
	if context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.game_paused = true
	popup_settings = PopupPanel.new()
	self.add_child(popup_settings)
	var settings_menu = SETTINGS_SCENE.instance()
	popup_settings.add_child(settings_menu)
	yield(get_tree(), "idle_frame")
	popup_settings.popup_centered_minsize()
	settings_menu.back_button.text = "Close"
	settings_menu.back_button.connect('pressed', self, '_on_Settings_hide')
	# warning-ignore:return_value_discarded
	popup_settings.connect('popup_hide', self, '_on_Settings_hide')


func _on_Settings_hide() -> void:
	SoundManager.play_se('back')
	popup_settings.queue_free()
	if context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.game_paused = false


func _on_Deck_pressed() -> void:
	SoundManager.play_se('book_open')
	var popup_size_x = (CFConst.CARD_SIZE.x * CFConst.THUMBNAIL_SCALE * _deck_preview_grid.columns * cfc.curr_scale)\
			+ _deck_preview_grid.get("custom_constants/vseparation") * _deck_preview_grid.columns
	_deck_preview_popup.rect_size = Vector2(popup_size_x,600)
	_deck_preview_popup.popup_centered()
	populate_preview_cards()


func populate_preview_cards() -> void:
	if current_decklist_cache != globals.player.deck.list_all_cards():
		for card in _deck_preview_grid.get_children():
			card.queue_free()
		current_decklist_cache =  globals.player.deck.list_all_cards()
		for preview_card_entry in globals.player.deck.cards:
			var card_preview_container = CARD_PREVIEW_SCENE.instance()
			_deck_preview_grid.add_child(card_preview_container)
			card_preview_container.setup(preview_card_entry.instance_self(true))


func get_all_artifacts() -> Dictionary:
	var found_artifacts := {}
	for artifact in _artifacts.get_children():
		found_artifacts[artifact.canonical_name] = artifact
	return(found_artifacts)

func find_artifact(artifact_name):
	var artifact = get_all_artifacts().get(artifact_name)
	if artifact:
		return(artifact)

func get_ordered_artifacts(ordered_effects: Dictionary) -> Dictionary:
	for artifact in _artifacts.get_children():
		match artifact.priority:
			Artifact.PRIORITY.ADD:
				ordered_effects.adders.append(artifact)
			Artifact.PRIORITY.MULTIPLY:
				ordered_effects.multipliers.append(artifact)
			Artifact.PRIORITY.SET:
				ordered_effects.setters.append(artifact)
	return(ordered_effects)


func connect_dreamer_signals(dreamer: PlayerEntity) -> void:
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_damaged", self, "_on_player_health_changed")
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_healed", self, "_on_player_health_changed")
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_health_modified", self, "_on_player_health_changed")


func _on_player_health_changed(entity, _amount, _trigger, _tags) -> void:
	_update_health_label(entity.damage, entity.health)


func _update_health_label(current := globals.player.damage, total := globals.player.health) -> void:
	_player_health_label.text = str(current) + '/' + str(total)


func _update_encounter_label(act_name, encounter_number) -> void:
	_encounter_label.text = '%s, Encounter %s' % [act_name, encounter_number]


func _update_deck_count(_card = null) -> void:
	_deck_button.text = str(globals.player.deck.count_cards())


func _on_Pathos_pressed() -> void:
	SoundManager.play_se('click')
	_pathos_details.popup_centered_minsize()
	for entry in pathos_infos:
		pathos_infos[entry].update_labels()
	_pathos_details.rect_global_position =\
		_pathos_button.rect_global_position + Vector2(-_pathos_details.rect_size.x,50)


func _on_Help_pressed() -> void:
	SoundManager.play_se('click')
	if context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.game_paused = true
	_tutorial.setup(context, _help)
	_tutorial.rect_size = get_viewport().size
	_help.popup_centered_minsize()


func _on_artifact_added(artifact_object: ArtifactObject) -> void:
	var trigger_artifact := false
	# We only trigger artifacts that are added to the journal player info
	# to avoid them triggering twice
	if context == ArtifactDefinitions.EffectContext.OVERWORLD:
		trigger_artifact = true
	_instance_artifact(artifact_object, trigger_artifact)


# Instances and adds the artifact objects to this node
func _init_artifacts() -> void:
	for artifact_object in globals.player.artifacts:
		_instance_artifact(artifact_object)


func _on_memory_added(memory_object: MemoryObject) -> void:
	_instance_memory(memory_object, true)


# Instances and adds the artifact objects to this node
func _init_memories() -> void:
	for memory_object in globals.player.memories:
		_instance_memory(memory_object)


func _instance_artifact(artifact_object: ArtifactObject, new_addition := false) -> void:
	var new_artifact = artifact_object.instance_artifact()
	var artifact_active := false
	if context == artifact_object.context:
		artifact_active = true
	new_artifact.setup_artifact(artifact_object, artifact_active, new_addition)
	_artifacts.add_child(new_artifact)
	new_artifact.player_info_node = self


func _instance_memory(memory_object: MemoryObject, new_addition := false) -> void:
	var new_memory = memory_object.instance_memory()
	var memory_active := false
	if context == memory_object.context:
		memory_active = true
	new_memory.setup_artifact(memory_object, memory_active, new_addition)
	_memories.add_child(new_memory)
	new_memory.player_info_node = self


func _input(event):
	if event.is_action_pressed("help"):
		_on_Help_pressed()


# Wipes the deck cache so that the cards can be recreated in the right size
func _on_Viewport_size_changed() -> void:
	current_decklist_cache = []


func _on_ArtifactsShowButton_pressed() -> void:
	if _artifact_popup.visible:
		_artifact_popup.hide()
	else:
		_artifact_popup.popup_centered_minsize()
	SoundManager.play_se('click')
	_artifact_popup.rect_global_position =\
		_artifact_button.rect_global_position + Vector2(-50,50)


func _on_button_mouse_entered(button: Button) -> void:
	_button_description.text = button.name.capitalize()
	_button_desc_popup.visible = true
	_button_desc_popup.rect_global_position =\
		button.rect_global_position + Vector2(-_button_description.rect_size.x,0)


func _on_button_mouse_exited(_button: Button) -> void:
	_button_desc_popup.visible = false
