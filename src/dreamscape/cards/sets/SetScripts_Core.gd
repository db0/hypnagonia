# See README.md
extends Reference

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Assault": {
			"manual": {
				"hand": [
					{
						"name": "inflict_damage",
						"subject": "target",
						"is_cost": true,
						"damage": 6,
					}
				],
			},
		},
		"Defend": {
			"manual": {
				"hand": [
					{
						"name": "assign_armor",
						"subject": "dreamer",
						"is_cost": true,
						"armor": 5,
					}
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))
