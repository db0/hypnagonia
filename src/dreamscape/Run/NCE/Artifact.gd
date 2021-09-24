extends NonCombatEncounter

# This variable is set equal to the player's artifact pathos,
# and stores it until the random seleciton is made
# The higher this value, the higher the chance for a rarer artifact.
var accumulated := 0
var randomized_artifacts := []
var current_artifact : Dictionary

var secondary_choices := {
		'grab': '',
		'recall': '...or was it something different? I dove deeper into dangerous memories to remember...',
		'avoid': '...but I decided to not stir my deepest fears.',
	}


func _init():
	description = "I recall I had specific curio with me, but I struggle to remember what. This recollection is painful..."

func begin() -> void:
	accumulated = globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.artifact]
# warning-ignore:return_value_discarded
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.artifact)
	_randomize_artifacts()
	.begin()
#	globals.journal.display_rewards('')
	var bbformat = prepare_artifact()
	secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
			+"[i](Making this choice will also put a random perturbation in your deck)[/i]"
	globals.journal.add_nested_choices(secondary_choices)
	
func continue_encounter(key) -> void:
	match key:
		"grab": 
			globals.player.add_artifact(current_artifact.canonical_name)
			globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
					globals.player.get_archetype_perturbations()))
			globals.journal.display_rewards('')
		"grab_second": 
			globals.player.add_artifact(current_artifact.canonical_name)
			globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
					globals.player.get_archetype_perturbations()))
			globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
					globals.player.get_archetype_perturbations()))
			globals.journal.display_rewards('')
		"avoid": 
			globals.journal.display_rewards('')
		"recall":
			var bbformat = prepare_artifact()
			var alternate_artifact_choices = {
				"grab_second": "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
						+"[i](Making this choice will also put 2 random perturbations in your deck)[/i]",
				"avoid": "...but the emotional load was too much."
			}
			globals.journal.add_nested_choices(alternate_artifact_choices)


# Grabs a new artifact from the shuffled artifacts to display to the player
# and return a string format dictionary to use in its description
func prepare_artifact() -> Array:
	current_artifact = randomized_artifacts.pop_back()
	var bbcode_formats = Terms.get_bbcode_formats(18)
	bbcode_formats["artifact_name"] = current_artifact["name"]
	var amounts_formats = current_artifact.get("amounts")
	var bbformat = {
		"icon": current_artifact.icon.resource_path,
		"description": current_artifact.description.format(bbcode_formats).format(amounts_formats)
	}
	return(bbformat)

func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"grab": 
			return('')
		_:
			return('')

func _randomize_artifacts() -> void:
# warning-ignore:integer_division
	var rare = {"rarity": "Rare", "chance": accumulated/2}
	var uncommon = {"rarity": "Uncommon", "chance": accumulated}
	var common_chance = 100 - rare.chance - uncommon.chance
	if common_chance < 0:
		common_chance = 0
	var common = {"rarity": "Common", "chance": common_chance}
	# We gather all artifacts valid for each rarity and shuffle each of those individual lists
	var owned_artifacts = globals.player.get_all_artifact_names()
	var all_valid_artifacts = ArtifactDefinitions.get_organized_artifacts(
			"generic", 
			globals.player.get_archetype_artifacts(),
			owned_artifacts)
	# Debug
#	var aa = {}
#	for r in all_valid_artifacts:
#		aa[r] = []
#		for a in all_valid_artifacts[r]:
#			aa[r].append(a.name)
#	print_debug(aa)
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
