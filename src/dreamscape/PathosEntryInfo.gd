extends MarginContainer

const pathos_descriptions := {
	"Header": "Mouse over any pathos below to have it explained.",
	Terms.RUN_ACCUMULATION_NAMES.enemy: "{pathos}\n"\
			+ "Repressed: Increases the chance that Torments will appear as encounters ({chance}).\n"\
			+ "Released: Can be used to buy or remove Archetype cards in the shop.",
	Terms.RUN_ACCUMULATION_NAMES.nce: "{pathos}\n"\
			+ "Repressed: Increases the chance that Non-Ordeal encounters will appear ({chance}).\n"\
			+ "Released: Can be used to buy Archetype cards to your deck in the shop.",
	Terms.RUN_ACCUMULATION_NAMES.shop: "{pathos}\n"\
			+ "Repressed: Increases the chance that the Shop encounter will appear ({chance}).\n"\
			+ "Released: Can be used to buy Memories in the shop.",
	Terms.RUN_ACCUMULATION_NAMES.elite: "{pathos}\n"\
			+ "Repressed: Increases the chance that Elite Torment will appear as encounters ({chance}).\n"\
			+ "Released: Can be used to buy Curios in the shop.",
	Terms.RUN_ACCUMULATION_NAMES.artifact: "{pathos}\n"\
			+ "Repressed: Increases the chance that Curios will appear as encounters ({chance}).\n"\
			+ "Released: Can be used to buy Understanding cards in the shop.",
	Terms.RUN_ACCUMULATION_NAMES.rest: "{pathos}\n"\
			+ "Repressed: Increases the chance that Rest encounters will appear ({chance}).\n"\
			+ "Released: Can be used to progress your cards in the shop.",
	Terms.RUN_ACCUMULATION_NAMES.boss: "{pathos}\n"\
			+ "Repressed: When this reaches {boss_threshold}+, you will encounter this Act's adversary.\n"\
			+ "Released: Unknown...",
}

var description: Label

onready var name_label := $HBC/Name
onready var repressed_label := $HBC/Represed
onready var released_label := $HBC/Released
#onready var description := $Popup/Description
#onready var description_popup := $Popup

func setup(_name: String, pathos_description: Label) -> void:
	name_label.text = _name.capitalize()
	name = _name
	description = pathos_description
	update_labels()
	
func update_labels() -> void:
	repressed_label.text = str(floor(globals.player.pathos.repressed[name]))
	released_label.text = str(floor(globals.player.pathos.released[name]))


func _on_PathosEntryInfo_mouse_entered() -> void:
	description.visible = true
	var chance : int = globals.player.pathos.calculate_chance_for_encounter(name)
	var desc_format := {
		"pathos": name.capitalize(),
		"chance": '0%',
		"boss_threshold": globals.player.pathos.thresholds[Terms.RUN_ACCUMULATION_NAMES.boss]\
				* globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.boss)
	}
	if chance > 0:
		desc_format["chance"] = 'max ' + str(chance) + '%'
	description.text = pathos_descriptions[name].format(desc_format)


func _on_PathosEntryInfo_mouse_exited() -> void:
	description.visible = false
#	print_debug(description.visible)
