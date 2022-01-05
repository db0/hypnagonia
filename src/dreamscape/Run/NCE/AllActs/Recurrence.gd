extends SurpriseEncounter

const JOURNAL_ART := {
	"Act1": preload("res://assets/journal/nce/recurrence1.jpeg"),
	"Act2": preload("res://assets/journal/nce/recurrence2.jpeg"),
	"Act3": preload("res://assets/journal/nce/recurrence3.jpeg"),
}
const RECURRENCE_ELITE = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
}

var difficulties := {
	Act1.get_act_name(): "easy",
	Act2.get_act_name(): "medium",
}

var descriptions := {
	Act1.get_act_name(): "I recognised the sound. Cracking bark but somehow wet. It made me feel ill hearing it and each snap left a lingering, ghastly anticipation. Not bark...bones. Cracking bones. No...not again...",
	Act2.get_act_name(): "The cracking sound was doubly shocking as it ricoched around the quiet, restful moment I had been enjoying. It was twice as loud as before and curdled my thoughts, just as I had begun to collect them. I should have known it would return. It always returns. Crack crack, crunch crunch.",
}

var journal_arts := {
	Act1.get_act_name(): JOURNAL_ART.Act1,
	Act2.get_act_name(): JOURNAL_ART.Act2,
}

var memory_prep: MemoryPrep


func _init():
	description = descriptions[globals.encounters.current_act.get_act_name()]
	prepare_journal_art(journal_arts[globals.encounters.current_act.get_act_name()])


func begin() -> void:
	.begin()
	surprise_combat_encounter = RecurrenceCombatEncounter.new(
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
			existing_memory.upgrade()
			existing_memory.upgrade()
		else:
			globals.player.add_memory(memory.canonical_name)
	var reward_text = '[url={"name": "memory1","meta_type": "nce"}]I have seen this[/url] before. I know this. Overcoming this recurrence [url={"name": "memory2","meta_type": "nce"}]jolted my memories[/url].'
	globals.journal.display_nce_rewards(reward_text)


func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"memory1":
			var bbformat1 = memory_prep.selected_memories[0]["bbformat"]
			return("[img=18x18]{icon}[/img] {description}.".format(bbformat1))
		"memory2":
			var bbformat2 = memory_prep.selected_memories[1]["bbformat"]
			return("[img=18x18]{icon}[/img] {description}.".format(bbformat2))
		_:
			return('')
