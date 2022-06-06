# Description TBD
extends NonCombatEncounter


var secondary_choices := {
		'destroy': '[Destroy the workshop]: Gain {gcolor:{destroy_amount} {released_boss}:}.',
		'leave': '[Leave the alone]: Gain {bcolor:{leave_amount} {repressed_elite}:}.',
	}

	
var nce_result_fluff := {
		'destroy': "I took it out on their workshop. I smashed the porcelain dolls. "\
			+ "I broke the workbenches. I threw the iron tools into the lake. "\
			+ "My rage felt unending.",
		'leave': 'With difficulty, I swallowed my rage and moved on. Would there be consequences...',
	}

var amounts := {}

var pathos_type_destroy = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.boss]
var pathos_type_leave = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]

func _init():
	description = "I was standing on top of a dollmaker cowering on the floor.\n\n" \
			+ "I was upset. I don't know why, but I was very angry.\n"\
			+ "What did I do..?"
	prepare_journal_art(load("res://assets/journal/nce/dollmaker.jpeg"))

func begin() -> void:
	.begin()
	amounts["destroy_amount"] = round(
					pathos_type_destroy.get_progression_average()
					* 3 * CFUtils.randf_range(0.8,1.2))
	amounts["leave_amount"] = round(
					pathos_type_leave.get_progression_average()
					* 4 * CFUtils.randf_range(0.8,1.2))
	var scformat := {}
	scformat["destroy_amount"] = amounts["destroy_amount"]
	scformat["leave_amount"] = amounts["leave_amount"]
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"destroy":
			pathos_type_destroy.released += amounts["destroy_amount"]
		"leave":
			pathos_type_leave.repressed += amounts["leave_amount"]
			globals.encounters.run_changes.unlock_nce("DollPickup", "easy")
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
