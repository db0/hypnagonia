class_name SoundManagerClass
extends SoundManagerModule

####################################################################
#	SOUND MANAGER MODULE FOR GODOT 3
#			Version 4.4
#			© Xecestel
####################################################################
#
# This Source Code Form is subject to the terms of the MIT License.
# If a copy of the license was not distributed with this
# file, You can obtain one at https://mit-license.org/.
#
#####################################

# Variables

export (Dictionary) var Default_Sounds_Properties = {
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

export (bool) var preload_resources = false
export (bool) var preinstantiate_nodes = false
export (bool) var debug = true

var queues := {
	"BGM" : [],
	"BGS" : [],
	"SE" : [],
	"ME" : [],
}

var Audio_Busses : Dictionary = {
	"BGM" : "Master",
	"BGS" : "Master",
	"SE" : "Master",
	"ME" : "Master",
}

var repeating_queues := {
	"BGM" : false,
	"BGS" : false,
	"SE" : false,
	"ME" : false,
}

var Preloaded_Resources : Dictionary = {}
var Instantiated_Nodes : Dictionary = {}

##################

# Methods


##################################################
#				SOUNDS HANDLING					 #
# Use this methods to handle sounds in your game #
##################################################

# Plays a given BGM
func play_bgm(bgm : String, from_position : float = 0.0, volume_db : float = -81, pitch_scale : float = -1, sound_to_override : String = "") -> void:
	if bgm != "" and bgm != null:
		play_deferred("BGM", bgm, from_position, volume_db, pitch_scale, sound_to_override)
	elif debug:
		print_debug("No sound selected.")


# Plays a given BGM
func queue_bgm(bgm : String, volume_db : float = -81, pitch_scale : float = -1) -> void:
	if bgm != "" and bgm != null:
		queue_deferred("BGM", bgm, volume_db, pitch_scale)
	elif debug:
		print_debug("No sound selected.")


# Plays a given BGS
func play_bgs(bgs : String, from_position : float = 0.0, volume_db : float = -81, pitch_scale : float = -1, sound_to_override : String = "") -> void:
	if bgs != "" and bgs != null:
		play_deferred("BGS", bgs, from_position, volume_db, pitch_scale, sound_to_override)
	elif debug:
		print_debug("No BGS selected.")


# Plays a given BGS
func queue_bgs(bgs : String, volume_db : float = -81, pitch_scale : float = -1) -> void:
	if bgs != "" and bgs != null:
		queue_deferred("BGS", bgs, volume_db, pitch_scale)
	elif debug:
		print_debug("No BGS selected.")


# Queue all files in the specified Array to be played as type
# Where type should typically be 'BGM' or 'BGS'
func queue_directory(
		path: String,
		is_looping := false,
		type:= 'BGM',
		randomize_files := false,
		volume_db : float = -81,
		pitch_scale : float = -1) -> void:
	preload_audio_files_from_path(path)
	var filelist = get_sound_files_in_dir(path)
	# This will randomize the files loaded in that directory
	# If you are using your own randomgenerator, use queue_files() instead and
	# pass it a pre-randomized list
	if randomize_files:
		randomize()
		filelist.shuffle()
	if is_looping:
		repeating_queues[type] = true
	for filename in filelist:
		queue_deferred(type, filename, volume_db, pitch_scale)


# Queues all files in the specified Array to be played as type
# Where type should typically be 'BGM' or 'BGS'
# You can use the static function SoundManagerClass.get_sound_files_in_dir(path)
# to add all sound files in a given path to a list.
func queue_filelist(
		filelist: Array,
		is_looping := false,
		type:= 'BGM',
		volume_db : float = -81,
		pitch_scale : float = -1) -> void:
	preload_resources_from_list(filelist)
	if is_looping:
		repeating_queues[type] = true
	for filename in filelist:
		queue_deferred(type, filename, volume_db, pitch_scale)


# Plays selected Sound Effect
func play_se(sound_effect : String, from_position : float = 0.0, volume_db : float = -81, pitch_scale : float = -1, sound_to_override : String = "") -> void:
	if sound_effect != "" and sound_effect != null:
		play_deferred("SE", sound_effect, from_position, volume_db, pitch_scale, sound_to_override)
	elif debug:
		print_debug("No sound effect selected.")


# Play a given Music Effect
func play_me(music_effect : String, from_position : float = 0.0, volume_db : float = -81, pitch_scale : float = -1,	 sound_to_override : String = "") -> void:
	if music_effect != "" and music_effect != null:
		play_deferred("ME", music_effect, from_position, volume_db, pitch_scale, sound_to_override)
	elif debug:
		print_debug("No sound selected.")


# Stops selected Sound
func stop(sound : String) -> void:
	var audiostream := find_audiostream(sound)
	if audiostream:
		if audiostream.playing:
			audiostream.stop()
			if not preinstantiate_nodes:
				erase_sound(sound)
			elif debug:
				print_debug("No playing sound found: " + sound)
	elif debug:
		print_debug("No sound selected")


# Stops all playing sounds of a specified type (BGM, BGS etc)
func stop_all(sound_type: String) -> void:
	var found_streams := []
	for audiostream in get_all_playing_streams():
		if audiostream.sound_type == sound_type:
			found_streams.append(audiostream.sound_name)
			audiostream.stop()
#			print_debug(audiostream.playing)
			if not preinstantiate_nodes:
				erase_sound(audiostream.sound_path)
	if debug:
		print_debug("Found %s playing audiostreams of type %s: %s"
				% [found_streams.size(), sound_type, found_streams])

# Returns true if the selected sound is playing
func is_playing(sound : String) -> bool:
	var playing : bool = false
	var audiostream = find_audiostream(sound)
	if audiostream:
		if audiostream.playing:
			playing = true
	elif debug:
		print_debug("Sound not found: " + sound)
	return(playing)


func pause(sound : String) -> void:
	set_paused(sound, true)


func unpause(sound : String) -> void:
	set_paused(sound, false)


func set_paused(sound : String, paused : bool = true) -> void:
	var audiostream := find_audiostream(sound)
	if audiostream:
		audiostream.set_stream_paused(paused)
	elif debug:
		print_debug("Sound not found: " + sound)


# Returns true if the given sound is paused
func is_paused(sound : String) -> bool:
	var audiostream := find_audiostream(sound)
	var paused : bool = false
	if audiostream:
		paused = audiostream.get_stream_paused()
	elif debug:
		print_debug("Sound not found: " + sound)
	return(paused)



#################################
#		GETTERS AND SETTERS		#
#################################

# Returns the name of the currently playing sounds
func get_playing_sounds() -> Array:
	var sounds_playing := []
	for stream in get_all_playing_streams():
		if stream.sound_name != '':
			sounds_playing.append(stream.sound_name)
		else:
			sounds_playing.append(stream.sound_path)
	return(sounds_playing)


# Sound Properties #

func set_bgm_volume_db(volume_db : float) -> void:
	set_sound_property("BGM", "Volume", volume_db)


func get_bgm_volume_db() -> float:
	return Default_Sounds_Properties["BGM"]["Volume"]


func set_bgm_pitch_scale(pitch_scale : float) -> void:
	set_sound_property("BGM", "Pitch", pitch_scale)


func get_bgm_pitch_scale() -> float:
	return Default_Sounds_Properties["BGM"]["Pitch"]


func set_bgs_volume_db(volume_db : float) -> void:
	set_sound_property("BGS", "Volume", volume_db)


func get_bgs_volume_db() -> float:
	return Default_Sounds_Properties["BGS"]["Volume"]


func set_bgs_pitch_scale(pitch_scale : float) -> void:
	set_sound_property("BGS", "Pitch", pitch_scale)


func get_bgs_pitch_scale() -> float:
	return Default_Sounds_Properties["BGS"]["Pitch"]


func set_se_volume_db(volume_db : float) -> void:
	set_sound_property("SE", "Volume", volume_db)


func get_se_volume_db() -> float:
	return Default_Sounds_Properties["SE"]["Volume"]


func set_se_pitch_scale(pitch_scale : float) -> void:
	set_sound_property("SE", "Pitch", pitch_scale)


func get_se_pitch_scale() -> float:
	return Default_Sounds_Properties["SE"]["Pitch"]


func set_me_volume_db(volume_db : float) -> void:
	set_sound_property("ME", "Volume", volume_db)


func get_me_volume_db() -> float:
	return Default_Sounds_Properties["ME"]["Volume"]


func set_me_pitch_scale(pitch_scale : float) -> void:
	set_sound_property("ME", "Pitch", pitch_scale)


func get_me_pitch_scale() -> float:
	return Default_Sounds_Properties["ME"]["Pitch"]


func set_volume_db(volume_db : float, sound : String) -> void:
	var audiostream := find_audiostream(sound)
	if audiostream:
		audiostream.set_volume_db(volume_db)
	elif debug:
		print_debug("Sound not found: " + sound)


func get_volume_db(sound : String) -> float:
	var audiostream := find_audiostream(sound)
	var volume_db : float = -81.0
	if audiostream:
		volume_db = audiostream.get_volume_db()
	elif debug:
		print_debug("Sound not found: " + sound)
	return(volume_db)


func set_pitch_scale(pitch_scale : float, sound : String = "") -> void:
	var audiostream := find_audiostream(sound)
	if audiostream:
		audiostream.set_pitch_scale(pitch_scale)
	elif debug:
		print_debug("Soud not found: " + sound)


func get_pitch_scale(sound : String = "") -> float:
	var audiostream := find_audiostream(sound)
	var pitch_scale : float = -1.0
	if audiostream:
		pitch_scale = audiostream.get_pitch_scale()
	elif debug:
		print_debug("Sound not found: " + sound)
	return(pitch_scale)


func get_default_sound_properties(sound_type : String) -> Dictionary:
	return Default_Sounds_Properties[sound_type]


func set_sound_property(sound_type : String, property : String, value : float) -> void:
	match property:
		"Volume":
			value = clamp(value, -80, 24)
		"Pitch":
			value = clamp(value, 0.01, 4)
	Default_Sounds_Properties[sound_type][property] = value


# Audio Files Dictionary #

# Returns the Audio Files Dictionary
func get_audio_files_dictionary() -> Dictionary:
	return Audio_Files_Dictionary


# Returns the file name of the given stream name
# Returns null if an error occures.
func get_config_value(stream_name : String) -> String:
	return Audio_Files_Dictionary.get(stream_name)


# Allows you to change or add a stream file and name to the dictionary in runtime
func set_config_key(new_stream_name : String, new_stream_file : String) -> void:
	if (new_stream_file == "" or new_stream_name == ""):
		if debug:
			print_debug("Invalid arguments")
		return

	add_to_dictionary(new_stream_name, new_stream_file)

	if (preload_resources):
		preload_resource_from_string(new_stream_file)


# Adds a new voice to the Audio Files Dictionary
func add_to_dictionary(audio_name : String, audio_file : String) -> void:
	Audio_Files_Dictionary[audio_name] = audio_file


# Resources preloading #

func enable_preload_resources(enabled : bool = true) -> void:
	preload_resources = enabled


func is_preload_resources_enabled() -> bool:
	return(preload_resources)



#############################
#	RESOURCE PRELOADING		#
#############################

func preload_audio_files_from_path(path : String):
	var file_name : String
	for filename in get_sound_files_in_dir(path):
		preload_resource_from_string(filename)


func preload_resources_from_list(files_list : Array) -> void:
	if (preload_resources):
		if debug:
			print_debug("Resources already preloaded.")
		return

	for file in files_list:
		if (file is String):
			preload_resource_from_string(file)
		elif (file is Resource):
			preload_resource(file)


func preload_resource(file : Resource) -> void:
	if (file == null):
		if debug:
			print_debug("Invalid resource passed")
		return

	var file_path = file.get_path()

	Preloaded_Resources[file_path] = file


func preload_resource_from_string(file : String) -> void:
	var res = null
	var file_name = file

	if is_import_file(file):
		file_name = file_name.get_basename()
	elif not is_audio_file(file):
		file_name = Audio_Files_Dictionary.get(file)
		if file_name == null:
			if debug:
				print_debug("Audio File not found in Dictionary")
			return

	res = load(file_name)
	
	if res:
		Preloaded_Resources[file_name] = res
	elif debug:
		print_debug("An error occured while preloading resource: " + file)


func unload_all_resources(force_unload : bool = false) -> void:
	if preload_resources:
		if force_unload == false:
			if debug:
				print_debug("To unload resources with Preload Resources variable on, pass force_unload argument on true")
			return
		preload_resources = false

	Preloaded_Resources.clear()


func unload_resources_from_list(files_list : Array) -> void:
	for file in files_list:
		if (file is String):
			unload_resource_from_string(file)


func unload_resource_from_string(file : String) -> void:
	var file_name = file

	if is_import_file(file):
		file_name = file_name.get_basename()
	elif not is_audio_file(file):
		file_name = Audio_Files_Dictionary.get(file)
		if file_name == null:
			if debug:
				print_debug("Audio File not found in Dictionary")
			return

	if Preloaded_Resources.has(file_name):
		Preloaded_Resources.erase(file_name)
	elif debug:
		print_debug("An error occured while unloading resource: " + file)


func unload_resources_from_dir(path : String) -> void:
	var dir = Directory.new()
	if dir.open(path + "/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if (is_audio_file(file_name)):
				unload_resource_from_string(dir.get_current_dir() + file_name)
			file_name = dir.get_next()
	elif debug:
		print_debug("An error occurred when trying to access the path: " + path)


#############################
#	NODES PREINSTANTIATION	#
#############################

func preinstantiate_nodes_from_path(path : String, sound_type : String = ""):
	var file_name : String
	var dir := Directory.new()
	dir.open(path)
	if dir:
		dir.list_dir_begin(true, true)
		file_name = dir.get_next()
		while file_name != "":
			if is_audio_file(file_name) or is_import_file(file_name):
				var file_path = dir.get_current_dir() + file_name
				preinstantiate_node_from_string(file_path, sound_type)
			file_name = dir.get_next()
	elif debug:
		print_debug("An error occurred when trying to access the path: " + path)


func preinstantiate_nodes_from_list(files_list : Array, type_list : Array, all_same_type : bool = false) -> void:
	var index = 0
	for file in files_list:
		if file is String:
			if (all_same_type == false):
				index = files_list.find(file)
			preinstantiate_node_from_string(file, type_list[index])


func preinstantiate_node_from_string(file : String, sound_type : String = "") -> void:
	var Stream = null
	var file_name = file
	var sound_index = 0

	if is_import_file(file):
		file_name = file_name.get_basename()
	elif not is_audio_file(file):
		file_name = Audio_Files_Dictionary.get(file)
		if file_name == null:
			if debug:
				print_debug("Audio File not found in Dictionary")
			return

	if Preloaded_Resources.has(file_name):
		Stream = Preloaded_Resources.get(file_name)
	else:
		Stream = load(file_name)

	if not preinstantiate_node(Stream, sound_type) and debug:
		print_debug("An error occured while creating a node from resource: " + file)


func preinstantiate_node(stream : Resource, sound_type : String = "") -> bool:
	if stream != null:
		var file_name = stream.get_path()
		if not Instantiated_Nodes.has(file_name):
			var audiostream := add_sound(file_name, sound_type, true)
			audiostream.set_stream(stream)
		elif debug:
			print_debug("Node already instantiated")
		return true

	return false


func uninstantiate_all_nodes(force_uninstantiation : bool = false) -> void:
	if preinstantiate_nodes:
		if not force_uninstantiation:
			if debug:
				print_debug("To uninstantiate resources with Preinstantiate Nodes on, pass force_uninstantiation argument on true")
			return
		preinstantiate_nodes = false

	uninstantiate_nodes_from_list(Instantiated_Nodes)


func uninstantiate_nodes_from_list(files_list : Dictionary) -> void:
	var index = 0
	for file in files_list.values():
		if (typeof(file) == TYPE_STRING):
			uninstantiate_node_from_string(file)


func uninstantiate_node_from_string(file : String) -> void:
	var file_name = file
	var sound_index = 0

	if is_import_file(file):
		file_name = file_name.get_basename()
	elif not is_audio_file(file):
		file_name = Audio_Files_Dictionary.get(file)
		if file_name == null:
			if debug:
				print_debug("Audio File not found in Dictionary")
			return

	erase_sound(file_name)


func uninstantiate_nodes_from_dir(path : String) -> void:
	var dir = Directory.new()
	if dir.open(path + "/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var sound_index = 0
		while (file_name != ""):
			if (is_audio_file(file_name)):
				uninstantiate_node_from_string(file_name)
			file_name = dir.get_next()
	elif debug:
		print_debug("An error occurred when trying to access the path: " + path)


func enable_node_preinstantiation(enabled : bool = true) -> void:
	preinstantiate_nodes = enabled


func is_preinstantiate_nodes_enabled() -> bool:
	return preinstantiate_nodes


#############################
#	INTERNAL METHODS		#
#############################

# Called when the node enters the scene for the first time
func _ready() -> void:
	if(ProjectSettings.get_setting("editor_plugins/enabled") and
	Array(ProjectSettings.get_setting("editor_plugins/enabled")).has("res://addons/sound_manager/plugin.cfg")):
			get_sound_manager_settings()
	if debug:
		print_debug("Sound Manager in debug mode")

	if preload_resources and Preloaded_Resources.empty():
		if debug:
			print_debug("Preloading...")
		preload_audio_files()
	if preinstantiate_nodes:
		if debug:
			print_debug("Instantiating nodes...")
		preinstantiate_nodes()


# Load the Sound Manager settings from the JSON file:  SoundManager.json
func get_sound_manager_settings()-> void:
	var data_settings : Dictionary
	var file: File = File.new()
	file.open("res://addons/sound_manager/SoundManager.json", File.READ)
	var json : JSONParseResult = JSON.parse(file.get_as_text())
	file.close()
	if typeof(json.result) == TYPE_DICTIONARY:
		data_settings = json.result

		Default_Sounds_Properties = data_settings["DEFAULT_SOUNDS_PROPERTIES"]
		Audio_Busses = data_settings["Audio_Busses"]
		Audio_Files_Dictionary = data_settings["Audio_Files_Dictionary"]
		preload_resources = data_settings["PRELOAD_RES"]
		preinstantiate_nodes = data_settings["PREINSTANTIATE_NODES"]
		debug = data_settings["DEBUG"]

	elif debug:
		print_debug("Failed to load the sound manager's settings file: " + 'res://addons/sound_manager/SoundManager.json')


# Calls the play method as deferred
func play_deferred(sound_type : String, sound : String, from_position : float = 1.0, volume_db : float = -81, pitch_scale : float = -1, sound_to_override : String = "") -> void:
	call_deferred("play", sound_type, sound, from_position, volume_db, pitch_scale, sound_to_override)

# Calls the queue method as deferred
func queue_deferred(sound_type : String, sound : String, volume_db : float = -81, pitch_scale : float = -1) -> void:
	call_deferred("queue_sound", sound_type, sound, volume_db, pitch_scale)


# Plays the selected sound
func prepare_sound(sound_type : String, sound : String, volume_db : float = -81, pitch_scale : float = -1, sound_to_override : String = "") -> AudioStreamPlayer:
	var sound_path : String
	var volume = Default_Sounds_Properties[sound_type]["Volume"] if volume_db < -80 else volume_db
	var pitch = Default_Sounds_Properties[sound_type]["Pitch"] if pitch_scale < 0 else pitch_scale
	var audiostream : SoundManagerAudioStreamPlayer

	if Audio_Files_Dictionary.has(sound):
		if debug:
			print_debug("Sound found on dictionary: " + sound)
		sound_path = Audio_Files_Dictionary.get(sound)
	elif sound.is_abs_path() and is_audio_file(sound.get_file()):
		sound_path = sound
	else:
		if debug:
			print_debug("Error: file not found " + sound)
		return(audiostream)
	if Instantiated_Nodes.has(sound_path):
		audiostream = Instantiated_Nodes[sound_path]
		if audiostream.get_bus() != Audio_Busses[sound_type]:
			audiostream.set_bus(Audio_Busses[sound_type])
		if debug:
			print_debug("Node preinstantiated " + sound_path)
	else:
		if sound_to_override != "":
			if is_playing(sound):
				return(audiostream)

		var Stream
		if Preloaded_Resources.has(sound_path):
			if debug:
				 print_debug("Resource preloaded " + sound_path)
			Stream = Preloaded_Resources.get(sound_path)
		else:
			Stream = load(sound_path)

			if Stream == null:
				if debug:
					print_debug("Failed to load file from path: " + sound_path)
				return(audiostream)

		if sound_to_override != "":
			audiostream = find_audiostream(sound_to_override)
			if not audiostream:
				if debug:
					print_debug("Sound not found: " + sound_to_override)
				return(audiostream)
		else:
			audiostream = add_sound(sound_path, sound_type)
		audiostream.set_stream(Stream)
	audiostream.set_volume_db(volume)
	audiostream.set_pitch_scale(pitch)
	if audiostream and audiostream.sound_name  == '':
		audiostream.sound_name = get_sound_name_from_path(audiostream.sound_path)
	return(audiostream)


func play(sound_type : String, sound : String, from_position : float = 1.0, volume_db : float = -81, pitch_scale : float = -1, sound_to_override : String = "") -> void:
	var audiostream := prepare_sound(sound_type, sound, volume_db, pitch_scale, sound_to_override)
	if not audiostream:
		return
	audiostream.play(from_position)


func queue_sound(sound_type : String, sound : String, volume_db : float = -81, pitch_scale : float = -1) -> void:
	var audiostream := prepare_sound(sound_type, sound, volume_db, pitch_scale)
	if not audiostream:
		return
	queues[sound_type].append(audiostream)
	if not sound_type in _get_all_playing_types():
		play_next_in_queue(sound_type)


func play_next_in_queue(sound_type: String) -> void:
	var audiostream: SoundManagerAudioStreamPlayer = queues[sound_type].pop_front()
	if repeating_queues.get(sound_type):
		queues[sound_type].append(audiostream)
	audiostream.play()


# Adds a new AudioStreamPlayer
func add_sound(sound_path : String, sound_type : String, preinstance : bool = false) -> SoundManagerAudioStreamPlayer:
	var new_audiostream = SoundManagerAudioStreamPlayer.new()
	var bus : String

	if sound_type == "":
		bus = "Master"
	else:
		bus = Audio_Busses[sound_type]

	add_child(new_audiostream)
	if not preinstance:
		new_audiostream.sound_path = sound_path
		new_audiostream.sound_type = sound_type
		new_audiostream.sound_name = get_sound_name_from_path(sound_path)
		new_audiostream.connect_signals(self)
	new_audiostream.set_bus(bus)
	if not Instantiated_Nodes.has(sound_path):
		Instantiated_Nodes[sound_path] = new_audiostream

	if debug:
		print_debug("Added %s as %s" % [sound_path, sound_type])
	return(new_audiostream)


func erase_sound(sound : String) -> void:
	var audiostream := find_audiostream(sound)
	if queues[audiostream.sound_type].has(audiostream)\
			or repeating_queues.get(audiostream.sound_type):
		if debug:
			print_debug("Sound ended but not deleted as it's queued again: " + sound)
		return
	if audiostream:
		Instantiated_Nodes.erase(sound)
		audiostream.queue_free()
	elif debug:
		print_debug("Sound not found: " + sound)


func _on_sound_finished(sound_path : String) -> void:
	if not preinstantiate_nodes:
		erase_sound(sound_path)
	var audiostream := find_audiostream(sound_path)
	if queues[audiostream.sound_type].size() > 0:
		play_next_in_queue(audiostream.sound_type)


func preload_audio_files() -> void:
	var directory := Directory.new()
	directory.open("res://")
	preload_audio_files_from_path("res://")
	preload_audio_files_r(directory)


func preload_audio_files_r(directory : Directory):
	if directory == null:
		return
	directory.list_dir_begin(true, true)
	var dir_name = directory.get_next()
	while dir_name != "":
		if directory.current_is_dir():
			if dir_name != "addons":
				var dir_path = directory.get_current_dir() + dir_name
				preload_audio_files_from_path(dir_path)
		dir_name = directory.get_next()


func preinstantiate_nodes() -> void:
	var directory := Directory.new()
	directory.open("res://")
	enable_node_preinstantiation(true)
	preinstantiate_nodes_from_path("res://")
	preinstatiate_nodes_r(directory)


func preinstatiate_nodes_r(directory : Directory):
	if directory == null:
		return
	directory.list_dir_begin(true, true)
	var dir_name = directory.get_next()
	while dir_name != "":
		if directory.current_is_dir():
			if dir_name != "addons":
				var dir_path = directory.get_current_dir() + dir_name
				preinstantiate_nodes_from_path(dir_path)
		dir_name = directory.get_next()


# Finds the SoundManagerAudioStreamPlayer node based on sound_name or sound_path
func find_audiostream(identifier: String) -> SoundManagerAudioStreamPlayer:
	var audiostream : SoundManagerAudioStreamPlayer
	for c in get_children():
		audiostream = c
		if identifier in [audiostream.sound_name, audiostream.sound_path]:
			break
	return(audiostream)


# Returns an Array of SoundManagerAudioStreamPlayer which are currently playing sounds.
func get_all_playing_streams() -> Array:
	var playing_streams := []
	for c in get_children():
		var audiostream : SoundManagerAudioStreamPlayer = c
		if audiostream.playing:
			playing_streams.append(audiostream)
	return(playing_streams)


# Looks in Audio_Files_Dictionary and finds the key which matches the specified type
# If key is not found, returns ''
func get_sound_name_from_path(sound_path: String) -> String:
	for sound_name in Audio_Files_Dictionary:
		if sound_path == Audio_Files_Dictionary[sound_name]:
			return(sound_name)
	return('')


# Toggles a queue to start/stop repeating all sounds within
func toggle_queue_repeat(type: String) -> void:
	if repeating_queues.has(type):
		repeating_queues[type] = !repeating_queues[type]


# Empties the specified sound_type queue
func clear_queue(sound_type: String) -> void:
	queues[sound_type].clear()


func _get_all_playing_types() -> Array:
	var types := []
	for audiosteam in get_all_playing_streams():
		if not audiosteam.sound_type in types:
			types.append(audiosteam.sound_type)
	return(types)


static func is_audio_file(file_name : String) -> bool:
	return	(file_name.get_extension() == "wav" or
			file_name.get_extension() == "ogg" or
			file_name.get_extension() == "mp3" or
			file_name.get_extension() == "opus")


static func is_import_file(file_name : String) -> bool:
	return (file_name.get_extension() == "import" and
			is_audio_file(file_name.get_basename()))


static func get_sound_files_in_dir(path: String) -> Array:
	var found_files := []
	var dir := Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	if dir:
		var file_name: String = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".import") and is_audio_file(file_name.rstrip(".import")):
				var file_path = dir.get_current_dir() + '/' + file_name.rstrip(".import")
				found_files.append(file_path)
			file_name = dir.get_next()
	else:
		print_debug("Error: Cannot read dir at " + path)
	return(found_files)


