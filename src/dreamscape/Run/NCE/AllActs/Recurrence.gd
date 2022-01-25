extends SurpriseEncounter

const JOURNAL_ART := {
	"Act1": preload("res://assets/journal/nce/recurrence1.jpeg"),
	"Act2": preload("res://assets/journal/nce/recurrence2.jpeg"),
	"Act3": preload("res://assets/journal/nce/recurrence3.jpeg"),
}
const RECURRENCE_ELITE = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
}

const RECURRENCE_SURPRISE = preload("res://src/dreamscape/Run/NCE/AllActs/RecurrenceCombatEncounter.gd")

var difficulties := {
	# Otherwise we get a cyclic reference
	"Early Night": "easy",
	"Deep Sleep": "medium",
}

var descriptions := {
	"Early Night": "I recognised the sound. Cracking bark but somehow wet. It made me feel ill hearing it and each snap left a lingering, ghastly anticipation. Not bark...bones. Cracking bones. No...not again...",
	"Deep Sleep": "The cracking sound was doubly shocking as it ricoched around the quiet, restful moment I had been enjoying. It was twice as loud as before and curdled my thoughts, just as I had begun to collect them. I should have known it would return. It always returns. Crack crack, crunch crunch.",
}

var journal_arts := {
	"Early Night": JOURNAL_ART.Act1,
	"Deep Sleep": JOURNAL_ART.Act2,
}

var memory_prep: MemoryPrep


func _init():
	description = descriptions[globals.encounters.current_act.get_act_name()]
	prepare_journal_art(journal_arts[globals.encounters.current_act.get_act_name()])


func begin() -> void:
	.begin()
	surprise_combat_encounter = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE, 
			difficulties[globals.encounters.current_act.get_act_name()], 
			self)
	surprise_combat_encounter.start_ordeal()


func end() -> void:
	.end()
	memory_prep = MemoryPrep.new(2, true)
	for memory in memory_prep.selected_memories:
		var existing_memory = globals.player.find_memory(memory.canonical_name)
		if existing_memory:
			existing_memory.upgrades_amount += 2
		else:
			globals.player.add_memory(memory.canonical_name)
	var reward_text = '{memory1} before. I know this. Overcoming this recurrence {memory2}.'
	var fmt = {
		"memory1": _prepare_artifact_popup_bbcode(
				memory_prep.selected_memories[0].canonical_name, 
				"I have seen this"),
		"memory2": _prepare_artifact_popup_bbcode(
				memory_prep.selected_memories[1].canonical_name, 
				"jolted my memories"),
	}
	reward_text = reward_text.format(fmt)
	globals.journal.display_nce_rewards(reward_text)
	if globals.encounters.current_act.get_act_name() == Act.ACT_NAMES.Act1:
		globals.encounters.run_changes.unlock_nce("Recurrence2", "risky", false)
	elif globals.encounters.current_act.get_act_name() == Act.ACT_NAMES.Act2:
		globals.encounters.run_changes.unlock_nce("Recurrence3", "risky", false)

