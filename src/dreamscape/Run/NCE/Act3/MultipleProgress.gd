extends NonCombatEncounter

const CARD_PROGRESS = 3
# The artifact used by this event.
const SPECIAL_ARTIFACT:= "ProgressEverything"
const PROGRESS6_HEALTH_LOSS = 3
const PROGRESS4_DAMAGE = 3


var secondary_choices := {
		'progress2': '[Progress2]: Progress 2 random cards {progress_amount}.',
		'progress4': '[Progress4]: Progress 4 random cards by {progress_amount}. Take {anxiety_taken} anxiety',
		'progress6': '[Progress6]: Progress 6 random cards by {progress_amount}. Lose {max_anxiety_loss} max anxiety.',
	}

var secret_option = '[Experience] Gain a {special_curio}'

# TODO: Fluff
var nce_result_fluff := {
		'progress2': "",
		'progress4': "",
		'progress6': "",
		'secret': "",
	}

var repressed_pathos_amount: int
var released_pathos_amount: int

func _init():
	# TODO: Fluff
	description = "<Multiple Progress - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var scformat = {
		"progress_amount": CARD_PROGRESS,
		"max_anxiety_loss": PROGRESS6_HEALTH_LOSS,
		"anxiety_taken": PROGRESS4_DAMAGE,
		"special_curio": _prepare_artifact_popup_bbcode(SPECIAL_ARTIFACT, SPECIAL_ARTIFACT)
	}
	var disabled_choices = []
	if globals.player.deck.count_progressing_cards() < 5:
		disabled_choices.append('progress6')
	if globals.player.deck.count_progressing_cards() < 3:
		disabled_choices.append('progress4')
	if globals.player.deck.count_progressing_cards() < 1:
		disabled_choices.append('progress2')
		secondary_choices['secret'] = secret_option
	for c in secondary_choices:
		secondary_choices[c] = secondary_choices[c].format(scformat).format(Terms.get_bbcode_formats(18))
	for choice in disabled_choices:
		secondary_choices[choice] = "[color=red]" + secondary_choices[choice] + "[/color]"
	globals.journal.add_nested_choices(secondary_choices, disabled_choices)

func continue_encounter(key) -> void:
	var progress_count = 0
	match key:
		"progress2":
			progress_count = 2
		"progress4":
			progress_count = 4
			globals.player.damage += PROGRESS4_DAMAGE
		"progress5":
			progress_count = 6
			globals.player.health -= PROGRESS6_HEALTH_LOSS
	if key != 'secret':
		var cards = globals.player.deck.get_progressing_cards()
		CFUtils.shuffle_array(cards)
		for card in cards:
			card.upgrade_progress += CARD_PROGRESS
			progress_count -= 1
			if progress_count == 0: 
				break
	else:
		globals.player.add_artifact(SPECIAL_ARTIFACT)
	end()
	globals.journal.display_nce_rewards('')
