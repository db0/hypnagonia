class_name Music
extends Reference

# scene should be 'board', 'journal', 'main', or 'shop'
# basically the name of a directory in "res://assets/music/"
static func prepare_background_music(scene: String) -> void:
	var dir = "res://assets/music/" + scene + '/'
	SoundManager.stop_all('BGM')
	SoundManager.clear_queue('BGM')
	var bgm_tracks = SoundManagerClass.get_sound_files_in_dir(dir)
	CFUtils.shuffle_array(bgm_tracks)
	SoundManager.queue_filelist(bgm_tracks, true)
