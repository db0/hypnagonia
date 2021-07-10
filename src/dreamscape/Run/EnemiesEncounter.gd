class_name EnemyEncounter
extends CombatEncounter

const TORMENT_META_DICT := {
	"name": '',
	"meta_type": "torment_card",
}

var enemies: Array

func _init(encounter: Dictionary):
	type = "torment"
	description = encounter["journal_description"]
	enemies = encounter["enemies"]

func get_formated_description() -> String:
	var rtag_index = 1
	var tag_format := {}
	for torment_name in get_unique_enemies():
		var rich_text_format_tag = "torment_tag" + str(rtag_index)
		rtag_index += 1
		var torment_tag = TORMENT_META_DICT.duplicate(true)
		torment_tag["name"] = torment_name
		tag_format[rich_text_format_tag] = JSON.print(torment_tag)
	return(description.format(tag_format))


func get_unique_enemies() -> Array:
	var unique_enemies := []
	for enemy in enemies:
		if not enemy in unique_enemies:
			unique_enemies.append(enemy)
	return(unique_enemies)
