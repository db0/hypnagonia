extends NonCombatEncounter

const MASTERIES_AMOUNT := 3
const journal_description = "I seemed to be surrounded by monsters but for some reason, they were friendly to me. "\
			+ "I realized I am in a train and am prepared to drive "\
			+ "through the forces of Order to revive the Heart of Hell itself!\n"\
			+ "Did I lead, or did I follow?"

var artifact_prep : ArtifactPrep
var testing_rng := 0


var secondary_choices := {
		'lead': '[Lead]: {bcolor:+15:} {anxiety_up}. 60% chance to {gcolor:gain a random curio:}.',
		'follow': '[Follow]: {bcolor:+7:} {anxiety_up}. {gcolor:{masteries_amount} {masteries}:}.',
		'abort': '[Abort]: Gain {bcolor:moderate {repressed_elite}:} .',
	}

var nce_result_fluff := {
		'lead': "I am this train's leader. The monsters all look up to me. "\
			+ "I want to see what lies at the center of hell!",
		'follow': "I realized I am just one of the monsters myself, and I did "\
			+ "my duty among others, to see the train through.",
		'abort': "I am not meant to be here, but I can't shake the feeling "\
			+ "that not helping out will come to haunt me later...",
	}


func _init():
	introduction.setup_with_vars("Monster Train",journal_description, "")
	prepare_journal_art(load("res://assets/journal/nce/monster_train.jpeg"))

func begin() -> void:
	# warning-ignore:return_value_discarded
	.begin()
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	scformat["masteries_amount"] = MASTERIES_AMOUNT
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"lead":
			globals.player.damage += 15
			var artifact_roll = CFUtils.randi_range(1,100)
			if testing_rng:
				artifact_roll = testing_rng
			if artifact_roll <= 60:
				artifact_prep = ArtifactPrep.new(5, 20, 1)
				nce_result_fluff['lead'] += "\nThrough your leadership, this train of monsters succeeds "\
						+ "in reaching the heart of hell, {curio}:"
				var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, "and you take it as your own reward")}
				nce_result_fluff['lead'] = nce_result_fluff['lead'].format(fmt)
				globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			else:
				nce_result_fluff['lead'] += "\nYou try to lead this train, but you quickly realize you're out of your depth. "\
						+ "The forces of Order soon overwhelmed your band."
		"follow":
			globals.player.damage += 7
			globals.player.pathos.available_masteries += MASTERIES_AMOUNT
		"abort":
			# warning-ignore:narrowing_conversion
			var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]
			pathos_type.repressed += pathos_type.get_progression_average() * 2.0
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
