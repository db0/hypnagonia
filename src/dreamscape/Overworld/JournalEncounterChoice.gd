class_name JournalEncounterChoice
extends JournalChoice


const ENEMY_CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")

var encounter: SingleEncounter

func _init(_journal: Node, _encounter: SingleEncounter).(_journal) -> void:
	modulate.a = 0
	size_flags_horizontal = SIZE_EXPAND_FILL
	encounter = _encounter
	if encounter as EnemyEncounter:
		var enemy_encounter: EnemyEncounter = encounter
		for torment_name in enemy_encounter.get_unique_enemies():
			journal.prepare_popup_card(torment_name)
		formated_description = enemy_encounter.get_formated_description()
	if encounter as EliteEncounter:
		var elite_encounter: EliteEncounter = encounter
		formated_description = elite_encounter.description
	if encounter as BossEncounter:
		var boss_encounter: BossEncounter = encounter
		formated_description = boss_encounter.description
	if encounter as NonCombatEncounter:
		var nce: NonCombatEncounter = encounter
		formated_description = nce.description
	bbcode_text = formated_description


func _on_mouse_entered() -> void:
	._on_mouse_entered()
	_display_journal_art()


func _display_journal_art() -> void:
	var journal_illustration = encounter.journal_art
	if journal_illustration as ImageTexture:
		journal.set_illustration(journal_illustration)
	elif journal_illustration as Shader:
		journal.set_shader(journal_illustration, encounter.shader_params)


func _on_mouse_exited() -> void:
	._on_mouse_exited()
	_hide_journal_art()

func _hide_journal_art() -> void:
	var journal_illustration = encounter.journal_art
	if journal_illustration as ImageTexture\
			and journal.page_illustration.texture == journal_illustration:
		journal.unset_illustration()
	elif journal_illustration as Shader:
		journal.unset_shader()


func _on_gui_input(event) -> void:
	._on_gui_input(event)
	if event.is_pressed() and event.get_button_index() == 1:
		_display_journal_art()
