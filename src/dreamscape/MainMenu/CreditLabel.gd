class_name CreditsLabel
extends RichTextLabel

const URLS := {
	"Db0": "http://dbzer0.com",
	"Godot": "https://godotengine.org/",
	"CGF": "http://dbzer0.com/projects/godot-card-game-framework/",
	"DioBal": "https://www.deviantart.com/diobalt",
	"Artbreeder.com": "https://Artbreeder.com",
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
[/center]

Made using the [url=Godot]Godot Engine[/url] and the [url=CGF]Card Game Framework[/url]
"""


var game_designers := {
	"Db0": "Lead Game Design",
	"DioBal": "Game Design",
	"Questlion": "Archetype Design",
	"SkylarkGSH": "Archetype Design",
}
var developers := {
	"Db0": "Programming Lead"
}
var gui_designers := {
	"Db0": "Lead UX Design",
	"axilirate": "GUI Design",
	"Marco Thiltgen": "Game Logo",
	"SkylarkGSH": "Asset Creation",
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

func _ready() -> void:
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
		var illustrator : String = card["_illustration"]
		if "Artbreeder" in illustrator and not found_illustrators.has("Artbreeder.com"):
			found_illustrators.append("Artbreeder.com")
		illustrator = illustrator.replace(" via Artbreeder.com", "")
		if illustrator == "Nobody":
			continue
		if found_illustrators.has(illustrator):
			continue
		found_illustrators.append(illustrator)
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
		if illustrator == "Nobody":
			continue
		if found_illustrators.has(illustrator):
			continue
		found_illustrators.append(illustrator)
	return(found_illustrators)
