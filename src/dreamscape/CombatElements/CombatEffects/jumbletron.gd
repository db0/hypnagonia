extends CombatEffect

var scars := {
	CardFilter.new('_amounts', "damage_amount", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "damage_amount",
			"amount_value": "*0.9",
		},
	},
	CardFilter.new('_amounts', "defence_amount", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "defence_amount",
			"amount_value": "*0.9",
		},
	},
	CardFilter.new('_amounts', "effect_stacks", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "effect_stacks",
			"amount_value": "-1",
		},
	},
	CardFilter.new('_amounts', "effect_stacks2", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "effect_stacks",
			"amount_value": "-1",
		},
	},
	CardFilter.new('_amounts', "detriment_stacks", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "effect_stacks",
			"amount_value": "+1",
		},
	},
	CardFilter.new('_amounts', "steal_amount", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "steal_amount",
			"amount_value": "-1",
		},
	},
	CardFilter.new('_amounts', "increase_amount", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "increase_amount",
			"amount_value": "-1",
		},
	},
	CardFilter.new('_amounts', "effect_threshold", 'eq'): {
		"property": "_amounts",
		"value": {
			"amount_key": "effect_threshold",
			"amount_value": "+1",
		},
	},
	CardFilter.new('Tags', Terms.GENERIC_TAGS.alpha.name, 'eq'): {
		"property": "Tags",
		"value": "-" + Terms.GENERIC_TAGS.alpha.name,
	},
	CardFilter.new('Tags', Terms.GENERIC_TAGS.frozen.name, 'eq'): {
		"property": "Tags",
		"value": "-" + Terms.GENERIC_TAGS.frozen.name,
	},
	CardFilter.new('Tags', Terms.GENERIC_TAGS.slumber.name, 'ne'): {
		"property": "Tags",
		"value": Terms.GENERIC_TAGS.slumber.name,
	},
}

# We only use this if none of the others exist, as it's very nerfing
var last_resort_scar := {
		"property": "Cost",
		"value": "+1",
	}

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")


func check_scar_applicability(card: CardEntry) -> Array:
	var applicable_scars := []
	for filter in scars:
		if filter.check_card(card.properties):
			applicable_scars.append(scars[filter])
	if applicable_scars.size() > 0:
		CFUtils.shuffle_array(applicable_scars)
	else:
		applicable_scars.append(last_resort_scar)
	return(applicable_scars)


func _on_cfc_signal_received(trigger_card, trigger, _details) -> void:
	if trigger == "card_played"\
			and trigger_card.get_property("Type") == "Understanding"\
			and trigger_card.deck_card_entry:
		var applicable_scars = check_scar_applicability(trigger_card.deck_card_entry)
		# No need to check the size of the array as there's going to always be at least one element
		if typeof(applicable_scars[0].value) == TYPE_STRING\
				and applicable_scars[0].value == Terms.GENERIC_TAGS.slumber.name\
				and not trigger_card.get_property("_is_concentration"):
			var forget_task := {
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
			}
			trigger_card.deck_card_entry.modify_scripts(forget_task)
		trigger_card.deck_card_entry.modify_property(applicable_scars[0].property, applicable_scars[0].value)
