extends MarginContainer

const pathos_descriptions := {
	"Header": "Mouse over any pathos below to have it explained.",
	Terms.RUN_ACCUMULATION_NAMES.enemy: "{pathos}\n"\
			+ "Repressed: %s ({chance}).\n" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.enemy].repressed]\
			+ "Released: %s." % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.enemy].released],
	Terms.RUN_ACCUMULATION_NAMES.nce: "{pathos}\n"\
			+ "Repressed: %s ({chance}).\n" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.nce].repressed]\
			+ "Released: %s" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.nce].released],
	Terms.RUN_ACCUMULATION_NAMES.shop: "{pathos}\n"\
			+ "Repressed: %s ({chance}).\n" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.shop].repressed]\
			+ "Released: %s." % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.shop].released],
	Terms.RUN_ACCUMULATION_NAMES.elite: "{pathos}\n"\
			+ "Repressed: %s ({chance}).\n" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.elite].repressed]\
			+ "Released: %s." % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.elite].released],
	Terms.RUN_ACCUMULATION_NAMES.artifact: "{pathos}\n"\
			+ "Repressed: %s ({chance}).\n" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.artifact].repressed]\
			+ "Released: %s." % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.artifact].released],
	Terms.RUN_ACCUMULATION_NAMES.rest: "{pathos}\n"\
			+ "Repressed: %s ({chance}).\n" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.rest].repressed]\
			+ "Released: %s." % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.rest].released],
	Terms.RUN_ACCUMULATION_NAMES.boss: "{pathos}\n"\
			+ "Repressed: %s .\n" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.boss].repressed]\
			+ "Released: %s" % [Terms.PATHOS_DESCRIPTIONS[Terms.RUN_ACCUMULATION_NAMES.boss].released],
}

var description: Label

onready var name_label := $HBC/Name
onready var chance_label := $HBC/Chance
onready var progress_bar := $HBC/ProgressBar
onready var level_label := $HBC/Level
#onready var description := $Popup/Description
#onready var description_popup := $Popup

func setup(_name: String, pathos_description: Label) -> void:
	name_label.text = _name.capitalize()
	name = _name
	description = pathos_description
	update_labels()
	
func update_labels() -> void:
	var chance : int = globals.player.pathos.calculate_chance_for_encounter(name)
	chance_label.text = str(chance) + '%'
	progress_bar.value = globals.player.pathos.get_entry_progress_pct(name) * 100
	level_label.text = str(globals.player.pathos.levels[name])


func _on_PathosEntryInfo_mouse_entered() -> void:
	description.visible = true
	var chance : int = globals.player.pathos.calculate_chance_for_encounter(name)
	var desc_format := {
		"pathos": name.capitalize(),
		"chance": '0%',
		"boss_threshold": globals.player.pathos.get_boss_threshold()
	}
	if chance > 0:
		desc_format["chance"] = 'max ' + str(chance) + '%'
	description.text = pathos_descriptions[name].format(desc_format)


func _on_PathosEntryInfo_mouse_exited() -> void:
	description.visible = false
#	print_debug(description.visible)
