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
const KEY_EFFECT = "effect"

const FILTER_EFFECTS = "filter_effects"
const FILTER_IS_NOT_SPECIFIED_ENEMY = "filter_not_enemy"

const KEY_PER_DEFENCE := "per_defence"
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
	if is_valid and card_scripts.get("filter_gummiraptor"):
		for enemy in cfc.get_tree().get_nodes_in_group("EnemyEntities"):
			if enemy.intents.get_total_damage() > 0:
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
