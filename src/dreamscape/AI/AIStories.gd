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
var stories := {}
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
	EventBus.connect("kobodoldai_server_changed", self, "_on_koboldai_server_changed")
	var thread: Thread = Thread.new()
	thread.start(self, "_init_koboldai_story")
	threads.append(thread)
	


func retrieve_story(encounter_story) -> Dictionary:
	var story = {
		"story": '',
		"uuid": ''
	}
	var fresh_evaluation = get_fresh_evaluating_gen(encounter_story)
	if fresh_evaluation and cfc.game_settings.judge_ai:
		story.story = fresh_evaluation.generation
		story.uuid = fresh_evaluation.uuid
		emit_signal("story_used",StoryTypes.EVALUATING)
		CFUtils.dprint("AIStories:Using evaluating story for " + encounter_story.name)
	elif stories.has(encounter_story.name):
		story = stories[encounter_story.name]
		stories.erase(encounter_story.name)
		emit_signal("story_used",StoryTypes.GENERATED)
		CFUtils.dprint("AIStories:Using generated story for " + encounter_story.name)
	else:
		var collected_generations = get_generations(encounter_story, false)
		if not collected_generations.empty():
			var finalized_uuids = collected_generations.keys()
			CFUtils.shuffle_array(finalized_uuids, true)
			var uuid = finalized_uuids[0]
			story.story = collected_generations[uuid]["generation"]
			story.uuid = uuid
			emit_signal("story_used",StoryTypes.FINALIZED)
			CFUtils.dprint("AIStories:Using finalized story for " + encounter_story.name)
		else:
			CFUtils.dprint("AIStories:Could not find generated story for " + encounter_story.name)
	# We don't want to generate a story if there's an unused one already
	if cfc.game_settings.generate_ai and not stories.has(encounter_story.name):
		var thread: Thread = Thread.new()
		thread.start(self, "regenerate_torment_story", encounter_story)
		threads.append(thread)
	return(story)

func regenerate_torment_story(encounter_story) -> void:
	var ai_prompt : String = encounter_story.get_random_prompt()
	var fmt := {
		"prompt": ai_prompt,
		"title": encounter_story.title,
		"genre": HConst.get_aigenre_description(cfc.game_settings.ai_genre)
	}
	var prompt: String
	if cfc.game_settings.ai_genre != HConst.AIGenres.RANDOM:
		prompt = "[ Title: {title} ]\n"\
			+ "[ Genre: {genre} ]\n"\
			+ "{prompt}"
	# We don't have to tell the AI to generate a random Genre.
	else:
		prompt = "[ Title: {title} ]\n"\
			+ "{prompt}"
	prompt = prompt.format(fmt)
#	print("regenerate_torment_story():" + prompt)
	var new_story = KoboldAI.generate(prompt, encounter_story.max_length)
	if not new_story:
		return
	var regex = RegEx.new()
	regex.compile(" \\[ [\\w ]+ \\]([ .,;])")
	var full_story : String = regex.sub(ai_prompt, '$1') + new_story
	stories[encounter_story.name] = {
		"uuid": UUID.v4(),
		"story": full_story
	}
	save_stories()

# Saves previously generated stories that have not yet been used
func save_stories() -> void:
	stories_file.open(STORIES_FILENAME, File.WRITE)
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
	stories = data


# Retrieves a generation under evaluation which has not yet been rated by this client
func get_fresh_evaluating_gen(encounter_story):
	var collected_generations = get_generations(encounter_story, true)
	for gen in collected_generations:
		var generation : Dictionary = collected_generations[gen].duplicate()
		if cfc.game_settings['Client UUID'] in generation["ratings"]:
			continue
		# We add the current UUID to the collected generation, as it's not
		# normally included inside the dictionary
		generation["uuid"] = gen
		return(generation)


# Retrieves a generation of the correct specification
func get_generations(encounter_story, evaluating: bool) -> Dictionary:
	var requested_generations: Dictionary
	if evaluating:
		 requested_generations = evaluating_generations
	else:
		requested_generations = finalized_generations
	var collected_generations := {}
	for gen in requested_generations:
		var generation : Dictionary = requested_generations[gen]
		if generation["title"] != encounter_story.name:
			continue
		if generation["type"] != encounter_story.type:
			continue
		collected_generations[gen] = generation
	return(collected_generations)


func stories_file_exists() -> bool:
	return(stories_file.file_exists(STORIES_FILENAME))


# Stores the downloaded ratings to the internal variables
func _on_ratings_received(ratings_dict: Dictionary, evaluating: bool) -> void:
	if evaluating:
		evaluating_generations = ratings_dict
		CFUtils.dprint("AIStories:Loaded evaluating stories.")
	else:
		finalized_generations = ratings_dict
		CFUtils.dprint("AIStories:Loaded finalized stories.")


func _init_koboldai_story() -> void:
	var wi = KoboldAI.get_world_info()
	if not wi:
		push_warning("KoboldAI instance not found")
		return
	if wi.has("entries"):
		if wi.entries.empty():
			var ret = KoboldAI.put_story()
			CFUtils.dprint("AIStories:Hypnagonia world info loaded.")
		else:
			CFUtils.dprint("AIStories:Hypnagonia world info already loaded.")
	var sp = KoboldAI.get_soft_prompt()
	if not sp:
		push_warning("KoboldAI instance not found")
		return
	var sp_to_model:= {
		"surrealism_and_dreams_2.7B.zip": "KoboldAI/fairseq-dense-2.7B-Nerys",
		"surrealism_and_dreams_13B.zip": "KoboldAI/fairseq-dense-13B-Nerys"
	}
	if sp.has("value"):
		if sp.value != "hypnagonia_dreams_and_surrealism.zip":
			var ret = KoboldAI.put_soft_prompt()
			CFUtils.dprint("AIStories:Hypnagonia soft prompt loaded.")
		else:
			CFUtils.dprint("AIStories:Hypnagonia soft prompt already loaded.")


func _on_koboldai_server_changed() -> void:
	var thread: Thread = Thread.new()
	thread.start(self, "_init_koboldai_story")
	threads.append(thread)
