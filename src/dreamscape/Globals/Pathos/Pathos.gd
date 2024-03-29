class_name Pathos
extends Reference

# Sent when repressed pathos is increased
# warning-ignore:unused_signal
signal pathos_repressed(pathos, amount)
# Sent then repressed pathos is decreased and released is increased
# warning-ignore:unused_signal
signal pathos_released(pathos, amount)
# Sent when released pathos is decreased without a special flag
# warning-ignore:unused_signal
signal pathos_spent(pathos, amount)
# Sent when repressed pathos is decreased with a special flag
# warning-ignore:unused_signal
signal repressed_pathos_lost(pathos, amount)
# Sent when released pathos is decreased with a special flag
# warning-ignore:unused_signal
signal released_pathos_lost(pathos, amount)
# Sent when released pathos is increased
# warning-ignore:unused_signal
signal released_pathos_gained(pathos, amount)
# Send when a pathos levels up
# warning-ignore:unused_signal
signal pathos_leveled(pathos, level)
# Send when a pathos is selected for an encounter
# warning-ignore:unused_signal
signal pathos_selected(pathos)
# Send when a pathos is not selected for an encounter
# warning-ignore:unused_signal
signal pathos_ignored(pathos)
signal advancements_modified(new_value, old_value)

# As a baseline for rewards/costs, we use the amount a normal enemy gives when defeated
const MASTERY_BASELINE = 3
const STARTING_MASTERIES = round(MASTERY_BASELINE * 1.5)

var pathos_setup := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: {
		"repressed": 25.0,
		"progression": range(11,20),
		"threshold": 1.3 - globals.difficulty.encounter_difficulty * 0.1,
		"released_needed_for_level": 4.0,
		"masteries_when_chosen": MASTERY_BASELINE,
	},
	Terms.RUN_ACCUMULATION_NAMES.rest: {
		"repressed": 5.0,
		"progression": range(3,5),
		"threshold": 5.0 + globals.difficulty.encounter_difficulty * 0.5,
		"released_needed_for_level": 15.0,
	},
	Terms.RUN_ACCUMULATION_NAMES.nce: {
		"repressed": 10.0,
		"progression": range(7,11),
		"threshold": 3.0 + globals.difficulty.encounter_difficulty * 0.5,
		"released_needed_for_level": 9.0,
	},
	Terms.RUN_ACCUMULATION_NAMES.shop: {
		"repressed": 10.0,
		"progression": range(5,7),
		"threshold": 4.0 + globals.difficulty.encounter_difficulty * 0.5,
		"released_needed_for_level": 13.0,
	},
	Terms.RUN_ACCUMULATION_NAMES.elite: {
		"progression": range(5,9),
		"threshold": 5.3 - globals.difficulty.encounter_difficulty * 0.5,
		"released_needed_for_level": 5.0,
		"masteries_when_chosen": floor(MASTERY_BASELINE * 2.5),
	},
	Terms.RUN_ACCUMULATION_NAMES.artifact: {
		"progression": range(2,5),
		"threshold": 6.0 + globals.difficulty.encounter_difficulty * 0.5,
		"released_needed_for_level": 16.0,
	},
	Terms.RUN_ACCUMULATION_NAMES.boss: {
		"progression": range(6,7),
		"threshold": 17.0 - globals.difficulty.encounter_difficulty * 1.0,
		"released_needed_for_level": 16.0,
		"masteries_when_chosen": MASTERY_BASELINE * 5,
	},
}

var pathi := {}
# This is used as the baseline for cost of cards in the shop
var baseline = Terms.RUN_ACCUMULATION_NAMES.enemy
var available_masteries := 0 setget set_available_masteries


func _init() -> void:
	for pathos_name in pathos_setup:
		pathi[pathos_name] = PathosType.new(self)
		pathi[pathos_name].name = pathos_name
		for key in pathos_setup[pathos_name]:
			pathi[pathos_name].set(key,pathos_setup[pathos_name][key])
#			print([pathos_name,key,pathi[pathos_name].get(key)])
	# warning-ignore:return_value_discarded
	connect("pathos_selected",self,"_on_pathos_selected")
	# Every run, starts the player with a bunch of pathos masteries
# warning-ignore:narrowing_conversion
	available_masteries = STARTING_MASTERIES * globals.difficulty.starting_masteries


func set_available_masteries(value: int) -> void:
	var old_value = available_masteries
	available_masteries = value
	if value != old_value:
		emit_signal("advancements_modified", value, old_value)


# Increases the specified repressed pathos by the standard amount
func repress(pathos_to_ignore := []) -> void:
	for pathos_type in pathi.values():
		if not pathos_type.name in pathos_to_ignore:
			pathos_type.repress()


func release(pathos_name: String) -> int:
	var retcode : int = CFConst.ReturnCode.CHANGED
	var pathos_type :PathosType = pathi[pathos_name]
	if pathos_type.repressed == 0:
		retcode = CFConst.ReturnCode.OK
	pathos_type.release_for_selection()
	return(retcode)


func grab_random_pathos() -> PathosType:
	var all_pathos = Terms.RUN_ACCUMULATION_NAMES.values()
	CFUtils.shuffle_array(all_pathos)
	return(pathi[all_pathos[0]])


# Returns a dictionary with the highest pathos, the lowest pathos
# and the middle pathos.
# If include_zeroes == false, It excludes those pathos which are at 0, unless there's not
# enough non-0 options to fill all three options (high, mid, low).
# If include_zeroes is true, then zero-pathos will not be excluded from being lowest.
func get_pathos_org(type := "pct_to_mastery", include_zeroes := false) -> Dictionary:
	var results_dict := {
		"highest_pathos": {
			"found":[],
			"value": 0,
			"selected": null
		},
		"lowest_pathos": {
			"found":[],
			"value": 10000,
			"selected": null
		},
		"middle_pathos": {
			"value": 0,
			"selected": null
		},
	}
	var zero_pathos:= []
	var pathos_dict := {}
	for p in pathi.values():
		if type == "pct_to_mastery":
			pathos_dict[p] = p.get_progress_pct()
		else:
			pathos_dict[p] = p.get(type)
	for pathos in pathos_dict:
		if pathos_dict[pathos] == 0:
			zero_pathos.append(pathos)
			if not include_zeroes:
				continue
		# This sort of conditionals, ensure the same pathos cannot be at the same
		# time the highest and lowest
		if pathos_dict[pathos] == results_dict["lowest_pathos"]["value"]:
			results_dict["lowest_pathos"]["found"].append(pathos)
		if pathos_dict[pathos] == results_dict["highest_pathos"]["value"]:
			results_dict["highest_pathos"]["found"].append(pathos)
		if pathos_dict[pathos] > results_dict["highest_pathos"]["value"]:
			results_dict["highest_pathos"]["found"] = [pathos]
			results_dict["highest_pathos"]["value"] = pathos_dict[pathos]
		if pathos_dict[pathos] < results_dict["lowest_pathos"]["value"]:
			results_dict["lowest_pathos"]["found"] = [pathos]
			results_dict["lowest_pathos"]["value"] = pathos_dict[pathos]
#			print_debug(pathos, pathos_dict[pathos])
	if zero_pathos.size() > 1:
		CFUtils.shuffle_array(zero_pathos)
	for pathos_org_type in ["highest_pathos", "lowest_pathos"]:
		if results_dict[pathos_org_type]["found"].size() == 0:
			results_dict[pathos_org_type]["selected"] = zero_pathos.pop_back()
		else:
			if results_dict[pathos_org_type]["found"].size() > 1:
				CFUtils.shuffle_array(results_dict[pathos_org_type]["found"])
			results_dict[pathos_org_type]["selected"] = results_dict[pathos_org_type]["found"][0]
	if pathos_dict[results_dict["lowest_pathos"]["selected"]] == 0 and not include_zeroes:
		results_dict["middle_pathos"]["selected"] = zero_pathos.pop_back()
		results_dict["middle_pathos"]["value"] = pathos_dict[results_dict["middle_pathos"]["selected"]]
	else:
		for pathos in pathos_dict:
			if pathos_dict[pathos] == 0\
					or pathos == results_dict["highest_pathos"]["selected"]\
					or pathos == results_dict["lowest_pathos"]["selected"]:
#				print_debug('aaa ', pathos, pathos_dict[pathos])
				continue
			results_dict["middle_pathos"]["selected"] = pathos
			results_dict["middle_pathos"]["value"] = pathos_dict[pathos]
			break
	if not results_dict["middle_pathos"]["selected"]:
		results_dict["middle_pathos"]["selected"] = results_dict["lowest_pathos"]["selected"]
		results_dict["middle_pathos"]["value"] = results_dict["lowest_pathos"]["value"]
		results_dict["lowest_pathos"]["selected"] = zero_pathos.pop_back()
		results_dict["lowest_pathos"]["value"] = pathos_dict[results_dict["lowest_pathos"]["selected"]]
#	print_debug(type, results_dict)
	return(results_dict)


# Checks what the chance is for the specified pathos to provide an encounter
# based on all the other repressed pathos in comparison to itself
# Takes into account thresholds and the progression of between encounters
func calculate_chance_for_encounter(entry: String, include_next_progression := true, mod_pathos_dict := {}) -> int:
	if not pathi.has(entry):
		return(-1)
	var boss_threshold = get_boss_threshold()
	if pathi[Terms.RUN_ACCUMULATION_NAMES.boss].repressed >= boss_threshold:
		if entry == Terms.RUN_ACCUMULATION_NAMES.boss:
			return(100)
		else:
			return(0)
	elif pathi[Terms.RUN_ACCUMULATION_NAMES.boss].repressed\
			+ pathi[Terms.RUN_ACCUMULATION_NAMES.boss].progression.front() >= boss_threshold:
		if entry == Terms.RUN_ACCUMULATION_NAMES.boss:
			return(100)
		else:
			return(0)
	elif entry == Terms.RUN_ACCUMULATION_NAMES.boss:
		return(0)
	# If the boss is going to appear, all other encounters have 0 chance.
	var total: float = 0
	var progression : float = 0
	for pathos_entry in pathi:
		progression = 0
		# The boss has no chance. It either appears or not when it has 100 repressed pathos
		if pathos_entry == Terms.RUN_ACCUMULATION_NAMES.boss:
			continue
		if include_next_progression:
			progression += pathi[pathos_entry].progression.back()
		var pathos_entry_total : float = pathi[pathos_entry].repressed + progression
		pathos_entry_total += mod_pathos_dict.get(pathos_entry,0)
		if pathos_entry_total < 0:
			pathos_entry_total = 0
		if pathos_entry_total >= pathi[pathos_entry].get_threshold():
#			print_debug(pathos_entry, repressed[pathos_entry] + progression)
			total += pathos_entry_total
	progression = mod_pathos_dict.get(entry,0)
	if include_next_progression:
		progression += pathi[entry].progression.back()
	var entry_total : float = pathi[entry].repressed + progression
	if entry_total < 0:
		entry_total = 0
	var chance: int
	if entry_total >= pathi[entry].get_threshold():
		chance = int(round(entry_total / total * 100))
	else:
		chance = 0
#	print_debug([entry, mod_pathos_dict.get(entry,0), entry_total, total,chance])
	return(chance)


func get_boss_threshold() -> float:
	return(pathi[Terms.RUN_ACCUMULATION_NAMES.boss].get_threshold())


func extract_save_state() -> Dictionary:
	var pathos_dict := {
		"available_masteries": available_masteries
	}
	for pathos_type in pathi.values():
		pathos_dict[pathos_type.name] = {}
		pathos_dict[pathos_type.name]["repressed"] = pathos_type.repressed
		pathos_dict[pathos_type.name]["released"] = pathos_type.released
#		pathos_dict[pathos_type.name]["level"] = pathos_type.level
#		pathos_dict[pathos_type.name]["temp_modification_for_next_level"] = pathos_type.temp_modification_for_next_level
#		pathos_dict[pathos_type.name]["perm_modification_for_next_level"] = pathos_type.perm_modification_for_next_level
		pathos_dict[pathos_type.name]["masteries_when_chosen"] = pathos_type.masteries_when_chosen
		pathos_dict[pathos_type.name]["masteries_modifiers"] = pathos_type.masteries_modifiers
		pathos_dict[pathos_type.name]["skipped"] = pathos_type.skipped
		
	return(pathos_dict)


func restore_save_state(save_state: Dictionary) -> void:
	for pathos_type in pathi.values():
		pathos_type._set_repressed(save_state[pathos_type.name].repressed, true)
		pathos_type._set_released(save_state[pathos_type.name].released, true)
#		pathos_type.level = save_state[pathos_type.name].level
#		pathos_type.temp_modification_for_next_level = save_state[pathos_type.name].temp_modification_for_next_level
#		pathos_type.perm_modification_for_next_level = save_state[pathos_type.name].perm_modification_for_next_level
		pathos_type.masteries_when_chosen = save_state[pathos_type.name].masteries_when_chosen
		pathos_type.masteries_modifiers = save_state[pathos_type.name].masteries_modifiers
		pathos_type.skipped = save_state[pathos_type.name].skipped
	available_masteries = save_state.available_masteries


func _on_pathos_selected(pathos_name: String) -> void:
	set_available_masteries(available_masteries + pathi[pathos_name].get_masteries_per_selection())
