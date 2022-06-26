extends CoreScripts

const Exhaustion = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.exhaustion.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
			{
				"name": "end_turn"
			},
		],
	}
}
const MinorExhaustion = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.exhaustion.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	}
}
const KeepEmComing = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.keep_em_coming.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	}
}
const KnowYourLimits = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.know_your_limits.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	}
}

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String, get_modified = true) -> Dictionary:
	# This format allows me to trace which script failed during load
	var scripts := {
		"Exhaustion": Exhaustion,
		"Minor Exhaustion": MinorExhaustion,
		"Keep 'em Coming": KeepEmComing,
		"Know Your Limits": KnowYourLimits,
	}
	return(_prepare_scripts(scripts, card_name, get_modified))
