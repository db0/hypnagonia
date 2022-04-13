# A class to quickly do operations around understanding cards
class_name Understanding
extends Reference

# Perturbation which we do not want in general rotation
# Typically those are perturbations given by enemies that should last
# only the combat and are not meant to be permanent in the deck
const EXCLUDED_UNDERSTANDINGS := [
	"GUT",
	"Subconscious",
	"Hyena",
	"Chasm",
	"Beast Mode",
	"Cockroaches",
	"Recurrence",
]

# Gathers all perturbations that can be given to the player
# upgraded can be "yes", "no" or "either"
static func gather_understanding(upgraded := "yes") -> Array:
	var understandings := []
	for card_name in cfc.card_definitions:
		if cfc.card_definitions[card_name].Type == "Understanding"\
				and not card_name in EXCLUDED_UNDERSTANDINGS:
			# If upgraded is anything else but yes/no, we treat it as "maybe"
			if (upgraded == "yes"
						and not cfc.card_definitions[card_name].get("_is_upgrade"))\
					or (upgraded == "no" 
						and cfc.card_definitions[card_name].get("_is_upgrade")):
				continue
			understandings.append(card_name)
	return(understandings)


static func get_random_understanding() -> String:
	var uarray = gather_understanding("no")
	CFUtils.shuffle_array(uarray)
	return(uarray[0])
