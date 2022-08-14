class_name EncounterStory
extends Reference

const MAX_LENGTHS := {
	"journal_choice": 80,
	"torment_taunt": 30,
}

# The unique name of this encounter
var name: String
# A short title for this encounter/story in Hypnagonia acts. This is fed to the AI to better give it context
var title: String = ''
# A unique identifier of the type of story this is.
# Serves to separate different stories within the same encounter
var type: String = "journal_choice"
# The hardcoded stories for this encounter/type, one of which which will be shown to the player as intro to this encounter
# if no AI text exists
var default_stories: Array
# The current story for this encounter/type
var story := '' setget ,get_story
# The UUID is used to rate the AI story
var story_uuid: String = "00000000-0000-0000-0000-000000000000"
# The possible prompts to give to the AI to generate a new dynamic story
var ai_prompts: Array
# The mapping of replacement keywords to use for torment encounters.
# The first of the strings in the list will be replaced by the key in bbcode url format
# So that it becomes a popup in the journal
var replacement_keywords := {
#	"torment_tag1": [],
#	"torment_tag2": [],
#	"torment_tag3": [],
#	"torment_tag4": [],
#	"torment_tag5": [],
}
var is_generated := false
# How big the story is supposed to be in tokens. See MAX_LENGTHS
var max_length: int


func _init(_type: String) -> void:
	type = _type
	max_length = MAX_LENGTHS.get(type, 80)


func setup_with_vars(
		_name: String,
		_default_stories = null,
		_title: String = '',
		_ai_prompts := [],
		_replacement_kws := {}) -> void:
	name = _name
	title = _title
	if _title == '':
		title = name
	name = _name
	if typeof(_default_stories) == TYPE_ARRAY:
		default_stories = _default_stories.duplicate()
	elif typeof(_default_stories) == TYPE_STRING:
		default_stories = [_default_stories]
	ai_prompts = _ai_prompts
	replacement_keywords = _replacement_kws


func setup_with_torment_dict(details: Dictionary) -> void:
	if not details.has('name'):
		push_error("Story without a name received!")
	name = details.get("name", '')
	title = details.get("title", name)
	if details.has('journal_description'):
		if typeof(details.journal_description) == TYPE_ARRAY:
			default_stories = details.journal_description.duplicate()
		else:
			default_stories = [details.journal_description]
	ai_prompts = details.get("ai_prompts", []).duplicate()
	replacement_keywords = details.get("replacement_keywords", {}).duplicate(true)


func get_story() -> String:
	if story == '':
		if can_generate_story()\
				and cfc.game_settings.get("use_ai", true)\
				and not cfc.is_testing:
			var ret = globals.ai_stories.retrieve_story(self)
			story = _add_popup_urls(ret.story)
			story_uuid = ret.uuid
			if story == '':
				set_random_default_story()
				is_generated = false
			else:
				is_generated = true
		else:
			set_random_default_story()
	return(story)


func get_random_prompt() -> String:
	CFUtils.shuffle_array(ai_prompts, true)
	return(ai_prompts.front())


func can_generate_story() -> bool:
	return(!ai_prompts.empty())


func _add_popup_urls(gen_story: String) -> String:
	for ttag in replacement_keywords:
		for kw in replacement_keywords[ttag]:
#				print_debug([ttag, kw, kw in full_story])
			var regex_kw = RegEx.new()
			regex_kw.compile("(%s)" % [kw])
			if regex_kw.search(gen_story):
				gen_story = regex_kw.sub(gen_story, '[url={%s}]$1[/url]' % [ttag])
				break
	return(gen_story)


func set_random_default_story() -> void:
	CFUtils.shuffle_array(default_stories, true)
	story = default_stories.front()
