class_name RestEncounter
extends NonCombatEncounter

const journal_description = "I felt myself falling into a deep, dreamless torpor..."

# The amount by which the player's damage will be reduced
var rest_amount : float = 0.25
var progress_amount := 5

var secondary_choices := {
		'rest': '[Rest] {gcolor:-{healing_done} {anxiety_down}:}.',
		'progress': '[Think] {gcolor:Choose and progress a card:} {progress_amount} times',
		'resist': '[Resist] Nothing happens.',
	}

var unlockable_choices := {
	"strengthen_up": '[%s] {gcolor:Increase starting {strengthen}:} by 1.' % [ArtifactDefinitions.StrengthenUp.name],
	"quicken_up": '[%s] {gcolor:Increase starting {quicken}:} by 1.' % [ArtifactDefinitions.QuickenUp.name],
	"enhance": '[%s] {gcolor:[url={"definition": "enhance","meta_type": "definition"}]Enhance[/url]:} one card.' % [ArtifactDefinitions.EnhanceOnRest.name],
	"upgrade_memories": '[%s] {gcolor:Upgrade:} all Memories.' % [ArtifactDefinitions.UpgradeMemoryOnRest.name],
}

var reward_texts := {
	"rest": '...and I left myself fall into it.',
	# TODO: Make these fluff pieces better
	"progress": '...but my thoughts would not subside. I instead concentrated on my previous experiences in this dream.',
	"resist": '...and I struggled mightily to stave it off.',
	"strengthen_up": 'I remembered I was carrying around this curious Buddha. I deciced to give meditation a try.',
	"quicken_up": 'I roused myself just enough to play a quick game of chess with myself. It made me feel more grounded.',
	"enhance": 'The Dream Catcher stirred and displayed what came before. I could use this knowledge to improve the way I act from now on.',
	"upgrade_memories": 'I took the opportunity to look through the camera I use to remember what happened in my life.',
	
}

func _init():
	introduction.setup_with_vars("Rest",journal_description, "The Deep Torpor")
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.rest


func begin() -> void:
	.begin()
	var healing_done = round(globals.player.health * rest_amount) + skipped * 2
	if healing_done > globals.player.damage:
		healing_done = globals.player.damage	
	var scformat = {
		"healing_done": healing_done,
		"progress_amount": progress_amount + skipped,
	}
	var disabled_choices := []
	var strengthen_up = globals.player.find_artifact(ArtifactDefinitions.StrengthenUp.canonical_name)
	if strengthen_up:
		secondary_choices['strengthen_up'] = unlockable_choices['strengthen_up']
		if strengthen_up.counter >= ArtifactDefinitions.StrengthenUp.max_uses:
			disabled_choices.append('strengthen_up')
	var quicken_up = globals.player.find_artifact(ArtifactDefinitions.QuickenUp.canonical_name)
	if quicken_up:
		secondary_choices['quicken_up'] = unlockable_choices['quicken_up']
		if quicken_up.counter >= ArtifactDefinitions.StrengthenUp.max_uses:
			disabled_choices.append('quicken_up')
	var enhance = globals.player.find_artifact(ArtifactDefinitions.EnhanceOnRest.canonical_name)
	if enhance:
		secondary_choices['enhance'] = unlockable_choices['enhance']
		if enhance.counter >= ArtifactDefinitions.EnhanceOnRest.max_uses:
			disabled_choices.append('enhance')
	var upgrade_memories = globals.player.find_artifact(ArtifactDefinitions.UpgradeMemoryOnRest.canonical_name)
	if upgrade_memories:
		secondary_choices['upgrade_memories'] = unlockable_choices['upgrade_memories']
		if upgrade_memories.counter >= ArtifactDefinitions.EnhanceOnRest.max_uses:
			disabled_choices.append('upgrade_memories')
	var no_smith = globals.player.find_artifact(ArtifactDefinitions.NoSmith.canonical_name)
	if globals.player.deck.count_progressing_cards() < 1 or no_smith:
		disabled_choices.append('progress')
	var no_rest = globals.player.find_artifact(ArtifactDefinitions.NoRest.canonical_name)
	if no_rest:
		disabled_choices.append('rest')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)


func continue_encounter(key) -> void:
	match key:
		"rest":
			globals.player.damage -= round(globals.player.health * rest_amount) + skipped * 2
		"progress":
			var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
			selection_deck.popup_exclusive = true
			# warning-ignore:return_value_discarded
			selection_deck.connect("operation_performed", self, "_on_card_selected", [key])
			selection_deck.auto_close = true
			selection_deck.initiate_card_progress(0, 'mastery', progress_amount + skipped)
			selection_deck.update_color(Color(0,1,0))
		"strengthen_up":
			var strengthen_up = globals.player.find_artifact(ArtifactDefinitions.StrengthenUp.canonical_name)
			strengthen_up.counter += 1
		"quicken_up":
			var quicken_up = globals.player.find_artifact(ArtifactDefinitions.QuickenUp.canonical_name)
			quicken_up.counter += 1
		"enhance":
			var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
			selection_deck.popup_exclusive = true
			# warning-ignore:return_value_discarded
			var card_filters = [CardFilter.new('Type', 'Concentration', 'ne')]
			selection_deck.card_filters = card_filters
			selection_deck.connect("operation_performed", self, "_on_card_selected", [key])
			selection_deck.auto_close = true
			selection_deck.initiate_card_selection()
			var select_blurb := "(Enhance Card)"
			selection_deck.update_header(select_blurb)
			selection_deck.update_color(Color(0,1,0))
			var enhance = globals.player.find_artifact(ArtifactDefinitions.EnhanceOnRest.canonical_name)
			enhance.counter += 1
		"upgrade_memories":
			for memory in globals.player.memories:
				memory.upgrades_amount += 1
			var upgrade = globals.player.find_artifact(ArtifactDefinitions.UpgradeMemoryOnRest.canonical_name)
			upgrade.counter += 1
	globals.journal.display_nce_rewards(reward_texts[key])
	end()


func _on_card_selected(operation_details: Dictionary, key: String) -> void:
	var chosen_card: CardEntry = operation_details.card_entry
	if key == "enhance":
		chosen_card.enhance()
	if key == "progress" and globals.player.deck.count_upgradeable_cards() > 0:
		globals.journal._reveal_entry(globals.journal.upgrade_journal, true)
