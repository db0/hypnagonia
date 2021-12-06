class_name SoundManagerAudioStreamPlayer
extends AudioStreamPlayer

####################################################################
#SOUNDS SCRIPT FOR THE SOUND MANAGER MODULE FOR GODOT 3
#			© Xecestel
####################################################################
#
# This Source Code Form is subject to the terms of the MIT License.
# If a copy of the license was not distributed with this
# file, You can obtain one at https://mit-license.org/.
#
#####################################

# Variables

var sound_type : String setget set_sound_type, get_sound_type
var sound_name : String setget set_sound_name, get_sound_name
var sound_path : String setget set_sound_path, get_sound_path

var tween: Tween

###########

# Signals

signal finished_playing(sound_path)

##########


func _ready():
	set_properties();


func connect_signals(connect_to : Node) -> void:
	connect("finished", self, "_on_self_finished")
	connect("finished_playing", connect_to, "_on_sound_finished");


func set_properties(volume_db : float = 0.0, pitch_scale : float = 1.0) -> void:
	set_volume_db(volume_db);
	set_pitch_scale(pitch_scale);


func set_sound_name(sname : String) -> void:
	if sname != '':
		sound_name = sname


func set_sound_type(type : String) -> void:
	sound_type = type


func set_sound_path(path : String) -> void:
	sound_path = path

func get_sound_type() -> String:
	return(sound_type)


func get_sound_name() -> String:
	return(sound_name)


func get_sound_path() -> String:
	return(sound_path)


func _on_self_finished() -> void:
	emit_signal("finished_playing", sound_path);


func fade_in(time := 10) -> void:
#	print_debug("in " + sound_path)
	if not tween:
		tween = Tween.new()
		add_child(tween)
		tween.connect("tween_all_completed", self, "_on_tween_completed")
	else:
		tween.stop_all()
	tween.interpolate_property(
			self,'volume_db', -80, volume_db,
			time, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
	
	
func fade_out(time := 4) -> void:
#	print_debug("out " + sound_path)
	if not tween:
		tween = Tween.new()
		add_child(tween)
		tween.connect("tween_all_completed", self, "_on_tween_completed")
	else:
		tween.stop_all()
	tween.interpolate_property(
			self,'volume_db', null, -80,
			time, Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()


func _on_tween_completed() -> void:
	if volume_db == -80:
		stop()
		_on_self_finished()
