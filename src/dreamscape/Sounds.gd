class_name Sounds
extends Reference

static func get_card_play_sound() -> String:
	var sounds_array := []
	for  iter in range(8):
		sounds_array.append("card_slide%s" % (iter + 1))
	CFUtils.shuffle_array(sounds_array)
	return(sounds_array[0])
