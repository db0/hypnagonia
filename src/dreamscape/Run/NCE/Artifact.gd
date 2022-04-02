class_name ArtifactEncounter
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
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.artifact

func begin() -> void:
	accumulated = globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.artifact]
	# The rarity of artifact found is based on the accumulated pathos
	# warning-ignore:integer_division
	artifact_prep = ArtifactPrep.new(accumulated/2, accumulated, 2)
	.begin()
#	globals.journal.display_nce_rewards('')
	var bbformat = artifact_prep.selected_artifacts[0]["bbformat"]
	secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}.".format(bbformat)
	if globals.difficulty.desire_curios_give_perturbation:
		secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
				+"[i](Making this choice will also put a random perturbation in your deck)[/i]"
	globals.journal.add_nested_choices(secondary_choices)
	
func continue_encounter(key) -> void:
	match key:
		"grab": 
			# warning-ignore:return_value_discarded
			var reward_text = ''
			globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			if globals.difficulty.desire_curios_give_perturbation:
				var new_card = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
						globals.player.get_archetype_perturbations()))
				var ptformat = {
					"perturbation_text": _prepare_card_popup_bbcode(new_card.card_name, "created an unstable state for myself"),
				}
				reward_text = "Making these waves {perturbation_text}".format(ptformat)
			end()
			globals.journal.display_nce_rewards(reward_text)
		"grab_second": 
			# warning-ignore:return_value_discarded
			globals.player.add_artifact(artifact_prep.selected_artifacts[1].canonical_name)
			# warning-ignore:return_value_discarded
			var new_card = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
					Perturbations.get_archetype_perturbations_chance()))
			var ptformat = {
				"perturbation_text": _prepare_card_popup_bbcode(new_card.card_name, "disturbed me"),
				"perturbation_text2": '',
			}
			if globals.difficulty.desire_curios_give_perturbation:
				var new_card2 = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
						globals.player.get_archetype_perturbations()))
				ptformat["perturbation_text2"] = _prepare_card_popup_bbcode(new_card2.card_name, " and shook something loose")
			var reward_text = "I dug deeper into my own throughts to retrieve it. The experience {perturbation_text}{perturbation_text2}.".format(ptformat)
			end()
			globals.journal.display_nce_rewards(reward_text)
		"avoid":
			end()
			globals.journal.display_nce_rewards('')
		"recall":
			var bbformat = artifact_prep.selected_artifacts[1]["bbformat"]
			var alternate_artifact_choices = {
				"grab_second": "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
						+"[i](Making this choice will also put 1 random perturbation in your deck)[/i]",
				"avoid": "...but the emotional load was too much."
			}
			if globals.difficulty.desire_curios_give_perturbation:
				alternate_artifact_choices = {
					"grab_second": "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
							+"[i](Making this choice will also put 2 random perturbations in your deck)[/i]",
					"avoid": "...but the emotional load was too much."
				}				
			globals.journal.add_nested_choices(alternate_artifact_choices)

func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"grab": 
			return('')
		_:
			return('')
