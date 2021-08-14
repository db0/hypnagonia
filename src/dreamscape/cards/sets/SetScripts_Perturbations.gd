#extends CoreScripts
extends "res://src/dreamscape/cards/sets/SetScripts_Core.gd"

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Dread": {
			"manual": {
				"hand": [
					{
						"name": "remove_card_from_deck",
						"subject": "self",
					},
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(_prepare_scripts(scripts, card_name))
