extends NonCombatEncounter

# This variable is set equal to the player's artifact pathos,
# and stores it until the random seleciton is made
# The higher this value, the higher the chance for a rarer artifact.
var accumulated := 0
var randomized_artifacts := []
var artifact_prep : ArtifactPrep

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
	# The rarity of artifact found is based on the accumulated pathos
	# warning-ignore:integer_division
	artifact_prep = ArtifactPrep.new(accumulated/2, accumulated, 2)
	.begin()
#	globals.journal.display_nce_rewards('')
	var bbformat = artifact_prep.selected_artifacts[0]["bbformat"]
	secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}.".format(bbformat)
#	secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
#			+"[i](Making this choice will also put a random perturbation in your deck)[/i]"
	globals.journal.add_nested_choices(secondary_choices)
	
func continue_encounter(key) -> void:
	match key:
		"grab": 
			globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			# Decided to have 0/1 perturbations on basic difficulty. 
			# When we add difficulty levels, it will be 1/2
#			globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
#					globals.player.get_archetype_perturbations()))
			globals.journal.display_nce_rewards('')
		"grab_second": 
			globals.player.add_artifact(artifact_prep.selected_artifacts[1].canonical_name)
			# warning-ignore:return_value_discarded
			globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
					globals.player.get_archetype_perturbations()))
#			globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
#					globals.player.get_archetype_perturbations()))
			globals.journal.display_nce_rewards('')
		"avoid": 
			globals.journal.display_nce_rewards('')
		"recall":
			var bbformat = artifact_prep.selected_artifacts[1]["bbformat"]
			var alternate_artifact_choices = {
				"grab_second": "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
						+"[i](Making this choice will also put 1 random perturbation in your deck)[/i]",
				"avoid": "...but the emotional load was too much."
			}
			globals.journal.add_nested_choices(alternate_artifact_choices)

func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"grab": 
			return('')
		_:
			return('')
