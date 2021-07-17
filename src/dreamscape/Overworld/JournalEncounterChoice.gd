class_name JournalEncounterChoice
extends JournalChoice


const ENEMY_CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")

var encounter: SingleEncounter


func _init(_journal: Node, _encounter: SingleEncounter).(_journal) -> void:
	modulate.a = 0
	encounter = _encounter
	if encounter as EnemyEncounter:
		var enemy_encounter: EnemyEncounter = encounter
		for torment_name in enemy_encounter.get_unique_enemies():
			if not journal.enemy_cards.has(torment_name):
				var torment_card = ENEMY_CARD_PREVIEW_SCENE.instance()
				journal.card_storage.add_child(torment_card)
				torment_card.setup(torment_name)
				journal.enemy_cards[torment_name] = torment_card
		formated_description = enemy_encounter.get_formated_description()
	if encounter as BossEncounter:
		var boss_encounter: BossEncounter = encounter
		formated_description = boss_encounter.description
	if encounter as NonCombatEncounter:
		var nce: NonCombatEncounter = encounter
		formated_description = nce.description
	bbcode_text = formated_description


func _on_mouse_entered() -> void:
	._on_mouse_entered()
	var journal_illustration := encounter.journal_art
	if journal_illustration:
		journal.set_illustration(journal_illustration)


func _on_mouse_exited() -> void:
	._on_mouse_exited()
	var journal_illustration := encounter.journal_art
	if journal.page_illustration.texture == journal_illustration:
		journal.unset_illustration()
