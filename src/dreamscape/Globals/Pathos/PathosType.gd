class_name PathosType
extends Reference


# The main pathos object. 
# This acts as an EventBus for the signals of this class.
var pathos
# The thematic name of this type
var name: String
var type
var repressed: float setget _set_repressed
var released: float setget _set_released
# How much each repressed pathos can increase per journal page
var progression: Array
# Thresholds specify how many multiples of the pathos average are needed
# before that encounter is an option as an encounter.
# Effectively ~on average~ is limits a type of encounter to appearing
# every X times.
var threshold: float
# Modifies the amount of progression gained per journal page
var progression_modifier: float = 1.0 setget ,get_progression_modifier
# Holds objects which dynamically modify how much repression this pathos gais per turn
# Each object in this array needs to have the get_pathos_progression_modifier() function
var progression_modifying_objects := []
# How many of the average multiples is needed to level up that pathos
var released_needed_for_level: float
# If any effect makes the next mastery take longer, this is stored here
# and wiped when the next mastery is achieved
var temp_modification_for_next_level: float
# If any effect makes the next mastery take longer or shorter time, this is stored here
var perm_modification_for_next_level: float
# How many times this pathos has been leveled up
var level: int
# How many masteries the player receives to spend in the shop per level gained.
var masteries_when_chosen := 0
var skipped: int


func _init(_pathos) -> void:
	pathos = _pathos


func _set_repressed(value: float, restore = false) -> void:
	# If send with the restore flag, we don't want to send any signals
	if restore:
		repressed = value
		return
	modify_repressed(value - repressed)


func _set_released(value: float, restore = false) -> void:
	# If send with the restore flag, we don't want to send any signals
	if restore:
		released = value
		return
	modify_released(value - released)


# modifies the specified repressed pathos by a given amount
func modify_repressed(value: float, is_lost := false) -> void:
	repressed += value
	if repressed < 0:
		repressed = 0
	if value > 0:
		pathos.emit_signal("pathos_repressed", name, value)
	elif is_lost:
		pathos.emit_signal("repressed_pathos_lost", name, -value)


# reduces the repression by a given amount
# and increases the release by the same amount
func modify_released(value: float, is_lost := false) -> void:
	released += value
	if released < 0:
		released = 0.0
	if value > 0:
		pathos.emit_signal("released_pathos_gained", name, value)
	elif is_lost:
		pathos.emit_signal("released_pathos_lost", name, -value)
	else:
		pathos.emit_signal("pathos_spent", name, -value)
# warning-ignore:return_value_discarded
	check_for_level_up()


# Increases by a random amount of the progression array
# This is called every time a new journal page is turned
func repress() -> void:
	var amount = get_progression()
	modify_repressed(amount)


# reduces the specified repressed pathos by a given amount
# and increases the released pathos by the same amount
func release(amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: release_pathos() only takes a positive integer")
		return
	# if we try to repress more than we have, we repress only as much as we have
	if amount > repressed:
		amount = repressed
	modify_repressed(-amount)
	modify_released(amount)
	pathos.emit_signal("pathos_released", name, amount)


func get_release_amount() -> float:
	var release_amount := get_threshold()
	return(release_amount)


func get_final_release_amount() -> int:
	var release_amount = get_release_amount()
	if release_amount > repressed:
		release_amount = repressed
	return(int(round(release_amount)))


# Used when this choice is selected. 
# The amount of pathos in the threshold is converted into released
func select() -> void:
	var release_amount = get_final_release_amount()
	release(release_amount)
	skipped = 0
	pathos.emit_signal("pathos_selected", name)


# Used when this choice is ignore when it exists
# The amount of pathos in the threshold is converted into lost 
# and skipped is incremente by 1
func ignore() -> void:
	var release_amount = get_final_release_amount()
	modify_repressed(-release_amount)
	skipped += 1
	pathos.emit_signal("pathos_ignored", name)


func check_for_level_up() -> bool:
	var leveled_up := false
	while released > get_level_requirement():
		released -= get_level_requirement()
		leveled_up = true
		level_up()
	return(leveled_up)


func level_up() -> void:
	level += 1
	# When a level up happens, any temp modifications are removed
	temp_modification_for_next_level = 0.0
	pathos.emit_signal("pathos_leveled", name, level)


func get_progress_pct() -> float:
	return(released / get_level_requirement())


func convert_released_num_to_pct(amount: float) -> float:
	return(amount / get_level_requirement())


func get_level_requirement() -> float:
	return(
			(
				get_progression_average()
				* released_needed_for_level
			)
			+ temp_modification_for_next_level\
			+ perm_modification_for_next_level
	)


func convert_pct_to_released(pct: float) -> float:
	return(get_level_requirement() * pct)


func temp_modify_requirements_for_level(amount: int) -> void:
	# The amount we is an integer, and we want to normalize it based on how fast
	# each pathos type progresses.
	# I.e. the same temp modifier for a pathos that is gained faster
	# will be higher than for a pathos that is gained slower.
	var normalized = 1.0 / (10.0 / get_progression_average())
	temp_modification_for_next_level =\
			temp_modification_for_next_level + normalized * amount
	# warning-ignore:return_value_discarded
	check_for_level_up()


func perm_modify_requirements_for_level(amount: int) -> void:
	# The amount we is an integer, and we want to normalize it based on how fast
	# each pathos type progresses.
	# I.e. the same perm modifier for a pathos that is gained faster
	# will be higher than for a pathos that is gained slower.
	var normalized = 1.0 / (10.0 / get_progression_average())
	perm_modification_for_next_level =\
			perm_modification_for_next_level + normalized * amount
	# warning-ignore:return_value_discarded
	check_for_level_up()


# reduces the specified released pathos by a given amount
func spend_pathos(amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: spend_pathos() only takes a positive integer")
		return
	modify_released(-amount)


# reduces the specified released pathos by a given amount
func lose_repressed_pathos(amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: lose_repressed_pathos() only takes a positive integer")
		return
	modify_repressed(-amount, true)
	


# reduces the specified released pathos by a given amount
func lose_released_pathos(amount: float) -> void:
	if amount <= 0:
		printerr("ERROR: lose_released_pathos() only takes a positive integer")
		return
	modify_released(-amount, true)


# Returns one random possible progression from the range
# Grabbing the number via a fuction, rather than directly from the var
# allows us to modify this via artifacts during runtime
func get_progression() -> float:
	var rand_array : Array = progression.duplicate()
	CFUtils.shuffle_array(rand_array)
	var rng_progression :float = rand_array[0] * get_progression_modifier()
	if name == "frustration":
		print_debug([rng_progression,rand_array[0],get_progression_modifier()])
	return(rng_progression)


# Returns the average value of the progression specified
func get_progression_average() -> float:
	var total: float = 0
	for p in progression:
		total += p
	return(total / progression.size())


# Returns the threshold required to encounter events of this pathos
func get_threshold() -> float:
	return(get_progression_average() * threshold)


# Adds an initial amount of released pathos during startup
func add_startup_rng_release() -> void:
	released += get_progression_average() * CFUtils.randf_range(3,5)


func get_progression_modifier() -> float:
	var updated_modifiers: float = 0.0
	for object in progression_modifying_objects:
		updated_modifiers += object.get_pathos_progression_modifier()
	return(progression_modifier + updated_modifiers)
