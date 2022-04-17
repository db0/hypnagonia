# Description TBD

extends NonCombatEncounter

var shader := load("res://shaders/Roscharch.shader")

var secondary_choices := {
		'death': '[Death]: ...',
		'release': '[Release]:  ...',
		'oblivion': '[Oblivion]: ...',
	}

var nce_resul_fluff := "[i]I understand now. You have a deep-seated phobia of {noun}.[/i]\n\n"\
		+ "They were right of course! How did I not see it sooner. As I got up from the couch"\
		+ "I felt all my worries fall away..."

var mad_lib_nouns = [
	"communism",
	"tomatoes",
	"blood",
	"the colour red",
	"Santa Clause",
]

func _init():
	description = "I was rushing to my last appointment with the Pop Psychologist.\n"\
			+ "I took a seat in an overly [color=#990000]crimson fainting couch[/color].\n\n"\
			+ "[i]Are you holding up since your last visit? We must revisit the Rorschach test.\n"\
			+ "What do you see in this picture?[/i]\n\n"\
			+ "I felt like crying..."

func begin() -> void:
	.begin()
	var _shader_params := {
		'tint': HUtils.rnd_color(true, 255),
		'time_offset': CFUtils.randf_range(0, 10000)
	}
	prepare_shader_art(shader, _shader_params)
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	for choice in secondary_choices:
		secondary_choices[choice] = secondary_choices[choice].format(scformat)
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	# All three options simply heal the player to full..for now
	# TODO: Do something more interesting :)
	match key:
		"death":
			globals.player.damage = 0
		"release":
			globals.player.damage = 0
		"oblivion":
			globals.player.damage = 0
	CFUtils.shuffle_array(mad_lib_nouns)
	var adlib_format = {
		"noun": mad_lib_nouns[0],
	}
	end()
	globals.journal.display_nce_rewards(nce_resul_fluff.format(adlib_format))
