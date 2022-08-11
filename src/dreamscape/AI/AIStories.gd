class_name AIStories
extends Reference

signal story_used

# The location and name of the file into which to store game settings
const STORIES_FILENAME := "user://hypnagonia_stories.dat"

var stories_file = File.new()
var torments := {}
var nces := {}
var threads: Array


func _init():
	load_stories()


func retrieve_torment_story(torment_encounter: Dictionary) -> Dictionary:
	var story = {
		"story": torment_encounter["journal_description"],
		"uuid": "00000000-0000-0000-0000-000000000000"
	}
	if torments.has(torment_encounter.name):
		story = torments[torment_encounter.name]
		emit_signal("story_used")
	if torment_encounter.has("ai_prompts") and cfc.game_settings.generate_ai:
		var thread: Thread = Thread.new()
		thread.start(self, "regenerate_torment_story", torment_encounter)
		threads.append(thread)
	return(story)

func regenerate_torment_story(torment_encounter: Dictionary) -> void:
	CFUtils.shuffle_array(torment_encounter["ai_prompts"], true)
	var ai_prompt : String = torment_encounter["ai_prompts"][0]
	var fmt := {
		"prompt": ai_prompt,
		"title": torment_encounter.title
	}
	var prompt = "[ Title: {title} ]\n{prompt}".format(fmt)
#	print("regenerate_torment_story():" + prompt)
	var new_story = KoboldAI.generate(prompt, KoboldAI.GenerationTypes.TORMENT_INTRO)
	if not new_story:
		return
	var regex = RegEx.new()
	regex.compile("{ [\\w ]+ }")
	var full_story : String = regex.sub(ai_prompt, '') + new_story
	if torment_encounter.has("replacement_keywords"):
		for ttag in torment_encounter.replacement_keywords:
			for kw in torment_encounter.replacement_keywords[ttag]:
#				print_debug([ttag, kw, kw in full_story])
				if kw in full_story:
					var regex_kw = RegEx.new()
					regex_kw.compile("(%s)" % [kw])
					full_story = regex_kw.sub(full_story, '[url={%s}]$1[/url]' % [ttag])
					break
	torments[torment_encounter.name] = {
		"uuid": UUID.v4(),
		"story": full_story
	}
	save_stories()

func save_stories() -> void:
	stories_file.open(STORIES_FILENAME, File.WRITE)
	var stories = {
		"torments": torments,
		"nces": nces,
	}
	stories_file.store_var(stories)
#	file.store_string(JSON.print(state, '\t'))
	stories_file.close()

func load_stories() -> void:
	if not stories_file_exists():
		return
	stories_file.open(STORIES_FILENAME, File.READ)
	var data = stories_file.get_var()
	stories_file.close()
	if typeof(data) != TYPE_DICTIONARY:
		return
	# warning-ignore:return_value_discarded
	torments = data.torments
	nces = data.nces
	
func stories_file_exists() -> bool:
	return(stories_file.file_exists(STORIES_FILENAME))
	
