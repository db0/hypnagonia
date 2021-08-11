# SP stands for "ScriptProperties".
#
# This dummy class exists to allow games to extend
# the core [ScriptProperties] class provided by CGF, with their own requirements.
#
# This is particularly useful when needing to adjust filters for the game's needs.
class_name SP
extends ScriptProperties

# Used for specifying the amount of something a script provides
# e.g. amount of damage, or amount of armor
const KEY_SUBJECT_V_PLAYER = "dreamer"
const KEY_AMOUNT = "amount"
const KEY_EFFECT = "effect_name"

const FILTER_EFFECTS = "filter_effects"
const FILTER_IS_NOT_SPECIFIED_ENEMY = "filter_not_enemy"
const FILTER_STACKS = "filter_stacks"
const FILTER_TURN_EVENT_COUNT = "filter_turn_event_count"
const FILTER_ENCOUNTER_EVENT_COUNT = "filter_encounter_event_count"
const KEY_EFFECT_NAME = "effect_name"
const KEY_UPGRADE_NAME = "upgrade_name"
const KEY_EVENT_NAME = "event_name"
const KEY_ENEMY_NAME = "enemy_name"
const KEY_ENEMY = "enemy"
const KEY_MODIFY_SPAWN_HEALTH = "modify_spawn_health"
# Used when removing a card from the deck. If set to true, removes the card
# for the whole run
const KEY_PERMANENT = "is_permanent"
const FILTER_PER_EFFECT_STACKS = "filter_per_effect_stacks"
const PER_EFFECT_STACKS = "per_effect_stacks"
const KEY_CARD_COUNT := "card_count"
const KEY_PER_DEFENCE := "per_defence"
const KEY_PER_TURN_EVENT_COUNT := "per_turn_event_count"
const KEY_PER_ENCOUNTER_EVENT_COUNT := "per_encounter_event_count"
# This call has been setup to call the original, and allow futher extension
# simply create new filter
static func filter_trigger(
		card_scripts,
		trigger_card,
		owner_card,
		trigger_details) -> bool:
	var is_valid := .filter_trigger(card_scripts,
		trigger_card,
		owner_card,
		trigger_details)
	# For the card effect of Gummiraprot
	var comparison : String = card_scripts.get(
			ScriptProperties.KEY_COMPARISON,
			get_default(ScriptProperties.KEY_COMPARISON))

	if is_valid and card_scripts.get("filter_gummiraptor"):
		for enemy in cfc.get_tree().get_nodes_in_group("EnemyEntities"):
			if enemy.intents.get_total_damage() > 0:
				is_valid = false
	if is_valid and card_scripts.get("filter_smart_gummiraptor"):
		for enemy in cfc.get_tree().get_nodes_in_group("EnemyEntities"):
			if enemy.intents.get_total_damage() > 5:
				is_valid = false
	if is_valid and card_scripts.get("filter_dreamer_effect"):
		var current_stacks = cfc.NMAP.board.dreamer.active_effects.get_effect_stacks(
				card_scripts["filter_dreamer_effect"])
		var requested_stacks : int = card_scripts.get(FILTER_STACKS, 1)
		if not CFUtils.compare_numbers(
				current_stacks,
				requested_stacks,
				comparison):
			is_valid = false

	# Card Count on board filter check
	if is_valid and card_scripts.get(FILTER_PER_EFFECT_STACKS):
		var per_msg = perMessage.new(
				FILTER_PER_EFFECT_STACKS,
				owner_card,
				card_scripts.get(FILTER_PER_EFFECT_STACKS))
		var found_count = per_msg.found_things
		var required_stacks = card_scripts.\
				get(FILTER_PER_EFFECT_STACKS).get(FILTER_STACKS)
		var comparison_type = card_scripts.get(FILTER_PER_EFFECT_STACKS).get(
				ScriptProperties.KEY_COMPARISON, get_default(ScriptProperties.KEY_COMPARISON))
		if not CFUtils.compare_numbers(
				found_count,
				required_stacks,
				comparison_type):
			is_valid = false
	
	# Checks if the aount of cards with a specific card played
	# match the filter requested by this effect
	if is_valid and card_scripts.has(FILTER_TURN_EVENT_COUNT):
		var filter_event_count = card_scripts[FILTER_TURN_EVENT_COUNT]
		var comparison_type = filter_event_count.get(
				ScriptProperties.KEY_COMPARISON, get_default(ScriptProperties.KEY_COMPARISON))
		var current_event_count = cfc.NMAP.board.turn.turn_event_count.get(filter_event_count["event"], 0)	
		var requested_count : int = card_scripts.get(ScriptProperties.FILTER_COUNT, 1)
		if not CFUtils.compare_numbers(
				current_event_count,
				requested_count,
				comparison_type):
			is_valid = false

	if is_valid and card_scripts.has(FILTER_ENCOUNTER_EVENT_COUNT):
		var filter_event_count = card_scripts[FILTER_ENCOUNTER_EVENT_COUNT]
		var comparison_type = filter_event_count.get(
				ScriptProperties.KEY_COMPARISON, get_default(ScriptProperties.KEY_COMPARISON))
		var current_event_count = cfc.NMAP.board.turn.encounter_event_count.get(filter_event_count["event"], 0)	
		var requested_count : int = card_scripts.get(ScriptProperties.FILTER_COUNT, 1)
		if not CFUtils.compare_numbers(
				current_event_count,
				requested_count,
				comparison_type):
			is_valid = false
	return(is_valid)

static func check_validity(obj, card_scripts, type := "trigger") -> bool:
	var card_matches := .check_validity(obj, card_scripts, type)
	if obj and card_scripts.get(ScriptProperties.FILTER_STATE + type):
		var state_filters_array : Array = card_scripts.get(ScriptProperties.FILTER_STATE + type)
		for state_filters in state_filters_array:
			for filter in state_filters:
				# We check with like this, as it allows us to provide an "AND"
				# check, by simply apprending something into the state string
				# I.e. if we have filter_properties and filter_properties2
				# It will treat these two states as an "AND"
				if filter == FILTER_EFFECTS\
						and not obj.active_effects.get_effect(state_filters[filter]):
					card_matches = false
				if filter == FILTER_IS_NOT_SPECIFIED_ENEMY\
						and obj == state_filters[filter]:
					card_matches = false
	return(card_matches)
