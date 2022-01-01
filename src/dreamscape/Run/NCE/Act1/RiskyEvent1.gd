# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var artifact_prep: ArtifactPrep

var secondary_choices := {
		'accept': '[Accept]: 40% chance to gain a random curio. Become {perturbation}.',
		'decline': '[Decline]: Gain 10 {anxiety}. Lost some repressed {pathos}.',
	}

var nce_result_fluff := {
		'accept_success': 'Success: [url={"name": "curio","meta_type": "nce"}]{curio_name}[/url]',
		'accept_fail': "Luck was not with me this time",
		'decline': 'I decided not to risk it.',
	}

func _init():
	# TODO: Add story
	description = "<Risky Dream 1 - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Terror", "terrified"),
		"pathos": Terms.RUN_ACCUMULATION_NAMES.artifact,
	}
	secondary_choices['accept'] = secondary_choices['accept'].format(scformat)
	secondary_choices['decline'] = secondary_choices['decline'].format(scformat).format(Terms.get_bbcode_formats(18))
	globals.journal.add_nested_choices(secondary_choices, [])

func continue_encounter(key) -> void:
	var result: String
	if key == "accept":
		result = nce_result_fluff['accept_fail']
		var rngesus = CFUtils.randf_range(0.0,1.0)
		if rngesus <= 0.4:
			var accumulated = globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.nce] / 4
			artifact_prep = ArtifactPrep.new(accumulated/2, accumulated, 1)
			globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			result = nce_result_fluff['accept_success'].format({'curio_name': artifact_prep.selected_artifacts[0].canonical_name})
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Terror")
	else:
		result = nce_result_fluff['decline']
		globals.player.damage += 10
		var amount_lost =\
				globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.artifact)\
				* CFUtils.randf_range(0.8,1.2)
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.artifact, -amount_lost, true) 
	end()
	globals.journal.display_nce_rewards(result)

func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"curio":
			var bbformat = artifact_prep.selected_artifacts[0]["bbformat"]
			return("[img=18x18]{icon}[/img] {description}.".format(bbformat))
		_:
			return('')
