# Description TBD

extends NonCombatEncounter

const SHADER := preload("res://shaders/Roscharch.shader")

var secondary_choices := {
		'passion fruit': '[An Apple]: Gain some released {artifact}.',
		'orange': '[An Orange]:  Gain some released {elite}.',
		'banana': '[A Banana]: Gain some released {shop}.',
	}

var nce_resul_fluff := "[i]I understand. You're {adjective} your {noun}.[/i]"

var mad_lib_adjectives = [
	"deeply worried about",
	"very excited about",
	"secretly shameful of",
]
var mad_lib_nouns = [
	"dieting habits",
	"phobias",
	"night activities",
	"romance novels",
]

func _init():
	description = "I was rushing to my second appointment with the Pop Psychologist.\n"\
			+ "I took a seat in an overly [color=#FF0038]carmine fainting couch[/color].\n\n"\
			+ "[i]How have you been doing since your last visit? We should to revisit the Rorschach test.\n"\
			+ "What do you see in this picture?[/i]\n\n"\
			+ "My eyes were getting tired from straining..."

func begin() -> void:
	.begin()
	var _shader_params := {
		'tint': HUtils.rnd_color(true, 255),
		'time_offset': CFUtils.randf_range(0, 10000)
	}
	prepare_shader_art(SHADER, _shader_params)
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	for choice in secondary_choices:
		secondary_choices[choice] = secondary_choices[choice].format(scformat)
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	match key:
		"passion fruit":
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.artifact)
					* 5 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.modify_released_pathos(Terms.RUN_ACCUMULATION_NAMES.artifact, released_reward)
		"orange":
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.elite)
					* 3 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.modify_released_pathos(Terms.RUN_ACCUMULATION_NAMES.elite, released_reward)
		"banana":
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.shop)
					* 5 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.modify_released_pathos(Terms.RUN_ACCUMULATION_NAMES.shop, released_reward)
	CFUtils.shuffle_array(mad_lib_adjectives)
	CFUtils.shuffle_array(mad_lib_nouns)
	var adlib_format = {
		"adjective": mad_lib_adjectives[0],
		"noun": mad_lib_nouns[0],
	}
	globals.encounters.run_changes.unlock_nce("PopPsychologist3", "easy")
	end()
	globals.journal.display_nce_rewards(nce_resul_fluff.format(adlib_format))
