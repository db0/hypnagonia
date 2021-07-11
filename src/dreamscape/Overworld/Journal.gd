class_name Journal
extends PanelContainer

onready var page_illustration := $HBC/JournalPageIllustration
onready var journal_intro := $HBC/JournalEntry/VBC/DayIntro
onready var journal_choices := $HBC/JournalEntry/VBC/JournalChoices
onready var card_storage := $EnemyCardStorage
onready var reward_journal := $HBC/JournalEntry/VBC/RewardJournal
onready var card_draft := $HBC/JournalEntry/VBC/Slide/CardDraft
onready var loss := $HBC/JournalEntry/VBC/Loss
onready var proceed := $HBC/JournalEntry/VBC/Proceed
onready var _tween := $Tween

var enemy_cards := {}

func _ready() -> void:
#	cfc.game_rng_seed = CFUtils.generate_random_seed() # Debug
#	globals.encounters.setup() # Debug
	globals.journal = self
	_reveal_entry(journal_intro)
	yield(_tween, "tween_all_completed")
	var encounter_choices: Array
	encounter_choices = globals.encounters.generate_journal_choices()
	for encounter in encounter_choices:
		var journal_choice = JournalChoice.new(self, encounter)
		journal_choices.add_child(journal_choice)
		journal_choice.connect("pressed", self, "_on_choice_pressed", [encounter, journal_choice])
		_reveal_entry(journal_choice)
		yield(_tween, "tween_all_completed")
	for rich_text in [loss, proceed]:
		rich_text.connect("mouse_entered", self, "_on_rte_mouse_entered", [rich_text] )
		rich_text.connect("mouse_exited", self, "_on_rte_mouse_exited", [rich_text] )
		rich_text.connect("gui_input", self, "_on_rte_gui_input", [rich_text] )


func display_rewards(reward_text: String) -> void:
	reward_journal.bbcode_text = reward_text
	_reveal_entry(reward_journal)
	_reveal_entry(proceed)


func _on_meta_clicked(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		"torment_card":
			_on_meta_hover_ended(meta_text)


func _on_meta_hover_started(meta_text: String) -> void:
	var meta_tag := _parse_meta_tag(meta_text)
	match meta_tag["meta_type"]:
		# This is to prevent the card preview staying after we disable signals
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


func _on_choice_pressed(encounter: SingleEncounter, rich_text_choice: JournalChoice) -> void:
	for choice in journal_choices.get_children():
		if choice != rich_text_choice:
			choice.visible = false
	encounter.begin()


func _reveal_entry(rich_text_node: RichTextLabel) -> void:
	_tween.interpolate_property(rich_text_node,
			'modulate:a', 0, 1, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()
	rich_text_node.visible = true



func _on_RewardJournal_meta_clicked(_meta) -> void:
	card_draft.display()
	reward_journal.bbcode_text = "[color=grey]" + reward_journal.text + "[/color]"

func _on_rte_mouse_entered(rt_label: RichTextLabel) -> void:
	rt_label.bbcode_text = "[color=yellow]" + rt_label.text + "[/color]"

func _on_rte_mouse_exited(rt_label: RichTextLabel) -> void:
	rt_label.bbcode_text = rt_label.text
	
func _on_rte_gui_input(event, rt_label: RichTextLabel) -> void:
	if event.is_pressed() and event.get_button_index() == 1:
		match rt_label.name:
			"Loss":
				pass
			"Proceed":
				get_tree().change_scene(CFConst.PATH_CUSTOM + 'Overworld/Journal.tscn')
