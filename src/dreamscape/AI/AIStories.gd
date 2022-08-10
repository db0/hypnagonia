class_name AIStories
extends Reference

signal story_used

var torments := {}
var nces := {}
var threads: Array


func retrieve_torment_story(torment_encounter: Dictionary) -> String:
	var story = torment_encounter["journal_description"]
	if torments.has(torment_encounter.name):
		story = torments[torment_encounter.name].back()
		emit_signal("story_used")
	if torment_encounter.has("ai_prompts"):
		var thread: Thread = Thread.new()
		thread.start(self, "regenerate_torment_story", torment_encounter)
		threads.append(thread)
	return(story)

func regenerate_torment_story(torment_encounter: Dictionary) -> void:
	CFUtils.shuffle_array(torment_encounter["ai_prompts"], true)
	var ai_prompt : String = torment_encounter["ai_prompts"][0]
	var fmt := {
		"prompt": ai_prompt,
		"title": torment_encounter.name
	}
	var prompt = "[ Title: {title} ]\n{prompt}".format(fmt)
#	print("regenerate_torment_story():" + prompt)
	var new_story = KoboldAI.generate(prompt, KoboldAI.GenerationTypes.TORMENT_INTRO)
	if new_story:
		if not torments.has(torment_encounter.name):
			torments[torment_encounter.name] = []
		torments[torment_encounter.name].append(ai_prompt + new_story)
