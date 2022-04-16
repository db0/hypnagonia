# Description TBD

extends NonCombatEncounter

const SHADER := preload("res://shaders/Roscharch.shader")

var secondary_choices := {
		'tiger': '[A Tiger]: Gain some {released_nce}.',
		'snake': '[A Snake]:  Gain some {released_enemy}.',
		'owl': '[An Owl]: Gain some {released_shop}.',
	}

var nce_resul_fluff := "[i]I see. You're {adjective} your {noun}.[/i]"

var mad_lib_adjectives = [
	"deeply afraid of",
	"in love with",
	"utterly disgusted with",
]
var mad_lib_nouns = [
	"mother",
	"father",
	"great uncle",
	"grandmother",
	"sibling",
]

func _init():
	description = "I was rushing to my first appointment with the Pop Psychologist.\n"\
			+ "I took a seat in an overly [color=red]red fainting couch[/color].\n\n"\
			+ "[i]So, today we are going to learn about you. We are going to do a Rorschach test. "\
			+ "What do you see in this picture?[/i]\n\n"\
			+ "Was the inkblot moving..?"

func begin() -> void:
	.begin()
	var _shader_params := {
		'tint': HUtils.rnd_color(true, 255),
		'time_offset': CFUtils.randf_range(0, 10000)
	}
	prepare_shader_art(SHADER, _shader_params)
	_prepare_secondary_choices(secondary_choices, {})

func continue_encounter(key) -> void:
	match key:
		"tiger":
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.nce)
					* 3 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.modify_released_pathos(Terms.RUN_ACCUMULATION_NAMES.nce, released_reward)
		"snake":
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.enemy)
					* 3 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.modify_released_pathos(Terms.RUN_ACCUMULATION_NAMES.enemy, released_reward)
		"owl":
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.shop)
					* 3 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.modify_released_pathos(Terms.RUN_ACCUMULATION_NAMES.shop, released_reward)
	CFUtils.shuffle_array(mad_lib_adjectives)
	CFUtils.shuffle_array(mad_lib_nouns)
	var adlib_format = {
		"adjective": mad_lib_adjectives[0],
		"noun": mad_lib_nouns[0],
	}
	globals.encounters.run_changes.unlock_nce("PopPsychologist2", "easy")
	end()
	globals.journal.display_nce_rewards(nce_resul_fluff.format(adlib_format))
	
