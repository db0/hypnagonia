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


func _prepare_card_popup_bbcode(card_name: String, url_text: String) -> String:
	var popup_tag = NCE_POPUP_DICT.duplicate(true)
	popup_tag["name"] = card_name
	var url_bbcode := "[url=%s]%s[/url]" % [JSON.print(popup_tag), url_text]
	globals.journal.prepare_popup_card(card_name)
	return(url_bbcode)
