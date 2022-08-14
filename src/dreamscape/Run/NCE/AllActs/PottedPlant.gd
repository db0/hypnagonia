extends NonCombatEncounter

const PERTURBATION := "Lethe"
const SPECIAL_MEMORY:= "RemoveDebuff"
const MEMORY_UPGRADE := 3
const journal_description = "In my wildest dreams, objects in my room manifest differently. "\
			+ "One of them was the potted plant near the window."\
			+ "It seemed to be observing me. Wait, did I forget to water it?"

var secondary_choices := {
		'remembered': "[Remembered]: Nothing happens.",
		'forgot': "[Forgot]: Become {bcolor:{special_perturbation}:}. {gcolor:Upgrade:} your {existing_memory}.",
		'what': "[Huh?]: Become {bcolor:{special_perturbation}:}. {gcolor:Gain {special_memory}:}.",
	}

var nce_result_fluff := {
		'remembered': "I know for sure I watered it just yesterday.",
		'forgot': "Oh no, last time must have been weeks ago...",
		'what': "Wait a minute, I don't have a plant!",
	}
var existing_memory

func _init():
	introduction.setup_with_vars("Potted Plant",journal_description, "A Mysterious Plant on My Windowsill")
	prepare_journal_art(load("res://assets/journal/nce/Potted Plant.jpg"))

func begin() -> void:
	.begin()
	var disabled_choices = []
	var scformat = {
		"special_perturbation": _prepare_card_popup_bbcode(PERTURBATION, "forgetful"),
		"special_memory": _prepare_artifact_popup_bbcode(SPECIAL_MEMORY, "a painful memory"),
	}
	existing_memory = globals.player.get_memory_by_pathos(Terms.RUN_ACCUMULATION_NAMES.shop)
	if existing_memory:
		scformat['existing_memory'] = _prepare_artifact_popup_bbcode(existing_memory.canonical_name, "an existing memory")
		disabled_choices.append('what')
	else:
		scformat['existing_memory'] = "an existing memory"
		disabled_choices.append('forgot')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	match key:
		"forgot":
			# warning-ignore:return_value_discarded
			globals.player.deck.add_new_card(PERTURBATION)
			existing_memory.upgrades_amount += MEMORY_UPGRADE
		"what":
			globals.player.deck.add_new_card(PERTURBATION)
			globals.player.add_memory(SPECIAL_MEMORY)
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
