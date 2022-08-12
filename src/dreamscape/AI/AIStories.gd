class_name AIStories
extends Node

enum StoryTypes {
	GENERATED
	EVALUATING
	FINALIZED
	DEFAULT
}

signal story_used(type)

const STORIES_FILENAME := "user://hypnagonia_stories.dat"

var stories_file = File.new()
var torments := {}
var nces := {}
var threads: Array
var evaluating_generations: Dictionary
var finalized_generations: Dictionary

onready var ai_ratings: AIRatings = AIRatings.new()

func _init():
	load_stories()

func _ready():
	if cfc.is_testing:
		return
	add_child(ai_ratings)
	ai_ratings.connect("ratings_retrieved", self, "_on_ratings_received")
	ai_ratings.retrieve_evaluating_gens()
	ai_ratings.retrieve_finalized_gens()

func retrieve_torment_story(torment_encounter: Dictionary) -> Dictionary:
	var story = {
		"story": torment_encounter["journal_description"],
		"uuid": "00000000-0000-0000-0000-000000000000"
	}
	if not cfc.game_settings.use_ai or cfc.is_testing:
		return(story)
	var fresh_evaluation = get_fresh_evaluating_gen(torment_encounter.name, "journal_choice")
	if fresh_evaluation and cfc.game_settings.judge_ai:
		story.story = fresh_evaluation.generation
		story.uuid = fresh_evaluation.uuid
		emit_signal("story_used",StoryTypes.EVALUATING)
		print_debug("using evaluating story")
	elif torments.has(torment_encounter.name):
		story = torments[torment_encounter.name]
		torments.erase(torment_encounter.name)
		emit_signal("story_used",StoryTypes.GENERATED)
		print_debug("using generated story")
	else:
		var collected_generations = get_generations(torment_encounter.name, "journal_choice", false)
		if not collected_generations.empty():
			var finalized_uuids = collected_generations.keys()
			CFUtils.shuffle_array(finalized_uuids)
			var uuid = finalized_uuids[0]
			story.story = collected_generations[uuid]["generation"]
			story.uuid = uuid
			emit_signal("story_used",StoryTypes.FINALIZED)
			print_debug("using finalized story")
	# We don't want to generate a story if there's an unused one already
	if torment_encounter.has("ai_prompts")\
			and cfc.game_settings.generate_ai\
			and not torments.has(torment_encounter.name):
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
	regex.compile(" \\[ [\\w ]+ \\] ")
	var full_story : String = regex.sub(ai_prompt, ' ') + new_story
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

# Saves previously generated stories that have not yet been used
func save_stories() -> void:
	stories_file.open(STORIES_FILENAME, File.WRITE)
	var stories = {
		"torments": torments,
		"nces": nces,
	}
	stories_file.store_var(stories)
#	file.store_string(JSON.print(state, '\t'))
	stories_file.close()

# Loads previously generated stories that have not yet been used
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


# Retrieves a generation under evaluation which has not yet been rated by this client
func get_fresh_evaluating_gen(name: String, type: String):
	var collected_generations = get_generations(name, type, true)
	for gen in collected_generations:
		var generation : Dictionary = collected_generations[gen].duplicate()
		if cfc.game_settings['Client UUID'] in generation["ratings"]:
			continue
		generation["uuid"] = gen
		return(generation)


# Retrieves a generation of the correct specification
func get_generations(name: String, type: String, evaluating: bool) -> Dictionary:
	var requested_generations: Dictionary
	if evaluating:
		 requested_generations = evaluating_generations
	else:
		requested_generations = finalized_generations
	var collected_generations := {}
	for gen in requested_generations:
		var generation : Dictionary = requested_generations[gen]
		if generation["title"] != name:
			continue
		if generation["type"] != type:
			continue
		collected_generations[gen] = generation
	return(collected_generations)


func stories_file_exists() -> bool:
	return(stories_file.file_exists(STORIES_FILENAME))


# Stores the downloaded ratings to the internal variables
func _on_ratings_received(ratings_dict: Dictionary, evaluating: bool) -> void:
	if evaluating:
		evaluating_generations = ratings_dict
	else:
		finalized_generations = ratings_dict
