extends PanelContainer

onready var page_illustration := $HBC/JournalPageIllustration
onready var journal_intro := $HBC/JournalEntry/VBC/DayIntro
onready var journal_choices := $HBC/JournalEntry/VBC
onready var card_storage := $EnemyCardStorage

var enemy_cards := {}

func _ready() -> void:
	cfc.game_rng_seed = CFUtils.generate_random_seed() # Debug
	globals.encounters.setup() # Debug
	
	var encounter_choices: Array
	encounter_choices = globals.encounters.generate_journal_choices()
	for encounter in encounter_choices:
		var journal_choice = JournalChoice.new(self, encounter)
		journal_choices.add_child(journal_choice)
		journal_choice.connect("pressed", self, "_on_choice_pressed", [encounter])


func on_meta_clicked(meta_text: String) -> void:
	var jsonParseResult: JSONParseResult = JSON.parse(meta_text)
	print_debug(jsonParseResult.result)


func _on_meta_hover_started(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		"torment_card":
			var torment_name : String = meta_tag["name"]
			enemy_cards[torment_name]._on_DBGridCardObject_mouse_entered()

func _on_meta_hover_ended(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		"torment_card":
			var torment_name : String = meta_tag["name"]
			enemy_cards[torment_name]._on_DBGridCardObject_mouse_exited()

func _parse_meta_tag(meta_text: String) -> Dictionary:
	var json_parse: JSONParseResult = JSON.parse(meta_text)
	if not json_parse:
		print_debug("WARN: Malformated json result:" + meta_text)
		return({"meta_type": "FAULTED:"})
	return(json_parse.result)

func _on_choice_pressed(encounter: Dictionary) -> void:
	print_debug(encounter)
