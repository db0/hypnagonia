class_name ArtifactEncounter
extends NonCombatEncounter

const journal_description = "I recall I had specific {artifact} with me, but I struggle to remember what. This recollection is painful..."
const ai_prompts:= [
	"I recall I had specific plushie with me, but I struggle to remember what",
	"What a strange little bauble this is. How did it end up here",
]

var randomized_artifacts := []
var artifact_prep : ArtifactPrep
var perturbation_chance := 0.6
var pathos_type: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]

var secondary_choices := {
		'grab': '',
		'recall': '...or was it something different? I dove deeper into dangerous memories to remember...',
		'avoid': '...but I decided to not stir my deepest fears.',
	}


func _init():
	introduction.setup_with_vars("Curio", journal_description, "A Random Discovery",ai_prompts)
	introduction.max_length = 50
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.artifact

func begin() -> void:
	var luck_up = globals.player.find_artifact(ArtifactDefinitions.ReduceCurioRerollPerturbChance.canonical_name)
	if luck_up:
		perturbation_chance *= ArtifactDefinitions.ReduceCurioRerollPerturbChance.amounts.chance_multiplier
	var rare_chance = 5 * skipped
	var uncommon_chance = 5 * skipped
	# The rarity of artifact found is based on the accumulated pathos
	# warning-ignore:integer_division
	artifact_prep = ArtifactPrep.new(rare_chance, uncommon_chance, 2)
	.begin()
#	globals.journal.display_nce_rewards('')
	var bbformat = artifact_prep.selected_artifacts[0]["bbformat"]
	bbformat["chance_percent"] = perturbation_chance * 100
	secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}."
	if globals.difficulty.desire_curios_give_perturbation:
		secondary_choices['grab'] = "[img=18x18]{icon}[/img] {description}.\n"\
				+"[i](Making this choice has a {chance_percent}% chance to put a random perturbation in your deck)[/i]"
	secondary_choices["grab"] = secondary_choices["grab"].format(bbformat)
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	match key:
		"grab":
			# warning-ignore:return_value_discarded
			var reward_text = ''
			globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			if globals.difficulty.desire_curios_give_perturbation:
				var perturb_rng = CFUtils.randf_range(0.0, 1.0)
				if perturb_rng <= perturbation_chance:
					var new_card = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
							globals.player.get_archetype_perturbations()))
					var ptformat = {
						"perturbation_text": _prepare_card_popup_bbcode(new_card.card_name, "created an unstable state for myself"),
					}
					reward_text = "Making these waves {perturbation_text}".format(ptformat)
			var cursed_curios = globals.player.find_artifact(ArtifactDefinitions.CursedCurios.canonical_name)
			if cursed_curios:
				var new_card = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
						globals.player.get_archetype_perturbations()))
				var ptformat = {
					"cursed_perturbation": _prepare_card_popup_bbcode(new_card.card_name, "made things even worse"),
					"cursed_curios_name": cursed_curios.definition.name,
				}
				reward_text += "\n{cursed_curios_name}: {cursed_perturbation}".format(ptformat)
			end()
			globals.journal.display_nce_rewards(reward_text)
		"grab_second":
			# warning-ignore:return_value_discarded
			globals.player.add_artifact(artifact_prep.selected_artifacts[1].canonical_name)
			# warning-ignore:return_value_discarded
			var ptformat = {
				"perturbation_text": 'left me unshaken',
				"perturbation_text2": '',
			}
			var perturb_rng = CFUtils.randf_range(0.0, 1.0)
			if perturb_rng <= perturbation_chance:
				var new_card = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
						Perturbations.get_archetype_perturbations_chance()))
				ptformat["perturbation_text"] = _prepare_card_popup_bbcode(new_card.card_name, "disturbed me")
			if globals.difficulty.desire_curios_give_perturbation:
				perturb_rng = CFUtils.randf_range(0.0, 1.0)
				if perturb_rng <= perturbation_chance:
					var new_card2 = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
							globals.player.get_archetype_perturbations()))
					if ptformat["perturbation_text"] == '':
						ptformat["perturbation_text"] = _prepare_card_popup_bbcode(new_card2.card_name, "disturbed me")
					else:
						ptformat["perturbation_text2"] = _prepare_card_popup_bbcode(new_card2.card_name, " and shook something loose")
			var reward_text = "I dug deeper into my own throughts to retrieve it. The experience {perturbation_text}{perturbation_text2}.".format(ptformat)
			var cursed_curios = globals.player.find_artifact(ArtifactDefinitions.CursedCurios.canonical_name)
			if cursed_curios:
				var new_card = globals.player.deck.add_new_card(Perturbations.get_random_perturbation(
						globals.player.get_archetype_perturbations()))
				var cformat = {
					"cursed_perturbation": _prepare_card_popup_bbcode(new_card.card_name, "made things even worse"),
					"cursed_curios_name": cursed_curios.definition.name,
				}
				reward_text += "\n{cursed_curios_name} {cursed_perturbation}.".format(cformat)
			end()
			globals.journal.display_nce_rewards(reward_text)
		"avoid":
			end()
			globals.journal.display_nce_rewards('')
		"recall":
			var bbformat = artifact_prep.selected_artifacts[1]["bbformat"]
			bbformat["chance_percent"] = perturbation_chance * 100
			bbformat["double_perturbation_percent"] = round(perturbation_chance * perturbation_chance * 100)
			bbformat["zero_perturbation_percent"] = round((1 - perturbation_chance) * (1 - perturbation_chance) * 100)
			bbformat["single_perturbation_percent"] = 100 - bbformat["zero_perturbation_percent"]
			var alternate_artifact_choices = {
				"grab_second": "[img=18x18]{icon}[/img] {description}.\n".format(bbformat)\
						+"[i](Making this choice has a {chance_percent}% chance to  put 1 random perturbation in your deck)[/i]",
				"avoid": "...but the emotional load was too much."
			}
			if globals.difficulty.desire_curios_give_perturbation:
				alternate_artifact_choices["grab_second"] ="[img=18x18]{icon}[/img] {description}.\n"\
						+"[i](Making this choice has a {single_perturbation_percent}% chance to put at least"\
						+ " one random perturbations in your deck ({zero_perturbation_percent}%"\
						+ " to put none), and a extra {double_perturbation_percent}% chance to put two)[/i]"
			alternate_artifact_choices["grab_second"] = alternate_artifact_choices["grab_second"].format(bbformat)
			globals.journal.add_nested_choices(alternate_artifact_choices)

func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"grab":
			return('')
		_:
			return('')
