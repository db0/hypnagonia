# Description TBD
extends NonCombatEncounter

const DESTROY_PCT  := 0.5
const MASTERIES_AMOUNT := 4

var secondary_choices := {
		'destroy': '[Destroy the workshop]: Gain {gcolor:{destroy_amount} {masteries}:}.',
		'leave': '[Leave the alone]: {bcolor:Increase {repressed_elite}:}.',
	}

	
var nce_result_fluff := {
		'destroy': "I took it out on their workshop. I smashed the porcelain dolls. "\
			+ "I broke the workbenches. I threw the iron tools into the lake. "\
			+ "My rage felt unending.",
		'leave': 'With difficulty, I swallowed my rage and moved on. Would there be consequences...',
	}


var pathos_type_leave = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]

func _init():
	description = "I was standing on top of a dollmaker cowering on the floor.\n\n" \
			+ "I was upset. I don't know why, but I was very angry.\n"\
			+ "What did I do..?"
	prepare_journal_art(load("res://assets/journal/nce/dollmaker.jpeg"))

func begin() -> void:
	.begin()
	var scformat := {}
	scformat["destroy_amount"] = floor(DESTROY_PCT * 100)
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"destroy":
			globals.player.pathos.available_masteries += MASTERIES_AMOUNT
		"leave":
			pathos_type_leave.repressed += round(
					pathos_type_leave.get_progression_average()
					* 4 * CFUtils.randf_range(0.8,1.2))
			globals.encounters.run_changes.unlock_nce("DollPickup", "easy")
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
