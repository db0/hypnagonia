# Description TBD
extends NonCombatEncounter


var secondary_choices := {
		'destroy': '[Destroy the workshop]: [color=#33FF33]Gain {destroy_amount} {released_boss}[/color].',
		'leave': '[Leave the alone]: [color=#FF3333]Gain {leave_amount} {repressed_elite}[/color].',
	}

	
var nce_result_fluff := {
		'destroy': "I took it out on their workshop. I smashed the porcelain dolls. "\
			+ "I broke the workbenches. I threw the iron tools into the lake. "\
			+ "My rage felt unending.",
		'leave': 'With difficulty, I swallowed my rage and moved on. Would there be consequences...',
	}

var amounts := {}


func _init():
	description = "I was standing on top of a dollmaker cowering on the floor.\n\n" \
			+ "I was upset. I don't know why, but I was very angry.\n"\
			+ "What did I do..?"
	prepare_journal_art(load("res://assets/journal/nce/dollmaker.jpeg"))

func begin() -> void:
	.begin()
	amounts["destroy_amount"] = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.boss)
					* 3 * CFUtils.randf_range(0.8,1.2))
	amounts["leave_amount"] = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.elite)
					* 4 * CFUtils.randf_range(0.8,1.2))
	var scformat := {}
	scformat["destroy_amount"] = amounts["destroy_amount"]
	scformat["leave_amount"] = amounts["leave_amount"]
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"destroy":
			globals.player.pathos.modify_released_pathos(
					Terms.RUN_ACCUMULATION_NAMES.boss, 
					amounts["destroy_amount"])
		"leave":
			globals.player.pathos.repress_pathos(
					Terms.RUN_ACCUMULATION_NAMES.elite, 
					amounts["leave_amount"])
			globals.encounters.run_changes.unlock_nce("DollPickup", "easy")
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
