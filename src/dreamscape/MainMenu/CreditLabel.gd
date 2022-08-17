class_name CreditsLabel
extends RichTextLabel

const URLS := {
	"Db0": "http://dbzer0.com",
	"Godot": "https://godotengine.org/",
	"CGF": "http://dbzer0.com/projects/godot-card-game-framework",
	"KAI": "https://github.com/KoboldAI/KoboldAI-Client",
	"DioBal": "https://www.deviantart.com/diobalt",
	"Artbreeder.com": "https://Artbreeder.com",
	"midjourney.com": "https://www.midjourney.com",
	"game-icons.net": "https://game-icons.net",
	"kenney": "https://kenney.nl",
	"Eric Matyas": "https://soundimage.org",
	"Myuu": "https://thedarkpiano.com/",
	"Maria Thoukydidou": "https://www.deviantart.com/marablack3",
	"Ierenisrt#0318": "https://www.artstation.com/iereniss2",
	"Sebastian Piszczatowski": "https://www.artstation.com/seppoday",
	"Miikka Veijola": "https://www.artstation.com/miikkaveijolart",
	"A. Mc Leod": "https://www.artstation.com/aramcleod",
	"David Revoy": "https://www.davidrevoy.com",
	"Silberfarben": "https://www.artbreeder.com/silberfarben",
	"Lorenzo Andreozzi": "https://tornioduva.itch.io",
	"SkylarkGSH": "https://www.youtube.com/channel/UCQgd41luGM6QDKozglEjfVQ",
	"axilirate": "https://www.instagram.com/axilirate/",
	"Lorc": "https://lorcblog.blogspot.com/",
	"Delapouite": "https://delapouite.com/",
	"Caravaggio": "https://en.wikipedia.org/wiki/Caravaggio",
	"RPicster": "https://github.com/RPicster",
	"Robert Paraguassu": "https://www.instagram.com/berto_billions/",
}
const BBCODE_TEXT = """
[center]
[ghost freq=2.0 span=7.0]Credits[/ghost]

[color=yellow]Game Design[/color]

{game_designers}

[color=purple]Development[/color]

{developers}

[color=#FF6700]UI/UX Design[/color]

{gui_designers}

[color=#FF6700]Card Illustration[/color]

{card_illustrators}

[color=#FF6700]Curio/Memory Illustration[/color]

{curio_memory_designers}

[color=#FF6700]Character Art[/color]

{character_artists}

[color=green]Writing[/color]

{writers}

[color=#CC00CC]Sound Design[/color]

{sound_designers}

[color=#CC00CC]Music[/color]

{musicians}

[color=red]Playtesting[/color]

{playtesters}

[color=purple]Artificial Intelligence[/color]

{ai}
[/center]

Made using the [url=Godot]Godot Engine[/url] and the [url=CGF]Card Game Framework[/url]\n
AI text generation via [url=KAI]KoboldAI[/url]
"""


var game_designers := {
	"Db0": "Lead Game Design",
	"DioBal": "Game Design",
	"QuestLion#8467": "Archetype Design",
	"SkylarkGSH": "Miscellaneous Designs",
}
var developers := {
	"Db0": "Programming Lead"
}
var gui_designers := {
	"Db0": "Lead UX Design",
	"axilirate": "GUI Design",
	"Marco Thiltgen": "Game Logo",
	"SkylarkGSH": "Asset Creation",
	"RPicster": "Particle Assets",
}
var writers := {
	"Db0": "Lead Writer",
	"SkylarkGSH": "Story Blurbs",
	"Silberfarben": "Story Blurbs",
	"@adam-p:matrix.org": "Story Blurbs",
}
var sound_designers := {
	"Eric Matyas": '',
	"kenney": '',
}
var musicians := {
	"Myuu": '',
}
var playtesters := {
	"@adam-p:matrix.org": '',
	"Silberfarben": '',
	"Azure Blaze#8586": '',
	"TappedOut#0886": '',
	"SkylarkGSH": '',
}
var ai := {
	"Db0": "Softprompts, AI prompts",
	"VE FORBRYDERNE#6568": "KoboldAI API Development",
	"mr_seeker#1337": "KoboldAI Model Training",
	"Liriel": "AI Prompts",
	"SkylarkGSH": "AI Prompts",
}

func _ready() -> void:
	# warning-ignore:return_value_discarded
	connect("meta_clicked",self, "_on_url_clicked")
	var label_fmt = {
		"game_designers": "",
		"developers": "",
		"gui_designers": "",
		"card_illustrators": "",
		"curio_memory_designers": "",
		"character_artists": "",
		"writers": "",
		"sound_designers": "",
		"musicians": "",
		"playtesters": "",
		"ai": "",
	}
	for peep in game_designers:
		label_fmt["game_designers"] += _get_url_format(peep, game_designers[peep]) + '\n'
	for peep in developers:
		label_fmt["developers"] += _get_url_format(peep, developers[peep]) + '\n'
	for peep in gui_designers:
		label_fmt["gui_designers"] += _get_url_format(peep, gui_designers[peep]) + '\n'
	for peep in writers:
		label_fmt["writers"] += _get_url_format(peep, writers[peep]) + '\n'
	for peep in _gather_card_illustrators():
		label_fmt["card_illustrators"] += _get_url_format(peep) + '\n'
	for peep in _gather_icon_illustrators():
		label_fmt["curio_memory_designers"] += _get_url_format(peep) + '\n'
	for peep in _gather_character_artists():
		label_fmt["character_artists"] += _get_url_format(peep) + '\n'
	for peep in sound_designers:
		label_fmt["sound_designers"] += _get_url_format(peep, sound_designers[peep]) + '\n'
	for peep in musicians:
		label_fmt["musicians"] += _get_url_format(peep, musicians[peep]) + '\n'
	for peep in playtesters:
		label_fmt["playtesters"] += _get_url_format(peep, playtesters[peep]) + '\n'
	for peep in ai:
		label_fmt["ai"] += _get_url_format(peep, ai[peep]) + '\n'

	bbcode_text = BBCODE_TEXT.format(label_fmt)

func _get_url_format(unformated_string: String, title := '') -> String:
	var url_format : String
	if URLS.has(unformated_string):
		url_format = "[url=%s]%s[/url]" % [unformated_string, unformated_string]
	else:
		url_format = "%s" % [unformated_string]
	if title != '':
		url_format += " - %s" % [title]
	return(url_format)

func _on_url_clicked(meta: String) -> void:
	# warning-ignore:return_value_discarded
	OS.shell_open(URLS[meta])

func _gather_card_illustrators() -> Array:
	var found_illustrators := []
	for c in cfc.card_definitions:
		var card : Dictionary =  cfc.card_definitions[c]
		_parse_illustrator(found_illustrators, card["_illustration"])
	return(found_illustrators)

func _gather_icon_illustrators() -> Array:
	var found_illustrators := []
	for m in MemoryDefinitions.get_complete_memories_array():
		var illustrator : String = m.get("illustration", "game-icons.net")
		if found_illustrators.has(illustrator):
			continue
		found_illustrators.append(illustrator)
	for a in ArtifactDefinitions.get_complete_artifacts_array():
		var illustrator : String = a.get("illustration", "game-icons.net")
		if found_illustrators.has(illustrator):
			continue
		found_illustrators.append(illustrator)
	return(found_illustrators)

func _gather_character_artists() -> Array:
	var found_illustrators := []
	for ename in EnemyDefinitions.get_script_constant_map():
		var illustrator : String = EnemyDefinitions[ename].get("_character_art", "Nobody")
		_parse_illustrator(found_illustrators, illustrator)
	for act in [Act1, Act2, Act3]:
		for advanced in act.ELITES.values() + act.BOSSES.values():
			for s in advanced.scenes:
				var scene = s.instance()
				var illustrator: String = scene.get_script().PROPERTIES.get("_character_art", "Nobody")
				_parse_illustrator(found_illustrators, illustrator)
				scene.call_deferred("queue_free")
	for ename in CFUtils.list_files_in_directory("res://src/dreamscape/CombatElements/Enemies/Elites/", '', true):
		if ename.ends_with(".gd") and not ename.ends_with("Intents.gd"):
			pass
	return(found_illustrators)

# Takes a list of previously parsed illustrators and the currently processed illustrator string
# Parses the current string and adds it to the list if not already there.
func _parse_illustrator(existing_illustrators: Array, illustrator: String) -> void:
	if "Artbreeder" in illustrator and not existing_illustrators.has("Artbreeder.com"):
		existing_illustrators.append("Artbreeder.com")
	if "midjourney" in illustrator and not existing_illustrators.has("midjourney.com"):
		existing_illustrators.append("midjourney.com")
	illustrator = illustrator.replace(" via Artbreeder.com", "")
	illustrator = illustrator.replace(" via midjourney.com", "")
	if illustrator == "Nobody":
		return
	if existing_illustrators.has(illustrator):
		return
	existing_illustrators.append(illustrator)
