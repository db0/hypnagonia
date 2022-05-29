class_name Pathos
extends Reference

# Sent when repressed pathos is increased
signal pathos_repressed(pathos, amount)
# Sent then repressed pathos is decreased and released is increased
signal pathos_released(pathos, amount)
# Sent when released pathos is decreased without a special flag
signal pathos_spent(pathos, amount)
# Sent when repressed pathos is decreased with a special flag
signal repressed_pathos_lost(pathos, amount)
# Sent when released pathos is decreased with a special flag
signal released_pathos_lost(pathos, amount)
# Sent when released pathos is increased
signal released_pathos_gained(pathos, amount)
# Send when a pathos levels up
signal pathos_leveled(pathos, level)
signal advancements_modified(new_value)

var repressed := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 25.0,
	Terms.RUN_ACCUMULATION_NAMES.rest: 5.0,
	Terms.RUN_ACCUMULATION_NAMES.nce: 10.0,
	Terms.RUN_ACCUMULATION_NAMES.shop: 10.0,
	Terms.RUN_ACCUMULATION_NAMES.elite: 0.0,
	Terms.RUN_ACCUMULATION_NAMES.artifact: 0.0,
	Terms.RUN_ACCUMULATION_NAMES.boss: 0.0,
}

# This is used as the baseline for cost of cards in the shop
var baseline = Terms.RUN_ACCUMULATION_NAMES.enemy

# How much each repressed pathos can increase per journal page
var progressions := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: range(11,20),
	Terms.RUN_ACCUMULATION_NAMES.rest: range(3,5),
	Terms.RUN_ACCUMULATION_NAMES.shop: range(5,7),
	Terms.RUN_ACCUMULATION_NAMES.artifact: range(2,5),
	Terms.RUN_ACCUMULATION_NAMES.elite: range(5,9),
	Terms.RUN_ACCUMULATION_NAMES.nce: range(7,11),
	Terms.RUN_ACCUMULATION_NAMES.boss: range(6,7),
}

# Thresholds specify how many multiples of the pathos average are needed
# before that encounter is an option as an encounter.
# Effectively ~on average~ is limits a type of encounter to appearing
# every X times.
# They are also used to determine how much of a pathos is released every time
# that encounter is selected (see release_adjustments below).
var thresholds := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 1.3 - globals.difficulty.encounter_difficulty * 0.1,
	Terms.RUN_ACCUMULATION_NAMES.rest: 5.0 + globals.difficulty.encounter_difficulty * 0.5,
	Terms.RUN_ACCUMULATION_NAMES.nce: 3.0 + globals.difficulty.encounter_difficulty * 0.5,
	Terms.RUN_ACCUMULATION_NAMES.shop: 4.0 + globals.difficulty.encounter_difficulty * 0.5,
	Terms.RUN_ACCUMULATION_NAMES.elite: 5.3 - globals.difficulty.encounter_difficulty * 0.5,
	Terms.RUN_ACCUMULATION_NAMES.artifact: 6.0 + globals.difficulty.encounter_difficulty * 0.5,
	Terms.RUN_ACCUMULATION_NAMES.boss: 17.0 - globals.difficulty.encounter_difficulty * 1,
}


# Adjusts the amount of pathos released when the encounter is selected.
# This ensures that when that type of encounter is skipped one or more times,
# then selecting it will keep decreasing more than it's increasing.
# Default is 1.3 for pathos not listed below, which means every time they are
# selected, they will transfer as much from represed to released equal to
# their accumulation average * threshold
var release_adjustments := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 3.0,
	Terms.RUN_ACCUMULATION_NAMES.rest: 2.0,
	Terms.RUN_ACCUMULATION_NAMES.nce: 1.5,
	Terms.RUN_ACCUMULATION_NAMES.shop: 1.5,
}


var released := {}

# How many of the average multiples is needed to level up that pathos
var released_needed_for_mastery := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 3.0,
	Terms.RUN_ACCUMULATION_NAMES.rest: 20.0,
	Terms.RUN_ACCUMULATION_NAMES.nce: 10.0,
	Terms.RUN_ACCUMULATION_NAMES.shop: 15.0,
	Terms.RUN_ACCUMULATION_NAMES.elite: 4.0,
	Terms.RUN_ACCUMULATION_NAMES.artifact: 20.0,
	Terms.RUN_ACCUMULATION_NAMES.boss: 17.0,
}

var masteries := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 0,
	Terms.RUN_ACCUMULATION_NAMES.rest: 0,
	Terms.RUN_ACCUMULATION_NAMES.nce: 0,
	Terms.RUN_ACCUMULATION_NAMES.shop: 0,
	Terms.RUN_ACCUMULATION_NAMES.elite: 0,
	Terms.RUN_ACCUMULATION_NAMES.artifact: 0,
	Terms.RUN_ACCUMULATION_NAMES.boss: 0,
}

# Everything not defined == 1
var masterier_per_level := {
	Terms.RUN_ACCUMULATION_NAMES.elite: 2.0,
	Terms.RUN_ACCUMULATION_NAMES.boss: 5.0,
}

var available_masteries := 0 setget set_available_masteries

func _init() -> void:
	for accumulation_name in Terms.RUN_ACCUMULATION_NAMES.values():
		released[accumulation_name] = 0
	var random_pathos =  grab_random_pathos()
	# Every run, starts the player with a bunch of released pathos on a random one.
	released[random_pathos] +=\
			round(get_progression_average(random_pathos)* CFUtils.randf_range(3,5))
#	released[grab_random_pathos()] +=\
#			round(get_progression_average(grab_random_pathos())* CFUtils.randf_range(3,5))
#	released[grab_random_pathos()] +=\
#			round(get_progression_average(grab_random_pathos())* CFUtils.randf_range(3,5))


func set_available_masteries(value: int) -> void:
	available_masteries = value
	emit_signal("advancements_modified", value)


# Increases the specified repressed pathos by the standard amount
func repress(pathos_to_ignore := []) -> void:
	for entry in repressed:
		if not entry in pathos_to_ignore:
			var amount = get_progression(entry)
			repressed[entry] += amount
			emit_signal("pathos_repressed", entry, amount)


# modifies the specified repressed pathos by a given amount
func modify_repressed_pathos(entry: String, amount: float, is_lost := false) -> void:
	repressed[entry] += amount
	if repressed[entry] < 0:
		repressed[entry] = 0
	if amount > 0:
		emit_signal("pathos_repressed", entry, amount)
	elif is_lost:
		emit_signal("repressed_pathos_lost", entry, -amount)


# Increases the specified repressed pathos by the given amount
func repress_pathos(entry: String, amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: repress_pathos() only takes a positive integer")
		return
	modify_repressed_pathos(entry, amount)


# reduces the specified repressed pathos by a given amount
# and increases the released pathos by the same amount
func release_pathos(entry: String, amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: release_pathos() only takes a positive integer")
		return
	# if we try to repress more than we have, we repress only as much as we have
	if amount > repressed[entry]:
		amount = repressed[entry]
	modify_repressed_pathos(entry, -amount)
	modify_released_pathos(entry, amount)
	emit_signal("pathos_released", entry, amount)


# Releases the standard amount for the given pathos
func release(entry: String) -> int:
	var retcode : int = CFConst.ReturnCode.CHANGED
	if repressed[entry] == 0:
		retcode = CFConst.ReturnCode.OK
	var release_amount = get_release_amount(entry)
	release_pathos(entry, release_amount)
	return(retcode)


func get_release_amount(entry: String) -> float:
	var release_amount := get_threshold(entry)
#	print_debug([release_amount, release_adjustments.get(entry,1.0), release_amount * release_adjustments.get(entry,1.0)])
	release_amount *= release_adjustments.get(entry,1.3)
	return(release_amount)


func get_final_release_amount(entry: String) -> int:
	var release_amount = get_release_amount(entry)
	if release_amount > repressed[entry]:
		release_amount = repressed[entry]
	return(int(round(release_amount)))


# modifies the specified released pathos by a given amount
func modify_released_pathos(entry: String, amount: float, is_lost := false) -> void:
	released[entry] += amount
	if released[entry] < 0:
		released[entry] = 0.0
	if amount > 0:
		emit_signal("released_pathos_gained", entry, amount)
	elif is_lost:
		emit_signal("released_pathos_lost", entry, -amount)
	else:
		emit_signal("pathos_spent", entry, -amount)
	check_for_level_up(entry)

func check_for_level_up(entry: String) -> bool:
	var leveled_up := false
	while released[entry] > get_mastery_requirement(entry):
		released[entry] -= get_mastery_requirement(entry)
		masteries[entry] += 1
		set_available_masteries(available_masteries + masterier_per_level.get(entry,1))
		leveled_up = true
		emit_signal("pathos_leveled", entry, masteries[entry])
	return(leveled_up)


func get_entry_progress_pct(entry: String) -> float:
	return(released[entry] / (get_progression_average(entry) * released_needed_for_mastery[entry]))


func get_mastery_requirement(entry: String) -> float:
	return(get_progression_average(entry) * released_needed_for_mastery[entry])

# reduces the specified released pathos by a given amount
func spend_pathos(entry: String, amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: spend_pathos() only takes a positive integer")
		return
	modify_released_pathos(entry, -amount)


# reduces the specified released pathos by a given amount
func lose_repressed_pathos(entry: String, amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: lose_repressed_pathos() only takes a positive integer")
		return
	modify_repressed_pathos(entry, -amount, true)


# reduces the specified released pathos by a given amount
func lose_released_pathos(entry: String, amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: lose_released_pathos() only takes a positive integer")
		return
	modify_released_pathos(entry, -amount, true)


# Returns one random possible progression from the range
# Grabbing the number via a fuction, rather than directly from the var
# allows us to modify this via artifacts during runtime
func get_progression(entry: String) -> float:
	if entry == 'generic': entry = baseline
	var rand_array : Array = progressions[entry].duplicate()
	CFUtils.shuffle_array(rand_array)
	return(float(rand_array[0]))


# Returns the average value of the progression specified
func get_progression_average(entry: String) -> float:
	if entry == 'generic': entry = baseline
	var total: float = 0
	for p in progressions[entry]:
		total += p
	return(total / progressions[entry].size())


# Returns the threshold required to encounter events of this pathos
func get_threshold(entry: String) -> float:
	if entry == 'generic': entry = baseline
#	print_debug(entry, get_progression_average(entry))
	return(get_progression_average(entry) * float(thresholds[entry]))


func grab_random_pathos() -> String:
	var all_pathos = Terms.RUN_ACCUMULATION_NAMES.values()
	CFUtils.shuffle_array(all_pathos)
	return(all_pathos[0])


# Returns a dictionary with the highest pathos, the lowest pathos
# and the middle pathos.
# If include_zeroes == false, It excludes those pathos which are at 0, unless there's not
# enough non-0 options to fill all three options (high, mid, low).
# If include_zeroes is true, then zero-pathos will not be excluded from being lowest.
func get_pathos_org(type := "released", include_zeroes := false) -> Dictionary:
	var results_dict := {
		"highest_pathos": {
			"found":[],
			"value": 0,
			"selected": ''
		},
		"lowest_pathos": {
			"found":[],
			"value": 10000,
			"selected": ''
		},
		"middle_pathos": {
			"value": 0,
			"selected": ''
		},
	}
	var zero_pathos:= []
	var pathos_dict : Dictionary = get(type)
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
	if results_dict["middle_pathos"]["selected"] == '':
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
	if not entry in repressed:
		return(-1)
	var boss_threshold = thresholds[Terms.RUN_ACCUMULATION_NAMES.boss]\
			* get_progression_average(Terms.RUN_ACCUMULATION_NAMES.boss)
	if repressed[Terms.RUN_ACCUMULATION_NAMES.boss] >= boss_threshold:
		if entry == Terms.RUN_ACCUMULATION_NAMES.boss:
			return(100)
		else:
			return(0)
	elif repressed[Terms.RUN_ACCUMULATION_NAMES.boss]\
			+ progressions[Terms.RUN_ACCUMULATION_NAMES.boss].front() >= boss_threshold:
		if entry == Terms.RUN_ACCUMULATION_NAMES.boss:
			return(100)
		else:
			return(0)
	elif entry == Terms.RUN_ACCUMULATION_NAMES.boss:
		return(0)
	# If the boss is going to appear, all other encounters have 0 chance.
	var total: float = 0
	var progression : float = 0
	for pathos_entry in repressed:
		progression = 0
		# The boss has no chance. It either appears or not when it has 100 repressed pathos
		if pathos_entry == Terms.RUN_ACCUMULATION_NAMES.boss:
			continue
		if include_next_progression:
			progression += progressions[pathos_entry].back()
		var pathos_entry_total : float = repressed[pathos_entry] + progression
		pathos_entry_total += mod_pathos_dict.get(pathos_entry,0)
		if pathos_entry_total < 0:
			pathos_entry_total = 0
		if pathos_entry_total >= get_threshold(pathos_entry):
#			print_debug(pathos_entry, repressed[pathos_entry] + progression)
			total += pathos_entry_total
	progression = mod_pathos_dict.get(entry,0)
	if include_next_progression:
		progression += progressions[entry].back()
	var entry_total : float = repressed[entry] + progression
	if entry_total < 0:
		entry_total = 0
	var chance: int
	if entry_total >= get_threshold(entry):
		chance = int(round(entry_total / total * 100))
	else:
		chance = 0
#	print_debug([entry, mod_pathos_dict.get(entry,0), entry_total, total,chance])
	return(chance)

func get_boss_threshold() -> float:
	return(thresholds[Terms.RUN_ACCUMULATION_NAMES.boss]
			* get_progression_average(Terms.RUN_ACCUMULATION_NAMES.boss))


func extract_save_state() -> Dictionary:
	var pathos_dict := {
		"repressed": repressed,
		"released": released,
	}

	return(pathos_dict)


func restore_save_state(save_state: Dictionary) -> void:
	var pathos_dict := {
		"repressed": repressed,
		"released": released,
	}
	repressed = save_state.repressed
	released = save_state.released


func convert_to_shop() -> int:
	var total : float = 0
	var baseline : float = 5 # I.e. we're going to normalize each pathos type, as if we're earning 5 of it per turn
	for pathos_type in repressed.keys():
		var adjustment = baseline / get_progression_average(pathos_type)
		total += released.get(pathos_type,0) * adjustment
#	print_debug([total, adjustments])
	return(int(ceil(total)))


# Spends pathos as generic currency, then distributes the exact amount spent to the various
# types proportionally
func spend_generic_pathos(amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: spend_pathos() only takes a positive integer")
		return
	var total : float
	for pathos_type in repressed.keys():
		total += released.get(pathos_type,0)
	# To avoid div/0
	if total <= 0:
		return
	var baseline : float = 5 # I.e. we're going to normalize each pathos type, as if we're earning 5 of it per turn
	for pathos_type in repressed.keys():
		var adjustment = baseline / get_progression_average(pathos_type)
		var percentage = released.get(pathos_type,0) / total
		released[pathos_type] -= amount * percentage / adjustment
#	print_debug([amount,released])
	emit_signal("generic_pathos_spent", amount)

func get_shop_baseline_average() -> float:
	var total : float = 0
	var baseline : float = 6 # I.e. we're going to normalize each pathos type, as if we're earning 5 of it per turn
	for pathos_type in Terms.RUN_ACCUMULATION_NAMES.values():
		if pathos_type == Terms.RUN_ACCUMULATION_NAMES.boss:
			continue
#		baseline := get_progression_average(pathos_type) # Trying a standard baseline instead
		total += baseline
	return(total)
