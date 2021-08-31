extends NonCombatEncounter

#var secondary_choices := {
#		'rest': '...and I left myself [url={"name": "rest","meta_type": "nce"}]fall into it.[/url]',
#		'resist': '...and I struggled mightily to stave it off.',
#	}


func _init():
	description = "<NCE WiP>"

func begin() -> void:
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.nce)
	.begin()
	globals.journal.display_rewards('')
	
#func continue_encounter(key) -> void:
#	match key:
#		"rest": 
#			globals.player.damage -= globals.player.health * 0.25
#			globals.journal.display_rewards('')
#		"resist": 
#			globals.journal.display_rewards('')
##		"rest": globals.journal.add_nested_choices({3: "Test1", 4: "Test2"})
##		"resist": globals.journal.add_nested_choices({5: "Test3", 6: "Test4"})
#
#func get_meta_hover_description(meta_tag: String) -> String:
#	match meta_tag:
#		"rest": 
#			var healing_done = globals.player.health * 0.25
#			if healing_done > globals.player.damage:
#				healing_done = globals.player.damage
#			return("Removes anxiety equal to 25% of the max ({healing}), from the Dreamer."\
#					.format({"healing": int(round(healing_done))}))
#		_:
#			return('')
