class_name NonCombatEncounter
extends SingleEncounter

const NCE_META_DICT := {
	"name": '',
	"meta_type": "nce",
}
const NCE_POPUP_DICT := {
	"name": '',
	"meta_type": "popup_card",
}


var reward_description: String


func begin() -> void:
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.nce)
	.begin()


func get_meta_hover_description(_meta_tag: String) -> String:
	return('')
