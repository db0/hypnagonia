class_name MemoryPrep
extends Reference

# The currently selected memories
var selected_memories := []


# Prepares the right amount of memories as requested
# Stores the options in selected_memories list
func _init(amount := 1, limit_to_one_per_pathos := false) -> void:
	var all_valid_memories := MemoryDefinitions.get_memories(
			globals.player.get_archetype_memories(),
			globals.player.get_all_invalid_memory_names())
	# Debug
#	var aa = {}
#	for r in all_valid_artifacts:
#		aa[r] = []
#		for a in all_valid_artifacts[r]:
#			aa[r].append(a.name)
#	print_debug(aa)
	for _iter in range(amount):
		var randomized_memories := all_valid_memories.duplicate(true)
		CFUtils.shuffle_array(randomized_memories)
		var current_memory = randomized_memories.pop_back()
		# We keep iterating until we find unique memories.
		while current_memory["canonical_name"] in _get_names()\
				or (limit_to_one_per_pathos and current_memory.pathos in _get_pathos()):
			# Extra check to avoid crashing due to not having enough designed memories
			if randomized_memories.size() == 0:
				return
			current_memory = randomized_memories.pop_back()
		_add_memory(current_memory)
		# We remove the selected memory from the future choices during this run
		# To avoid selecting it again
		all_valid_memories.erase(current_memory)


# This allows the designer to inject specific artifacts into the randomized choices
# as well when needed
func append_memory(memory_canonical_name: String) -> void:
	var memory_definition = MemoryDefinitions.find_memory_from_canonical_name(memory_canonical_name)
	_add_memory(memory_definition)


func _add_memory(current_memory: Dictionary) -> void:
	var bbcode_formats = Terms.get_bbcode_formats(18)
	var memory_format = MemoryDefinitions.get_memory_bbcode_format(current_memory)
	# This key is used when the description is displayed in the Journal as an
	# artifact reward after an elite or boss
	current_memory["bbdescription"] =\
			current_memory.description.\
			format(bbcode_formats).\
			format(memory_format)
	# This key is used when the artifact is being displayed in-line in the
	# artifact NCE
	current_memory["bbformat"] = {
		"icon": current_memory.icon.resource_path,
		"description": current_memory.description.format(bbcode_formats).format(memory_format)
	}
	selected_memories.append(current_memory)

# Returns only the names of the current selected memories
func _get_names() -> Array:
	var mnames := []
	for m in selected_memories:
		mnames.append(m.canonical_name)
	return(mnames)


func _get_pathos() -> Array:
	var pathos := []
	for m in selected_memories:
		pathos.append(m.pathos)
	return(pathos)

