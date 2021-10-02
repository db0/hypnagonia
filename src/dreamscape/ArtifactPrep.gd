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
		for r in [rare, uncommon, common]:
			var rcount = all_valid_artifacts[r.rarity].size()
			# We populate a massive list with one artifact of each type per chance. 
			# For example, if we have 3% to get a rare artifact and a 6% chance to get an uncommon artifact
			# Then we add 3 random rare artifacts in the list, 6 uncommon artifacts in the list
			# and 91 common artifacts. The same artifact might be more than once in the list
			for _index in range(r.chance):
				randomized_artifacts.append(all_valid_artifacts[r.rarity][CFUtils.randi_range(0,rcount - 1)])
		# Finally we shuffle the list of all artifacts of all rarities and store it in a variable
		# Grabbing the last artifact in that list ensures we have the correct percentage chance to get
		# an artifact of any rarity.
		CFUtils.shuffle_array(randomized_artifacts)
		var current_artifact = randomized_artifacts.pop_back()
		var bbcode_formats = Terms.get_bbcode_formats(18)
		bbcode_formats["artifact_name"] = current_artifact["name"]
		var amounts_formats = current_artifact.get("amounts")
		# This key is used when the description is displayed in the Journal as an
		# artifact reward after an elite or boss
		current_artifact["bbdescription"] = current_artifact.description.format(bbcode_formats).format(amounts_formats)
		# This key is used when the artifact is being displayed in-line in the
		# artifact NCE
		current_artifact["bbformat"] = {
			"icon": current_artifact.icon.resource_path,
			"description": current_artifact.description.format(bbcode_formats).format(amounts_formats)
		}
		selected_artifacts.append(current_artifact)
		# We remove the selected artifact from the future choices during this run
		# To avoid selecting it again
		all_valid_artifacts[current_artifact["rarity"]].erase(current_artifact["name"])
