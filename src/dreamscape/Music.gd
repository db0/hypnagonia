class_name Music
extends Reference

var current_scene: String

func switch_scene_music(scene: String) -> void:
	if current_scene != scene:
		current_scene = scene
		prepare_background_music(scene)

# scene should be 'ordeal', "boss", 'journal', 'main', or 'shop'
# basically the name of a directory in "res://assets/music/"
static func prepare_background_music(scene: String) -> void:
	var dir = "res://assets/music/" + scene + '/'
	SoundManager.clear_queue('BGM')
	var bgm_tracks = SoundManagerClass.get_sound_files_in_dir(dir)
	CFUtils.shuffle_array(bgm_tracks)
	SoundManager.queue_filelist(bgm_tracks, true, cfc.game_settings.interrupt_music)
