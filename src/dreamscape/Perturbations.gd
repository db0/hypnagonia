# A class to quickly do operations around perturbation cards
class_name Perturbations
extends Reference

# Perturbation which we do not want in general rotation
# Typically those are perturbations given by enemies that should last
# only the combat and are not meant to be permanent in the deck
const EXCLUDED_PERTURBATIONS := [
	"Dread",
	"Dubious Painkillers",
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
