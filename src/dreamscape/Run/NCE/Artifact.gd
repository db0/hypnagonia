extends NonCombatEncounter

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
	description = "<Artifact WiP>"

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
	secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}".format(bbformat)
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

func _randomize_artifacts() -> void:
	var rare = {"rarity": "Rare", "chance": accumulated/2}
	var uncommon = {"rarity": "Uncommon", "chance": accumulated}
	var common = {"rarity": "Common", "chance": 100 - rare.chance - uncommon.chance}
	var shuffled_artifacts = ArtifactDefinitions.RARITIES.duplicate(true)
	for rarity in shuffled_artifacts:
		CFUtils.shuffle_array(shuffled_artifacts[rarity])
	for r in [rare, uncommon, common]:
		var rcount = shuffled_artifacts[r.rarity].size()
		for index in range(r.chance):
			randomized_artifacts.append(shuffled_artifacts[r.rarity][CFUtils.randi_range(0,rcount - 1)])
	CFUtils.shuffle_array(randomized_artifacts)
