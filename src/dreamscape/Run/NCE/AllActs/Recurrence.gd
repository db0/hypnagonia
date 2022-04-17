extends SurpriseEncounter

const RECURRENCE_TAKEOVERS := [
	"Not so fast!",
	"There is only one choice...",
	"All paths lead to me.",
	"Your imagination is inadequate.",
	"I have to be faced.",
	"Where do you think you're going.",
]

var recurrence_elite = {
	"scenes": [load("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")]
}

var recurrence_surprise = load("res://src/dreamscape/Run/NCE/AllActs/RecurrenceCombatEncounter.gd")

var difficulties := {
	# Can't refer to the act class, Otherwise we get a cyclic reference
	1: "easy",
	2: "medium",
	3: "hard",
}

var descriptions := {
	1: "I recognised the sound. Cracking bark but somehow wet. It made me feel ill hearing it and each snap left a lingering, ghastly anticipation. Not bark...bones. Cracking bones. No...not again...",
	2: "The cracking sound was doubly shocking as it ricoched around the quiet, restful moment I had been enjoying. It was twice as loud as before and curdled my thoughts, just as I had begun to collect them. I should have known it would return. It always returns. Crack crack, crunch crunch.",
	3: "It was the pain of a hot sauce constantly dripping into my open mouth, the repeating of an annoying jingle until it lost all meaning. My whole body felt the disgusting clapping and cracking of wet leater an bones. I knew then that, for better of worse, it would happen again. ",
}

var journal_arts := {
	1: load("res://assets/journal/nce/recurrence1.jpeg"),
	2: load("res://assets/journal/nce/recurrence2.jpeg"),
	3: load("res://assets/journal/nce/recurrence3.jpeg"),
}

var memory_upgrades := {
	1: 2,
	2: 3,
	3: 4,
}


var unused_takeovers : Array
var attempts_to_escape := 0

func _init():
	# In GUT it will not exist
	if is_instance_valid(globals.journal):
		globals.journal.connect("choice_entry_added", self, "_takeover_journal_entry")
	for existing_entry in globals.get_tree().get_nodes_in_group("JournalEncounterChoiceScene"):
		_takeover_journal_entry(existing_entry)
	description = descriptions[globals.encounters.current_act.get_act_number()]
	prepare_journal_art(journal_arts[globals.encounters.current_act.get_act_number()])


func begin() -> void:
	.begin()
	surprise_combat_encounter = recurrence_surprise.new(
			recurrence_elite,
			difficulties[globals.encounters.current_act.get_act_number()],
			self)
	surprise_combat_encounter.start_ordeal()


func end() -> void:
	.end()
	var reward_upgrades = memory_upgrades[globals.encounters.current_act.get_act_number()]
	
	var fmt := {
		"card": "I know this"
	}
	var existing_card = globals.player.deck.filter_cards(DreamCardFilter.new("_name", "Recurrence"))
	var existing_upgraded_card = globals.player.deck.filter_cards(DreamCardFilter.new("_name", "+ Recurrence +"))
	if existing_card.size() > 0:
		fmt["card"] = _prepare_card_popup_bbcode("+ Recurrence +", "I know this")
		existing_card[0].upgrade("+ Recurrence +")
	elif existing_upgraded_card.size() > 0:
		fmt["card"] = _prepare_card_popup_bbcode("++ Recurrence ++", "I know this")
		existing_upgraded_card[0].upgrade("++ Recurrence ++")
	var reward_text = 'I have seen this all before. {card}...'.format(fmt)
	globals.journal.display_memory_rewards({"quantity": 2, "upgrades": reward_upgrades})
	if existing_card.size() == 0 and existing_upgraded_card.size() == 0:
		globals.journal.display_nce_rewards(reward_text, "empty_draft")
	else:
		globals.journal.display_nce_rewards(reward_text)
	if globals.encounters.current_act.get_act_number() == 1:
		globals.encounters.run_changes.unlock_nce("Recurrence2", "risky", false)
	elif globals.encounters.current_act.get_act_number() == 2:
		globals.encounters.run_changes.unlock_nce("Recurrence3", "risky", false)

func _takeover_journal_entry(choice_entry) -> void:
	if choice_entry.journal_choice.encounter == self:
		return
	choice_entry.journal_choice.disconnect(
			"pressed",
			globals.journal,
			"_on_choice_pressed")
	choice_entry.journal_choice.connect(
			"pressed",
			self,
			"_on_choice_pressed",
			[choice_entry])

func _on_choice_pressed(choice_entry) -> void:
	if unused_takeovers.size() == 0:
		unused_takeovers = RECURRENCE_TAKEOVERS.duplicate()
		CFUtils.shuffle_array(unused_takeovers)
	cfc.hide_all_previews()
	var rng_choice = unused_takeovers.pop_back()
	attempts_to_escape += 1
	var shake_rate = 5 * attempts_to_escape
	var shake_level = 10 + attempts_to_escape * 3
	choice_entry.journal_choice.formated_description = \
			"[shake rate=%s level=%s][color=red][i]%s[/i][/color][/shake]" % [shake_rate, shake_level, rng_choice]

func return_extra_draft_cards() -> Array:
	return(["Recurrence"])
