# Description TBD
extends NonCombatEncounter

var secondary_choices := {}

func _init():
	description = "I glimpsed into a roomfull of porcelain dolls." \
			+ "They were all unfinished, except a single element."\
			+ "They all turned and asked me to finish them. But I could only carry one."\
			+ "Let me recall, which one did choose..?"

func begin() -> void:
	.begin()
	# Candy Colour BBCode
	var ccbbc = "[color={ccode}]{ccolour}[/color]"
	var colours : Array = HConst.COLOUR_MAP2.keys()
	var coloured_parts : = [
		"eyes",
		"hair",
		"dress",
		"parasol",
		"hat"
	]
	var adjectives =[
		"pretty",
		"fascinating",
		"delightful",
		"amazing",
		"brilliant"
	]
	var choice_strings = [
		'I chose the one with the {adjective} {colour} {element}.',
		'The doll with the {colour} {element} was the most {adjective}.',
		'Never before had I seen such {adjective} {colour} {element}.',
		'I found the {colour} {element} the most {adjective}.',
		'The {adjective} {colour} {element} was the only choice for me.',
	]
	CFUtils.shuffle_array(colours)
	CFUtils.shuffle_array(adjectives)
	CFUtils.shuffle_array(coloured_parts)
	CFUtils.shuffle_array(choice_strings)
	for index in range(3):
		var cformat = {
			"ccolour": colours[index].to_lower(),
			"ccode": HConst.COLOR2_CODES[colours[index]].to_lower(),
			}
		var fdict := {
			"colour": ccbbc.format(cformat),
			"element": coloured_parts[index],
			"adjective": adjectives[index],
		}
		secondary_choices[colours[index]] = choice_strings[index].format(fdict)
	globals.journal.add_nested_choices(secondary_choices, [])

func continue_encounter(key: String) -> void:
	var mod := {"colour": key}
	globals.player.add_artifact("PorcelainDoll", mod)
	end()
	var result = 'The engineering on this [url={"name": "curio","meta_type": "nce"}]Porcelain Doll[/url] was masterful!'
	globals.journal.display_nce_rewards(result)


func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"curio":
			var artifact_def = ArtifactDefinitions.find_artifact_from_canonical_name("PorcelainDoll")
			var artifact = globals.journal.player_info.find_artifact("PorcelainDoll")
			var pd_format : Dictionary = artifact.get_extra_description_format()
			var bbformat = {
				"icon": artifact_def.icon.resource_path,
				"description": artifact_def.description\
						.format(pd_format)\
						.format(Terms.get_bbcode_formats(18))\
						.format(ArtifactDefinitions.get_artifact_bbcode_format(artifact_def))
			}
			return("[img=18x18]{icon}[/img] {description}.".format(bbformat))
		_:
			return('')
