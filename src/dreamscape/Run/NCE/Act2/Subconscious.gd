extends NonCombatEncounter

const DAMAGE_AMOUNT := 7
const MASTERIES_AMOUNT := round(Pathos.MASTERY_BASELINE * 0.5)

var secondary_choices := {
		'give': '[Give]: {bcolor:+{damage_amount} {anxiety_up}:}. {gcolor:Gain {subconscious}:}',
		'avoid': '[avoid]: Gain {gcolor:{masteries_amount} {masteries}:}.',
	}
	
var nce_result_fluff := {
		'give': """
I had no choice but to give him a piece of my soul in exchange for what was buried deep inside of me. 
The process was painless, yet very draining of my own life. What was I getting myself into? 
The keeper had finally opened the gates and let me inside, allowing me to rush in to finally see what lay deep inside my inner mind. 
Lying inside the crystal ball was a prismatic dragon swirling around rapidly sparking the creation of my hopes and fears. 
Was it waiting to be remembered yet again, so it may unleash it's juvenile chaos upon the mindscape in which it created?
I had the choice to free this inner godlike part of me, yet would it grow out of my control if I cannot harness it correctly, what will become of me then? 
Would this nightmare get any worse?
""",
		'avoid': """
My awareness of the world was perfectly as fine as it is, yet I was still ultimately curious about what could've been behind the gates. 
Alas, I fell back into the endless abyss, awaiting the strange creatures that my subconscious had ultimately created, 
never knowing, never growing, never to be seen again...
""",
	}

var lowest_pathos: String
var lowest_pathos_amount: float
var pathos_type_lowest : PathosType

func _init():
	description = """
I remember standing in front of the looming gatekeeper guarding the mythical crystal ball of revelation just a few feet past the safeguard of awareness. 
He demanded that I had to pay a price to pierce through the barrier of my mind, ultimately turning inwards into my own consciousness.
Would I persist instinct and nature just to wield my nightmares?
"""
	prepare_journal_art(load("res://assets/journal/nce/Subconscious.jpg"))

func begin() -> void:
	.begin()
	var scformat = {
		"masteries_amount": MASTERIES_AMOUNT,
		"damage_amount":  DAMAGE_AMOUNT,
		"subconscious": _prepare_card_popup_bbcode("Subconscious", " an insight into your own mind."),
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"avoid":
			globals.player.pathos.available_masteries += MASTERIES_AMOUNT
		"give":
			# warning-ignore:return_value_discarded
			globals.player.damage += DAMAGE_AMOUNT
			globals.player.deck.add_new_card("Subconscious")
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
