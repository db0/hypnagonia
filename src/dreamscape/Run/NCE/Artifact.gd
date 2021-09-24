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

const EXCLUDED_PERTURBATIONS := [
	"Dread"
]


func _init():
	description = "I recall I had specific curio with me, but I struggle to remember what. This recollection is painful..."

func begin() -> void:
	accumulated = globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.artifact]
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.artifact)
	_randomize_artifacts()
	.begin()
#	globals.journal.display_rewards('')
	current_artifact = randomized_artifacts.pop_back()
	var bbcode_formats = Terms.get_bbcode_formats(18)
	bbcode_formats["artifact_name"] = current_artifact["name"]
	var bbformat = {
		"icon": current_artifact.icon.resource_path,
		"description": current_artifact.description.format(bbcode_formats)
	}
	secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}.\n[i](Making this choice will also put a random perturbation in your deck)[/i]".format(bbformat)
	globals.journal.add_nested_choices(secondary_choices)
	
func continue_encounter(key) -> void:
	match key:
		"grab": 
			globals.player.add_artifact(current_artifact.canonical_name)
			globals.journal.display_rewards('')
		"avoid": 
			globals.journal.display_rewards('')
#		"rest": globals.journal.add_nested_choices({3: "Test1", 4: "Test2"})
#		"resist": globals.journal.add_nested_choices({5: "Test3", 6: "Test4"})

func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"grab": 
			return('')
		_:
			return('')

func _gather_perturbations() -> Array:
	var perturbations := []
	for card_name in cfc.card_definitions:
		if cfc.card_definitions[card_name].Type == "Perturbation"\
				and  not card_name in EXCLUDED_PERTURBATIONS:
			perturbations.append(card_name)
	return(perturbations)

func _randomize_artifacts(type := "generic") -> void:
	var rare = {"rarity": "Rare", "chance": accumulated/2}
	var uncommon = {"rarity": "Uncommon", "chance": accumulated}
	var common_chance = 100 - rare.chance - uncommon.chance
	if common_chance < 0:
		common_chance = 0
	var common = {"rarity": "Common", "chance": common_chance}
	# We gather all artifacts valid for each rarity and shuffle each of those individual lists
	var all_valid_artifacts = ArtifactDefinitions.get_organized_artifacts(type, _get_archetype_artifacts())
	for r in [rare, uncommon, common]:
		var rcount = all_valid_artifacts[r.rarity].size()
		# We populate a massive list with one artifact of each type per chance. 
		# For example, if we have 3% to get a rare artifact and a 6% chance to get an uncommon artifact
		# Then we add 3 random rare artifacts in the list, 6 uncommon artifacts in the list
		# and 91 common artifacts. The same artifact might be more than once in the list
		for index in range(r.chance):
			randomized_artifacts.append(all_valid_artifacts[r.rarity][CFUtils.randi_range(0,rcount - 1)])
	# Finally we shuffle the list of all artifacts of all rarities and store it in a variable
	# Grabbing the last artifact in that list ensures we have the correct percentage chance to get
	# an artifact of any rarity.
	CFUtils.shuffle_array(randomized_artifacts)

# Goes through all archetypes and gathers all artifacts specified
# Returns a list with all artifacts tied to all archetypes of the player.
func _get_archetype_artifacts() -> Array:
	var artifacts := []
	for arch in globals.player.get_currrent_archetypes():
		artifacts += Aspects.get_archetype_value(arch, "Artifacts")
	return(artifacts)
