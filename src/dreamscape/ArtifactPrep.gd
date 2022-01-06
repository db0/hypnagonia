class_name ArtifactPrep
extends Reference

# The currently selected artifacts
var selected_artifacts := []


# Prepares the right amount of artifacts based on the rarity chances provided
# Stores the options in selected_artifacts list
func _init(rare_percent: int, uncommon_percent: int, amount := 1, artifact_type := "generic") -> void:
# warning-ignore:integer_division
	var rare = {"rarity": "Rare", "chance": rare_percent}
	var uncommon = {"rarity": "Uncommon", "chance": uncommon_percent}
	# The chance for a common artifact is equal to 100 - uncommon - rare
	var common_chance = 100 - rare.chance - uncommon.chance
	if common_chance < 0:
		common_chance = 0
	var common = {"rarity": "Common", "chance": common_chance}
	# We gather all artifacts valid for each rarity
	var all_valid_artifacts = ArtifactDefinitions.get_organized_artifacts(
			artifact_type,
			globals.player.get_archetype_artifacts(),
			globals.player.get_all_artifact_names())
	# Debug
#	var aa = {}
#	for r in all_valid_artifacts:
#		aa[r] = []
#		for a in all_valid_artifacts[r]:
#			aa[r].append(a.name)
#	print_debug(aa)
	for _iter in range(amount):
		var randomized_artifacts := []
		if artifact_type == "boss":
			randomized_artifacts = all_valid_artifacts['Boss'].duplicate(true)
		else:
			for r in [rare, uncommon, common]:
				# We populate a massive list with one artifact of each type per chance.
				# For example, if we have 3% to get a rare artifact and a 6% chance to get an uncommon artifact
				# Then we add 3 random rare artifacts in the list, 6 uncommon artifacts in the list
				# and 91 common artifacts. The same artifact might be more than once in the list
				# But it will we will not get the same artifact more than 1 time more than any other artifact.
				# Eventually, as I populate the artifact lists, duplicates will be impossible
				var randomized_artifacts_of_rarity := []
				for _index in range(r.chance):
					if randomized_artifacts_of_rarity.size() == 0:
						randomized_artifacts_of_rarity = all_valid_artifacts[r.rarity].duplicate(true)
						CFUtils.shuffle_array(randomized_artifacts_of_rarity)
					randomized_artifacts.append(randomized_artifacts_of_rarity.pop_back())
		# Finally we shuffle the list of all artifacts of all rarities and store it in a variable
		# Grabbing the last artifact in that list ensures we have the correct percentage chance to get
		# an artifact of any rarity.
		CFUtils.shuffle_array(randomized_artifacts)
		var current_artifact = randomized_artifacts.pop_back()
		# We keep iterating until we find unique artifacts.
		while current_artifact["canonical_name"] in _get_names():
			# Extra check to avoid crashing due to not having enough designed artifacts
			if randomized_artifacts.size() == 0:
				return
			current_artifact = randomized_artifacts.pop_back()
		_add_artifact(current_artifact)
		# We remove the selected artifact from the future choices during this run
		# To avoid selecting it again
		all_valid_artifacts[current_artifact["rarity"]].erase(current_artifact)


# This allows the designer to inject specific artifacts into the randomized choices
# as well when needed
func append_artifact(artifact_canonical_name: String) -> void:
	var artifact_definition = ArtifactDefinitions.find_artifact_from_canonical_name(artifact_canonical_name)
	_add_artifact(artifact_definition)


func _add_artifact(current_artifact: Dictionary) -> void:
	var bbcode_formats = Terms.get_bbcode_formats(18)
	var artifact_format = ArtifactDefinitions.get_artifact_bbcode_format(current_artifact)
	# This key is used when the description is displayed in the Journal as an
	# artifact reward after an elite or boss
	current_artifact["bbdescription"] =\
			current_artifact.description.\
			format(bbcode_formats).\
			format(artifact_format)
	# This key is used when the artifact is being displayed in-line in the
	# artifact NCE
	current_artifact["bbformat"] = {
		"icon": current_artifact.icon.resource_path,
		"description": current_artifact.description.format(bbcode_formats).format(artifact_format)
	}
	selected_artifacts.append(current_artifact)

# Returns only the names of the current selected artifacts
func _get_names() -> Array:
	var anames := []
	for a in selected_artifacts:
		anames.append(a.canonical_name)
	return(anames)
