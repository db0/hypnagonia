# Description TBD

extends NonCombatEncounter

const CURIOS := {
	'passion fruit': ArtifactDefinitions.MoreEliteMasteries,
	'orange': ArtifactDefinitions.MoreEnemyMasteries,
	'banana': ArtifactDefinitions.MoreNCEMasteries,
}
const journal_description = "I was rushing to my second appointment with the Pop Psychologist.\n"\
			+ "I took a seat in an overly [color=#FF0038]carmine fainting couch[/color].\n\n"\
			+ "[i]How have you been doing since your last visit? We should to revisit the Rorschach test.\n"\
			+ "What do you see in this picture?[/i]\n\n"\
			+ "My eyes were getting tired from straining..."


var shader := load("res://shaders/Roscharch.shader")

var secondary_choices := {
		'passion fruit': '[A Passion Fruit]: Gain some {gcolor:Gain {passion fruit_curio}:}.',
		'orange': '[An Orange]:  Gain some {gcolor:Gain {orange_curio}:}.',
		'banana': '[A Banana]: Gain some {gcolor:Gain {banana_curio}:}.',
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
	introduction.setup_with_vars("Pop Psychologist 2",journal_description, "")

func begin() -> void:
	.begin()
	var _shader_params := {
		'tint': HUtils.rnd_color(true, 255),
		'time_offset': CFUtils.randf_range(0, 10000)
	}
	var scformat := {}
	for option in ['passion fruit', 'orange', 'banana']:
		scformat[option+ '_curio'] = _prepare_artifact_popup_bbcode(CURIOS[option].canonical_name, CURIOS[option].name)
	prepare_shader_art(shader, _shader_params)
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	var pathos_type : PathosType
	var multiplier : float
	globals.player.add_artifact(CURIOS[key].canonical_name)
	CFUtils.shuffle_array(mad_lib_adjectives)
	CFUtils.shuffle_array(mad_lib_nouns)
	var adlib_format = {
		"adjective": mad_lib_adjectives[0],
		"noun": mad_lib_nouns[0],
	}
	globals.encounters.run_changes.unlock_nce("PopPsychologist3", "easy")
	end()
	globals.journal.display_nce_rewards(nce_resul_fluff.format(adlib_format))
