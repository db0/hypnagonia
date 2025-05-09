extends SurpriseEncounter

const MASTERIES_AMOUNT = round(Pathos.MASTERY_BASELINE * 10)
const JOURNAL_CUSTOM_ENTRY = preload("res://src/dreamscape/Overworld/CustomEntries/CustomDraft.tscn")
const ADVANCED_COMBAT_ENCOUNTER_DEFINITION = {
	"name": "Underwater Cave",
	"journal_description": "",
	"basic_enemies": [
		{
			"definition": EnemyDefinitions.SUBMERGED,
			"starting_effects": [
				{
					"name": Terms.ACTIVE_EFFECTS.clawing_for_air.name,
					"stacks": 3,
				},
			]
		},
		{
			"definition": EnemyDefinitions.SUBMERGED,
			"starting_effects": [
				{
					"name": Terms.ACTIVE_EFFECTS.clawing_for_air.name,
					"stacks": 3,
				},
			]
		},
	]
}
const journal_description = "I was deep diving and came upon the edge of an underwater cave. The sign warned people not to try and recover the {artifact} within due to danger of drowning. I had to have it!"

var journal_draft_script = load("res://src/dreamscape/Overworld/CustomEntries/NCE_UnderwaterCave.gd")
var secondary_choices := {
		'explore': '[Explore the Cave]: {gcolor:Gain 1 rare {artifact}. Gain/Upgrade a memory. Draft a card. Gain {masteries_amount} {masteries}:}.',
		'leave': '[Leave]: Lose {bcolor:all {masteries}:}.',
	}

var memory_prep: MemoryPrep
var artifact_prep: ArtifactPrep


func _init():
	introduction.setup_with_vars("Underwater Cave",journal_description, "Tresure Hunt or Wet Tomb?")
	prepare_journal_art(load("res://assets/journal/nce/Underwater Cave.jpg"))


func begin() -> void:
	.begin()
	var scformat = {
		"masteries_amount": MASTERIES_AMOUNT,
	}
	_prepare_secondary_choices(secondary_choices,scformat)

func continue_encounter(key) -> void:
	if key == 'explore':
		surprise_combat_encounter = SurpriseCombatEncounter.new(
				ADVANCED_COMBAT_ENCOUNTER_DEFINITION,
				'medium',
				self)
		surprise_combat_encounter.start_ordeal()
	else:
		.end()
		var reward_text = 'I decide to take heed of this warning.'
		globals.journal.display_nce_rewards(reward_text)
		globals.player.pathos.available_masteries = 0


func end() -> void:
	.end()
	globals.player.pathos.available_masteries += MASTERIES_AMOUNT
	memory_prep = MemoryPrep.new(1, true)
	for memory in memory_prep.selected_memories:
		var existing_memory = globals.player.find_memory(memory.canonical_name)
		if existing_memory:
			existing_memory.upgrades_amount += 2
		else:
			# warning-ignore:return_value_discarded
			globals.player.add_memory(memory.canonical_name)
	artifact_prep = ArtifactPrep.new(100, 0, 1)
	globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
	var draft_scene = JOURNAL_CUSTOM_ENTRY.instance()
	draft_scene.script = journal_draft_script
	draft_scene.description_text = "This Thalassophobia made me realize some things."
	draft_scene.draft_amount = 1
	globals.journal.add_custom_entry(draft_scene)
	var reward_text = 'As {curio} I realized I had {memory}'
	var fmt = {
		"memory": _prepare_artifact_popup_bbcode(
				memory_prep.selected_memories[0].canonical_name,
				"unlocked unexpected memrories"),
		"curio": _prepare_artifact_popup_bbcode(
				artifact_prep.selected_artifacts[0].canonical_name, 
				"I took the {artifact} back out")
	}
	reward_text = reward_text.format(fmt).format(Terms.get_bbcode_formats(18))
	globals.journal.display_nce_rewards(reward_text)
