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
const KEY_AMOUNT = "amount"
# Used to specifying the percent required.
# see FILTER_DAMAGE_PCT
const KEY_PERCENT = "percent"
const KEY_SUBJECT_V_PLAYER = "dreamer"
# If the card is using an X cost, we need to specify if the X value is going to
# be modified (e.g. "X+1) at all.
const KEY_X_MODIFIER = "x_modifier"
# If the card is using an X cost, we need to specify if the X value
# is being added to the total, or multiplying the total.
const KEY_X_OPERATION = "x_operation"
const KEY_EFFECT = "effect_name"

const FILTER_EFFECTS = "filter_effects"
const FILTER_IS_NOT_SPECIFIED_ENEMY = "filter_not_enemy"
const FILTER_DREAMER_DEFENCE = "filter_dreamer_defence"
const FILTER_STACKS = "filter_stacks"
const FILTER_TURN_EVENT_COUNT = "filter_turn_event_count"
const FILTER_ENCOUNTER_EVENT_COUNT = "filter_encounter_event_count"
const FILTER_DAMAGE_PCT = "filter_damage_percent"
# Filters based on how much immersion will be used by X
const FILTER_X_USAGE = "filter_x_usage"
const KEY_EFFECT_NAME = "effect_name"
const KEY_UPGRADE_NAME = "upgrade_name"
const KEY_EVENT_NAME = "event_name"
const KEY_ENEMY_NAME = "enemy_name"
const KEY_ENEMY = "enemy"
# If this value is set to true, the card spawned is permanently added to the player's deck
const KEY_IS_PERMANENT = "is_permanent"
# Type: int
# Adjusts the spawned enemy health by this amount
const KEY_MODIFY_SPAWN_HEALTH = "modify_spawn_health"
# Type: bool
# Sets the spawnm to be automatically defeated when the main enemy is defeated
# Typically used with bosses
const KEY_SET_SPAWN_AS_MINION = "set_spawn_as_minion"
# Used when removing a card from the deck. If set to true, removes the card
# for the whole run
const KEY_PERMANENT = "is_permanent"
const FILTER_PER_EFFECT_STACKS = "filter_per_effect_stacks"
const PER_EFFECT_STACKS = "per_effect_stacks"
const KEY_CARD_COUNT := "card_count"
const KEY_PER_DEFENCE := "per_defence"
const KEY_PER_TURN_EVENT_COUNT := "per_turn_event_count"
const KEY_PER_ENCOUNTER_EVENT_COUNT := "per_encounter_event_count"
# If this is set, the predict() will be rerun every time a new target is hovered and the currect
# hovered target will be sent as a hardcoded previous_subjects.
const KEY_PREDICT_REQUIRES_TARGET := "predict_requires_target"
const RIDER := "rider"
const FILTER_INTENT_STRESS = "filter_intent_stress"

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


	if is_valid and card_scripts.get(FILTER_INTENT_STRESS) != null:
		for enemy in cfc.get_tree().get_nodes_in_group("EnemyEntities"):
			if enemy.intents.get_total_damage() > card_scripts.get(FILTER_INTENT_STRESS):
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
	if is_valid and card_scripts.get("filter_dreamer_defence") != null:
		var requested_defence : int = card_scripts.get(FILTER_DREAMER_DEFENCE, 1)
#		print_debug(cfc.NMAP.board.dreamer.defence, comparison,requested_defence)
		if not CFUtils.compare_numbers(
				cfc.NMAP.board.dreamer.defence,
				requested_defence,
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

	# Checks if the amount of cards with a specific card played
	# match the filter requested by this effect
	if is_valid and card_scripts.has(FILTER_TURN_EVENT_COUNT):
		var filter_event_count : Dictionary = card_scripts[FILTER_TURN_EVENT_COUNT]
		var comparison_type = filter_event_count.get(
				ScriptProperties.KEY_COMPARISON, get_default(ScriptProperties.KEY_COMPARISON))
		var current_event_count = cfc.NMAP.board.turn.turn_event_count.get(filter_event_count["event"], 0)
		var requested_count : int = filter_event_count.get(ScriptProperties.FILTER_COUNT, 1)
		if not CFUtils.compare_numbers(
				current_event_count,
				requested_count,
				comparison_type):
			is_valid = false

	if is_valid and card_scripts.has(FILTER_ENCOUNTER_EVENT_COUNT):
		var filter_event_count : Dictionary = card_scripts[FILTER_ENCOUNTER_EVENT_COUNT]
		var comparison_type = filter_event_count.get(
				ScriptProperties.KEY_COMPARISON, get_default(ScriptProperties.KEY_COMPARISON))
		var current_event_count = cfc.NMAP.board.turn.encounter_event_count.get(filter_event_count["event"], 0)
		var requested_count : int = filter_event_count.get(ScriptProperties.FILTER_COUNT, 1)
		if not CFUtils.compare_numbers(
				current_event_count,
				requested_count,
				comparison_type):
			is_valid = false

	if is_valid and card_scripts.has(FILTER_DAMAGE_PCT):
		var filter_health_pct : Dictionary = card_scripts[FILTER_DAMAGE_PCT]
		var comparison_type = filter_health_pct.get(
				ScriptProperties.KEY_COMPARISON, get_default(ScriptProperties.KEY_COMPARISON))
		var current_damage_pct = int(float(cfc.NMAP.board.dreamer.damage) / float(cfc.NMAP.board.dreamer.health) * 100)
		var requested_pct : int = filter_health_pct.get(KEY_PERCENT, 10)
		if not CFUtils.compare_numbers(
				current_damage_pct,
				requested_pct,
				comparison_type):
			is_valid = false

	if is_valid and card_scripts.has(FILTER_X_USAGE):
		var filter_x_usage_dict : Dictionary = card_scripts[FILTER_X_USAGE]
		var comparison_type = filter_x_usage_dict.get(
				ScriptProperties.KEY_COMPARISON, 'ge')
		var current_x_usage = trigger_details.get("immersion_amount", 0)
		var filter_x_usage = filter_x_usage_dict.get(ScriptProperties.FILTER_COUNT, 1)
		if not CFUtils.compare_numbers(
				current_x_usage,
				filter_x_usage,
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
						and not check_effect_filter(obj, state_filters[filter]):
					card_matches = false
				if filter == FILTER_IS_NOT_SPECIFIED_ENEMY\
						and obj == state_filters[filter]:
					card_matches = false
	return(card_matches)


# Returns true if the card tokens match against filters specified in
# the provided card_scripts, of if no token filters were requested.
# Otherwise returns false.
static func check_effect_filter(entity, effect_states: Array) -> bool:
	# Each array element, is an individual token name
	# for which to check against.
	var entity_matches := true
	# Effect filters always contain an array of effect states
	for effect_state in effect_states:
		var comparison_default : String = get_default(ScriptProperties.KEY_COMPARISON)
		# If the token count is not defined, we are awlays checking if there
		# is any number of tokens of this type on this card
		# Therefore it's effectively a "ge 1" comparison
		if effect_state.get(ScriptProperties.FILTER_COUNT) == null:
			comparison_default = 'ge'
		var comparison_type : String = effect_state.get(
				ScriptProperties.KEY_COMPARISON, comparison_default)
		if effect_state.get("filter_" + KEY_EFFECT_NAME):
			var effect_count : int = entity.active_effects.get_effect_stacks(
					effect_state.get("filter_" + KEY_EFFECT_NAME))
			var filter_count = effect_state.get(ScriptProperties.FILTER_COUNT,1)
			if not CFUtils.compare_numbers(
					effect_count,
					filter_count,
					comparison_type):
				entity_matches = false
	return(entity_matches)
