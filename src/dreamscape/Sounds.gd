class_name Sounds
extends Reference

static func get_card_play_sound() -> String:
	var sounds_array := []
	for  iter in range(8):
		sounds_array.append("card_slide%s" % (iter + 1))
	CFUtils.shuffle_array(sounds_array, true)
	return(sounds_array[0])

static func get_next_journal_page_sound() -> String:
	var sounds_array := []
	for  iter in range(3):
		sounds_array.append("book_flip%s" % (iter + 1))
	CFUtils.shuffle_array(sounds_array, true)
	return(sounds_array[0])

static func get_randomize_sound() -> String:
	var sounds_array := []
	for  iter in range(3):
		sounds_array.append("randomize%s" % (iter + 1))
	CFUtils.shuffle_array(sounds_array, true)
	return(sounds_array[0])

static func get_shove_sound() -> String:
	var sounds_array := []
	for  iter in range(4):
		sounds_array.append("shove%s" % (iter + 1))
	CFUtils.shuffle_array(sounds_array, true)
	return(sounds_array[0])

