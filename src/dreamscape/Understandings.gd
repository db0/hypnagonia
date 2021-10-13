# A class to quickly do operations around understanding cards
class_name Understanding
extends Reference

# Gathers all perturbations that can be given to the player
static func gather_understanding(upgraded := "yes") -> Array:
	var perturbations := []
	for card_name in cfc.card_definitions:
		if cfc.card_definitions[card_name].Type == "Understanding":
			# If upgraded is anything else but yes/no, we treat it as "maybe"
			if (upgraded == "yes"
						and not cfc.card_definitions[card_name].get("_is_upgrade"))\
					or (upgraded == "no" 
						and cfc.card_definitions[card_name].get("_is_upgrade")):
				continue
			perturbations.append(card_name)
	return(perturbations)


static func get_random_understanding() -> String:
	var uarray = gather_understanding()
	CFUtils.shuffle_array(uarray)
	return(uarray[0])
