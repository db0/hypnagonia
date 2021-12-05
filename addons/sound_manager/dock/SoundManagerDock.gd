tool
extends ScrollContainer

# Variables

# Sound properties configuration section
onready var bgm_properties_panel = self.get_node("VBoxContainer/BGMPropertiesPanel")
onready var bgm_properties_checkbox = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMPropertiesCheck/CheckBox")
onready var bgm_volume_panel = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMVolume")
onready var bgm_pitch_panel = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMPitch")
onready var bgm_volume_value = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMVolume/Value")
onready var bgm_pitch_value = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMPitch/Value")
onready var bgm_volume_line_edit = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMVolume/LineEdit")
onready var bgm_pitch_line_edit = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMPitch/LineEdit")
onready var bgm_volume_restore_button = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMVolume/ToolButton")
onready var bgm_pitch_restore_button = self.get_node("VBoxContainer/BGMPropertiesPanel/BGMPitch/ToolButton")
onready var bgs_properties_panel = self.get_node("VBoxContainer/BGSPropertiesPanel")
onready var bgs_properties_checkbox = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSPropertiesCheck/CheckBox")
onready var bgs_volume_panel = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSVolume")
onready var bgs_pitch_panel = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSPitch")
onready var bgs_volume_value = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSVolume/Value")
onready var bgs_pitch_value = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSPitch/Value")
onready var bgs_volume_line_edit = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSVolume/LineEdit")
onready var bgs_pitch_line_edit = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSPitch/LineEdit")
onready var bgs_volume_restore_button = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSVolume/ToolButton")
onready var bgs_pitch_restore_button = self.get_node("VBoxContainer/BGSPropertiesPanel/BGSPitch/ToolButton")
onready var se_properties_panel = self.get_node("VBoxContainer/SEPropertiesPanel")
onready var se_properties_checkbox = self.get_node("VBoxContainer/SEPropertiesPanel/SEPropertiesCheck/CheckBox")
onready var se_volume_panel = self.get_node("VBoxContainer/SEPropertiesPanel/SEVolume")
onready var se_pitch_panel = self.get_node("VBoxContainer/SEPropertiesPanel/SEPitch")
onready var se_volume_value = self.get_node("VBoxContainer/SEPropertiesPanel/SEVolume/Value")
onready var se_pitch_value = self.get_node("VBoxContainer/SEPropertiesPanel/SEPitch/Value")
onready var se_volume_line_edit = self.get_node("VBoxContainer/SEPropertiesPanel/SEVolume/LineEdit")
onready var se_pitch_line_edit = self.get_node("VBoxContainer/SEPropertiesPanel/SEPitch/LineEdit")
onready var se_volume_restore_button = self.get_node("VBoxContainer/SEPropertiesPanel/SEVolume/ToolButton")
onready var se_pitch_restore_button = self.get_node("VBoxContainer/SEPropertiesPanel/SEPitch/ToolButton")
onready var me_properties_panel = self.get_node("VBoxContainer/MEPropertiesPanel")
onready var me_properties_checkbox = self.get_node("VBoxContainer/MEPropertiesPanel/MEPropertiesCheck/CheckBox")
onready var me_volume_panel = self.get_node("VBoxContainer/MEPropertiesPanel/MEVolume")
onready var me_pitch_panel = self.get_node("VBoxContainer/MEPropertiesPanel/MEPitch")
onready var me_volume_value = self.get_node("VBoxContainer/MEPropertiesPanel/MEVolume/Value")
onready var me_pitch_value = self.get_node("VBoxContainer/MEPropertiesPanel/MEPitch/Value")
onready var me_volume_line_edit = self.get_node("VBoxContainer/MEPropertiesPanel/MEVolume/LineEdit")
onready var me_pitch_line_edit = self.get_node("VBoxContainer/MEPropertiesPanel/MEPitch/LineEdit")
onready var me_volume_restore_button = self.get_node("VBoxContainer/MEPropertiesPanel/MEVolume/ToolButton")
onready var me_pitch_restore_button = self.get_node("VBoxContainer/MEPropertiesPanel/MEPitch/ToolButton")

# Audiobuses configuration
onready var bgm_bus_field = get_node("VBoxContainer/BGMBusPanel/NameField")
onready var bgs_bus_field = get_node("VBoxContainer/BGSBusPanel/NameField")
onready var se_bus_field = get_node("VBoxContainer/SEBusPanel/NameField")
onready var me_bus_field = get_node("VBoxContainer/MEBusPanel/NameField")

# Audio File Panel Toggles
onready var audio_files_panel = get_node("VBoxContainer/AudioFilesPanel")
onready var toggle_audio_files_button = get_node("VBoxContainer/ToggleFilesPanelButton")

# File list section
onready var file_list = get_node("VBoxContainer/AudioFilesPanel/ScrollContainer/Files")

# Dictionary section
onready var dictionary_panel = get_node("VBoxContainer/DictionaryContainer/DictionaryPanel")

# Advanced options section
onready var advanced_panel = get_node("VBoxContainer/AdvancedOptions/AdvancedPanel")
onready var advanced_button = get_node("VBoxContainer/AdvancedOptions/AdvancedPanel/AdvancedButton")
onready var preload_panel = get_node("VBoxContainer/AdvancedOptions/PreloadPanel")
onready var preload_button = get_node("VBoxContainer/AdvancedOptions/PreloadPanel/PreloadButton")
onready var preinstantiate_panel = get_node("VBoxContainer/AdvancedOptions/PreinstantiatePanel")
onready var preinstantiate_button = get_node("VBoxContainer/AdvancedOptions/PreinstantiatePanel/PreinstantiateButton")
onready var debug_panel = get_node("VBoxContainer/AdvancedOptions/DebugPanel")
onready var debug_button = get_node("VBoxContainer/AdvancedOptions/DebugPanel/DebugButton")

# Internal variables
var TITLE : String = "SoundManager"
var DEFAULT_SOUNDS_PROPERTIES : Dictionary = {
	"BGM" : {
		"Volume" : 0,
		"Pitch" : 1,
	},
	"BGS" : {
		"Volume" : 0,
		"Pitch" : 1,
	},
	"SE" : {
		"Volume" : 0,
		"Pitch" : 1,
	},
	"ME" : {
		"Volume" : 0,
		"Pitch" : 1,
	},
}

var Audio_Busses : Dictionary = {
	"BGM" : "",
	"BGS" : "",
	"SE" : "",
	"ME" : "",
}
var PRELOAD_RES : bool = false
var PREINSTANTIATE_NODES : bool = false
var DEBUG : bool = false
var Audio_Files_Dictionary : Dictionary = {}
var file : File = File.new()
var data_settings : Dictionary

#####################

# Signals

signal check_file_names_requested()

#####################

# Methods

func _ready() -> void:
	#self.rect_size.x = get_node("VBoxContainer/ScrollContainer").rect_size.x + 25
	var json_exists = read_sound_manager_settings()
	if json_exists:
		update_sound_manager_settings()
	connect_signals()


func connect_signals() -> void:
	# Properties section
	bgm_properties_checkbox.connect("toggled", self, "_on_bgm_checkbox_toggled")
	bgs_properties_checkbox.connect("toggled", self, "_on_bgs_checkbox_toggled")
	se_properties_checkbox.connect("toggled", self, "_on_se_checkbox_toggled")
	me_properties_checkbox.connect("toggled", self, "_on_me_checkbox_toggled")
	bgm_volume_value.connect("value_changed", self, "_on_bgm_volume_value_changed")
	bgm_pitch_value.connect("value_changed", self, "_on_bgm_pitch_value_changed")
	bgm_volume_line_edit.connect("text_entered", self, "_on_bgm_volume_text_entered")
	bgm_pitch_line_edit.connect("text_entered", self, "_on_bgm_pitch_text_entered")
	bgm_volume_restore_button.connect("pressed", self, "_on_bgm_volume_restore_button_pressed")
	bgm_pitch_restore_button.connect("pressed", self, "_on_bgm_pitch_restore_button_pressed")
	bgs_volume_value.connect("value_changed", self, "_on_bgs_volume_value_changed")
	bgs_pitch_value.connect("value_changed", self, "_on_bgs_pitch_value_changed")
	bgs_volume_line_edit.connect("text_entered", self, "_on_bgs_volume_text_entered")
	bgs_pitch_line_edit.connect("text_entered", self, "_on_bgs_pitch_text_entered")
	bgs_volume_restore_button.connect("pressed", self, "_on_bgs_volume_restore_button_pressed")
	bgs_pitch_restore_button.connect("pressed", self, "_on_bgs_pitch_restore_button_pressed")
	se_volume_value.connect("value_changed", self, "_on_se_volume_value_changed")
	se_pitch_value.connect("value_changed", self, "_on_se_pitch_value_changed")
	se_volume_line_edit.connect("text_entered", self, "_on_se_volume_text_entered")
	se_pitch_line_edit.connect("text_entered", self, "_on_se_pitch_text_entered")
	se_volume_restore_button.connect("pressed", self, "_on_se_volume_restore_button_pressed")
	se_pitch_restore_button.connect("pressed", self, "_on_se_pitch_restore_button_pressed")
	me_volume_value.connect("value_changed", self, "_on_me_volume_value_changed")
	me_pitch_value.connect("value_changed", self, "_on_me_pitch_value_changed")
	me_volume_line_edit.connect("text_entered", self, "_on_me_volume_text_entered")
	me_pitch_line_edit.connect("text_entered", self, "_on_me_pitch_text_entered")
	me_volume_restore_button.connect("pressed", self, "_on_me_volume_restore_button_pressed")
	me_pitch_restore_button.connect("pressed", self, "_on_me_pitch_restore_button_pressed")
	
	# Bus fields
	bgm_bus_field.connect("text_entered", self, "_on_bgm_bus_entered")
	bgs_bus_field.connect("text_entered", self, "_on_bgs_bus_entered")
	se_bus_field.connect("text_entered", self, "_on_se_bus_entered")
	me_bus_field.connect("text_entered", self, "_on_me_bus_entered")
	
	# Audio files Panel
	toggle_audio_files_button.connect("pressed", self, "_on_toggle_audio_files_pressed" )

	# Advanced
	advanced_button.connect("toggled", self, "_on_advanced_button_toggled");
	preload_button.connect("toggled", self, "_on_preload_button_toggled");
	preinstantiate_button.connect("toggled", self, "_on_preinstantiate_button_toggled");
	debug_button.connect("toggled", self, "_on_debug_button_toggled")


func parse_json_string(json_file: String) -> Dictionary:
	var result: Dictionary = {}
	var json: JSONParseResult = JSON.parse(json_file)
	if typeof(json.result) == TYPE_DICTIONARY:
		result = json.result
	else:
		print_debug("Error to parse the JSON file")
	return result


func read_sound_manager_settings() -> bool:
	if not file.file_exists("res://addons/sound_manager/SoundManager.json"):
		return false
	
	file.open("res://addons/sound_manager/SoundManager.json", File.READ)
	data_settings = parse_json_string(file.get_as_text())
	file.close()
	
	# Set the variables
	for setting in data_settings.keys():
		self.set(setting, data_settings[setting])
	
	# Updates buttons
	advanced_button.set_pressed(PRELOAD_RES or PREINSTANTIATE_NODES)
	preload_button.set_pressed(PRELOAD_RES)
	preinstantiate_button.set_pressed(PREINSTANTIATE_NODES)
	debug_button.set_pressed(DEBUG)
	self._on_advanced_button_toggled(PRELOAD_RES or PREINSTANTIATE_NODES)
	self._on_preload_button_toggled(PRELOAD_RES)
	self._on_preinstantiate_button_toggled(PREINSTANTIATE_NODES)
	self.update_gui()
	return true


func update_sound_manager_settings() -> void:
	data_settings["DEFAULT_SOUNDS_PROPERTIES"] = DEFAULT_SOUNDS_PROPERTIES
	data_settings["Audio_Busses"] = Audio_Busses
	data_settings["Audio_Files_Dictionary"] = Audio_Files_Dictionary
	data_settings["PRELOAD_RES"] = PRELOAD_RES
	data_settings["PREINSTANTIATE_NODES"] = PREINSTANTIATE_NODES
	data_settings["DEBUG"] = DEBUG
	file.open("res://addons/sound_manager/SoundManager.json", File.WRITE)
	file.store_string(JSON.print(data_settings, "", true))
	file.close()
	self.update_gui()


# Update GUI
func update_gui() -> void:
	bgm_volume_value.set_value(DEFAULT_SOUNDS_PROPERTIES["BGM"]["Volume"])
	bgm_pitch_value.set_value(DEFAULT_SOUNDS_PROPERTIES["BGM"]["Pitch"])
	bgm_volume_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["BGM"]["Volume"]))
	bgm_pitch_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["BGM"]["Pitch"]))
	bgs_volume_value.set_value(DEFAULT_SOUNDS_PROPERTIES["BGS"]["Volume"])
	bgs_pitch_value.set_value(DEFAULT_SOUNDS_PROPERTIES["BGS"]["Pitch"])
	bgs_volume_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["BGS"]["Volume"]))
	bgs_pitch_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["BGS"]["Pitch"]))
	se_volume_value.set_value(DEFAULT_SOUNDS_PROPERTIES["SE"]["Volume"])
	se_pitch_value.set_value(DEFAULT_SOUNDS_PROPERTIES["SE"]["Pitch"])
	se_volume_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["SE"]["Volume"]))
	se_pitch_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["SE"]["Pitch"]))
	me_volume_value.set_value(DEFAULT_SOUNDS_PROPERTIES["ME"]["Volume"])
	me_pitch_value.set_value(DEFAULT_SOUNDS_PROPERTIES["ME"]["Pitch"])
	me_volume_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["ME"]["Volume"]))
	me_pitch_line_edit.set_text(str(DEFAULT_SOUNDS_PROPERTIES["ME"]["Pitch"]))
	bgm_bus_field.set_text(Audio_Busses["BGM"])
	bgs_bus_field.set_text(Audio_Busses["BGS"])
	se_bus_field.set_text(Audio_Busses["SE"])
	me_bus_field.set_text(Audio_Busses["ME"])
	populate_dictionary_panel()
	emit_signal("check_file_names_requested")


func change_property(value : float, sound_type : String, property : String) -> void:
	match property:
		"Volume":
			value = clamp(value, -80, 24)
		"Pitch":
			value = clamp(value, 0.01, 4)
	DEFAULT_SOUNDS_PROPERTIES[sound_type][property] = value
	update_sound_manager_settings()


#############################
#	FILES LIST HANDLING		#
#############################

func populate_files_list(file_names : PoolStringArray)->void:
	# Clean the files list
	while file_list.get_child_count() > 0:
		var child_node = file_list.get_child(0)
		file_list.remove_child(child_node)
		child_node.queue_free()
		
	# Populate the files list
	for i in range(0, file_names.size()):
		var file_extension = file_names[i].get_extension();
		if (file_extension == "wav" or
				file_extension == "ogg" or
				file_extension == "mp3" or
				file_extension == "opus"):
			
			# Set the nodes
			var file_name_container : HBoxContainer = HBoxContainer.new()
			var add_entry_button : ToolButton = ToolButton.new()
			var add_icon : Texture
			var dir_line : Label = Label.new()
			var file_line : Label = Label.new()
			add_icon = load("res://addons/sound_manager/dock/assets/add_icon.svg") as Texture
			file_name_container.set_alignment(BoxContainer.ALIGN_CENTER)
			dir_line.set_custom_minimum_size(Vector2(60, 0))
			file_line.set_custom_minimum_size(Vector2(80, 0))
			dir_line.set_text(file_names[i].get_base_dir())
			if dir_line.get_text() != "res://":
				dir_line.text = dir_line.text + "/"
			file_line.set_name("File_" + str(i))
			file_line.set_text(file_names[i].get_file())
			dir_line.set("custom_colors/font_color", Color(1, 1, 1))
			file_line.set("custom_colors/font_color", Color(1, 1, 1))
			add_entry_button.set_button_icon(add_icon)
			add_entry_button.set_tooltip("Add a new entry in the dictionary for this sound file")
			
			# Add the nodes into the dock scene
			file_name_container.add_child(dir_line)
			file_name_container.add_child(file_line)
			file_name_container.add_child(add_entry_button)
			file_list.add_child(file_name_container)
			
			# Make the signal connections
			add_entry_button.connect("pressed", self, "_on_add_entry_button_pressed", [dir_line.get_text() + file_line.get_text()])


func insert_new_entry(key: String = "", value: String = ""):
	var entry_container: HBoxContainer = HBoxContainer.new()
	var key_input : LineEdit = LineEdit.new()
	var value_input : LineEdit = LineEdit.new()
	var remove_entry_button : ToolButton = ToolButton.new()
	var save_entry_button : ToolButton = ToolButton.new()
	
	# Load the icon image for the quit entry button
	var remove_entry_icon : Texture
	remove_entry_icon = load("res://addons/sound_manager/dock/assets/remove_icon.svg") as Texture
	
	# Load the icon image for the save entry button
	var save_entry_icon : Texture
	save_entry_icon = load("res://addons/sound_manager/dock/assets/save_icon.svg") as Texture
	
	# Set the new nodes
	# Container
	entry_container.set_alignment(BoxContainer.ALIGN_CENTER)
	entry_container.set_name("Entry_" + str((dictionary_panel.get_child_count() + 1)))
	
	# Key UI
	key_input.set_text(key)
	key_input.set_placeholder("Sound name")
	key_input.set_custom_minimum_size(Vector2(120,0))
	key_input.set_max_length(280)
	key_input.set_tooltip("Insert here a key for this sound file")
#	
	# Value UI
	value_input.set_text(value)
	value_input.set_placeholder("sound_file_name.extension")
	value_input.set_custom_minimum_size(Vector2(160,0))
	value_input.set_max_length(280)
	value_input.set_tooltip("Insert here the name of a sound file (name_file.extension)")
	save_entry_button.set_button_icon(save_entry_icon)
	save_entry_button.set_tooltip("Save this entry")
	remove_entry_button.set_button_icon(remove_entry_icon)
	remove_entry_button.set_tooltip("Remove this entry")
	
	# Insert the new nodes into the scene
	entry_container.add_child(key_input)
	entry_container.add_child(value_input)
	entry_container.add_child(save_entry_button)
	entry_container.add_child(remove_entry_button)
	dictionary_panel.add_child(entry_container)
	
	# Make the signal connections
	key_input.connect("text_entered", self, "_on_key_input_entered", [value_input.text])
	value_input.connect("text_entered", self, "_on_value_input_entered",[key_input.text])
	save_entry_button.connect("pressed", self, "_on_save_entry_button_pressed", [save_entry_button.get_parent().get_index()])
	remove_entry_button.connect("pressed", self, "_on_remove_entry_button_pressed", [entry_container.name, key_input.text])


func populate_dictionary_panel():
	if not Audio_Files_Dictionary.empty():
		
		# Clean the dictionary panel
		while dictionary_panel.get_child_count() > 0:
			var child_node = dictionary_panel.get_child(0)
			dictionary_panel.remove_child(child_node)
			child_node.queue_free()
		
		# Populate the dictionary
		for key in Audio_Files_Dictionary.keys():
			var value: String = Audio_Files_Dictionary[key]
			insert_new_entry(key, value)


func add_entry(key : String, value : String) -> void:
	if key != "" and value != "":
		var index = Audio_Files_Dictionary.values().find(value)
		if index >= 0:
			var old_key = Audio_Files_Dictionary.keys()[index]
			Audio_Files_Dictionary.erase(old_key)
		Audio_Files_Dictionary[key] = value
		update_sound_manager_settings()

#############################
#	UI SIGNALS HANDLERS		#
#############################

func _on_bgm_checkbox_toggled(button_pressed : bool) -> void:
	bgm_volume_panel.set_visible(button_pressed)
	bgm_pitch_panel.set_visible(button_pressed)


func _on_bgm_volume_value_changed(value : float) -> void:
	change_property(value, "BGM", "Volume")


func _on_bgm_pitch_value_changed(value : float) -> void:
	change_property(value, "BGM", "Pitch")


func _on_bgm_volume_text_entered(new_text : String) -> void:
	change_property(float(new_text), "BGM", "Volume")


func _on_bgm_pitch_text_entered(new_text : String) -> void:
	change_property(float(new_text), "BGM", "Pitch")


func _on_bgm_volume_restore_button_pressed() -> void:
	change_property(0, "BGM", "Volume")


func _on_bgm_pitch_restore_button_pressed() -> void:
	change_property(1, "BGM", "Pitch")


func _on_bgs_checkbox_toggled(button_pressed : bool) -> void:
	bgs_volume_panel.set_visible(button_pressed)
	bgs_pitch_panel.set_visible(button_pressed)


func _on_bgs_volume_value_changed(value : float) -> void:
	change_property(value, "BGS", "Volume")


func _on_bgs_pitch_value_changed(value : float) -> void:
	change_property(value, "BGS", "Pitch")


func _on_bgs_volume_text_entered(new_text : String) -> void:
	change_property(float(new_text), "BGS", "Volume")


func _on_bgs_pitch_text_entered(new_text : String) -> void:
	change_property(float(new_text), "BGS", "Pitch")


func _on_bgs_volume_restore_button_pressed() -> void:
	change_property(0, "BGS", "Volume")


func _on_bgs_pitch_restore_button_pressed() -> void:
	change_property(1, "BGS", "Pitch")


func _on_se_checkbox_toggled(button_pressed : bool) -> void:
	se_volume_panel.set_visible(button_pressed)
	se_pitch_panel.set_visible(button_pressed)


func _on_se_volume_value_changed(value : float) -> void:
	change_property(value, "SE", "Volume")


func _on_se_pitch_value_changed(value : float) -> void:
	change_property(value, "SE", "Pitch")


func _on_se_volume_text_entered(new_text : String) -> void:
	change_property(float(new_text), "SE", "Volume")


func _on_se_pitch_text_entered(new_text : String) -> void:
	change_property(float(new_text), "SE", "Pitch")


func _on_se_volume_restore_button_pressed() -> void:
	change_property(0, "SE", "Volume")


func _on_se_pitch_restore_button_pressed() -> void:
	change_property(1, "SE", "Pitch")


func _on_me_checkbox_toggled(button_pressed : bool) -> void:
	me_volume_panel.set_visible(button_pressed)
	me_pitch_panel.set_visible(button_pressed)


func _on_me_volume_value_changed(value : float) -> void:
	change_property(value, "ME", "Volume")


func _on_me_pitch_value_changed(value : float) -> void:
	change_property(value, "ME", "Pitch")


func _on_me_volume_text_entered(new_text : String) -> void:
	change_property(float(new_text), "ME", "Volume")


func _on_me_pitch_text_entered(new_text : String) -> void:
	change_property(float(new_text), "ME", "Pitch")


func _on_me_volume_restore_button_pressed() -> void:
	change_property(0, "ME", "Volume")


func _on_me_pitch_restore_button_pressed() -> void:
	change_property(1, "ME", "Pitch")


func _on_bgm_bus_entered(bus : String) -> void:
	self.set_bus(bus, "BGM")


func _on_bgs_bus_entered(bus : String) -> void:
	self.set_bus(bus, "BGS")


func _on_se_bus_entered(bus : String) -> void:
	self.set_bus(bus, "SE")


func _on_me_bus_entered(bus : String) -> void:
	self.set_bus(bus, "ME")


func set_bus(bus : String, sound_type : String) -> void:
	Audio_Busses[sound_type] = bus if (AudioServer.get_bus_index(bus) >= 0) else "Master"
	update_sound_manager_settings()


# Insert a new entry from the dictionary section
func _on_add_entry_button_pressed(file_path : String = "")->void:
	var key = "Sound_" + str(Audio_Files_Dictionary.keys().size())
	add_entry(key, file_path)

# Toggles the hidden panel for managing audio files
func _on_toggle_audio_files_pressed() -> void:
	audio_files_panel.visible = !audio_files_panel.visible


func _on_save_entry_button_pressed(index : int) -> void:
	var container = dictionary_panel.get_child(index)
	var key = container.get_child(0).get_text()
	var value = container.get_child(1).get_text()
	add_entry(key, value)


# Remove an entry from the dictionary
func _on_remove_entry_button_pressed(node_name : String, key : String) -> void:
	var child_node: Node = dictionary_panel.get_node(node_name)
	if child_node is Node:
		dictionary_panel.remove_child(child_node)
		child_node.queue_free()
	Audio_Files_Dictionary.erase(key)
	update_sound_manager_settings()


func _on_key_input_entered(new_key : String, new_value : String) -> void:
	add_entry(new_key, new_value)


func _on_value_input_entered(new_value : String, new_key : String) -> void:
	add_entry(new_key, new_value)


func _on_advanced_button_toggled(toggled : bool) -> void:
	preload_panel.set_visible(toggled)
	preinstantiate_panel.set_visible(toggled)
	debug_panel.set_visible(toggled)


func _on_preload_button_toggled(toggled : bool) -> void:
	PRELOAD_RES = toggled
	update_sound_manager_settings()


func _on_preinstantiate_button_toggled(toggled : bool) -> void:
	PREINSTANTIATE_NODES = toggled
	update_sound_manager_settings()


func _on_debug_button_toggled(toggled : bool) -> void:
	DEBUG = toggled
	update_sound_manager_settings()


#################################
#	PLUGIN - DOCK COMMUNICATION	#
#################################

func _on_file_names_updated(file_names : PoolStringArray) -> void:
	populate_files_list(file_names)


func _on_plugin_signals_connected() -> void:
	if file_list.get_child_count() == 0:
		emit_signal("check_file_names_requested")
