# A class to quickly do operations around perturbation cards
class_name Perturbations
extends Reference

# Perturbation which we do not want in general rotation
# Typically those are perturbations given by enemies that should last
# only the combat and are not meant to be permanent in the deck
const EXCLUDED_PERTURBATIONS := [
	"Dread",
	"Lacuna",
	"Dubious Painkillers",
	"Scattered Dreams",
	"Cringeworthy Memory",
	"Dream Fragment",
	"Cockroach Infestation",
	"Suffocation",
	"Hubris",
	"Languor",
	"Alertness",
	# The below are archetype perturbations which are excluded as they can easily be ignored
	# unless the player is using that archetype. So we want them only to appear
	# when that archetype is being used.
	"Apathy",
	"Self-Centered",
]

# Gathers all perturbations that can be given to the player
# Expects a list of extra perturbation names
# which signify the increased chance to get such perturbations
# when playing specific archetypes
static func gather_perturbations(archetype_perturbations := []) -> Array:
	var perturbations := archetype_perturbations
	for card_name in cfc.card_definitions:
		if cfc.card_definitions[card_name].Type == "Perturbation"\
				and not card_name in EXCLUDED_PERTURBATIONS:
			perturbations.append(card_name)
	return(perturbations)


static func get_random_perturbation(archetype_perturbations := []) -> String:
	var parray = gather_perturbations(archetype_perturbations)
	CFUtils.shuffle_array(parray)
	return(parray[0])

# Gets the player's archetype perturbations and increases the chances that the player gets one of them
# in a random choice, by the integer provided.
static func get_archetype_perturbations_chance(chance := 3) -> Array:
	var archetype_perturbations = globals.player.get_archetype_perturbations()
	var increased_ap := []
	# We increase the chance that an archetype specific perturbation will be gained
	# randomly, when one exists
	# I use a range, so that I can easily increase the chance later.
	while increased_ap.size() < chance and archetype_perturbations.size() > 0:
		CFUtils.shuffle_array(archetype_perturbations)
		increased_ap.append(archetype_perturbations[0])
	return(increased_ap)
