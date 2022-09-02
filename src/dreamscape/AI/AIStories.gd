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


func _ready():
	if cfc.is_testing:
		return
	add_child(ai_ratings)
	# warning-ignore:return_value_discarded
	ai_ratings.connect("ratings_retrieved", self, "_on_ratings_received")
	ai_ratings.retrieve_evaluating_gens()
	ai_ratings.retrieve_finalized_gens()


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
		# warning-ignore:return_value_discarded
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
	return(story)


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


# Stores the downloaded ratings to the internal variables
func _on_ratings_received(ratings_dict: Dictionary, evaluating: bool) -> void:
	if evaluating:
		evaluating_generations = ratings_dict
		CFUtils.dprint("AIStories:Loaded evaluating stories.")
	else:
		finalized_generations = ratings_dict
		CFUtils.dprint("AIStories:Loaded finalized stories.")


# Thread must be disposed (or "joined"), for portability.
func _exit_tree():
	for thread in threads:
		thread.wait_to_finish()
