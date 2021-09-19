# Maps the various Aspects to their components Archetypes
# Allows us to quickly navigate to each Archetype from a central point
class_name Aspects
extends Reference


const EGO := {
	"Flyer": Archetypes.FLYER,
	"Mad Scientist": Archetypes.MAD_SCIENTIST,
	"Warrior": Archetypes.WARRIOR,
	"Runner": Archetypes.RUNNER,
}

const DISPOSITION := {
	"Fearless": Archetypes.FEARLESS,
	"Coward": Archetypes.COWARD,
}

const INSTRUMENT := {
	"Rubber Chicken": Archetypes.RUBBER_CHICKEN,
}

const INJUSTICE := {
	"Abusive Relationship": Archetypes.ABUSIVE_RELATIONSHIP
}

const ARCHETYPES:= {
	"Ego": {
		"Dictionary": EGO, 
		"Description":"Ego represents the way your dreamer perceives themselves in this recurrent dream.",
	},
	"Disposition": {
		"Dictionary": DISPOSITION, 
		"Description": "The dreamer's disposition is a representation of their inner turmoil.",
	},
	"Instrument": {
		"Dictionary": INSTRUMENT, 
		"Description": "The instrument choice is a dreamer's own manifestation of their strongest trait.",
	},
	"Injustice": {
		"Dictionary": INJUSTICE, 
		"Description": "An injustice is the reason why your dreamer has been captured in this nightmare realm.\n"\
			+ "Each injustice comes with its own completion goal. Once that is achieved, your dreamer\n"\
			+ " will have had a psychological breakthrough which  will be able to break out of their recurrent dreams.",
	},
}

static func get_archetype_value(archetype: String, key: String):
	for type in ARCHETYPES:
		if ARCHETYPES[type]["Dictionary"].has(archetype):
			return(ARCHETYPES[type]["Dictionary"][archetype].get(key))


static func get_all_archetypes_list(type: String) -> Array:
	var valid_archetypes_list := []
	for archetype in ARCHETYPES[type]["Dictionary"]:
		if not ARCHETYPES[type]["Dictionary"][archetype].get("_is_inactive"):
			valid_archetypes_list.append(archetype)
	return(valid_archetypes_list)


static func get_complete_archetype_list() -> Array:
	var valid_archetypes_list := []
	for type in ARCHETYPES:
		for archetype in ARCHETYPES[type]["Dictionary"]:
			if not ARCHETYPES[type]["Dictionary"][archetype].get("_is_inactive"):
				valid_archetypes_list.append(archetype)
	return(valid_archetypes_list)


static func get_all_cards_in_archetype(archetype) -> Array:
	var all_cards := []
	for card_rarity in ["Starting Cards","Commons","Uncommons","Rares"]:
		all_cards += get_archetype_value(archetype,card_rarity)
	return(all_cards)
