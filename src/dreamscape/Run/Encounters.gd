class_name SingleRun
extends Reference

var remaining_enemies := Act1.ENEMIES.duplicate(true)
var boss_name : String
var current_encounter
var deep_sleeps := 0
var shop_deck_removals := 0
var encounter_number := 0

func setup() -> void:
	CFUtils.shuffle_array(remaining_enemies)
	var boss_choices := Act1.BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]


func generate_journal_choices() -> Array:
	# Until we have enough enemies to be able to provide enough different encounters
	# for each torment encounter, we add this code to reshuffle the pile if we run out
	if remaining_enemies.empty():
		remaining_enemies = Act1.ENEMIES.duplicate(true)
		CFUtils.shuffle_array(remaining_enemies)
	var journal_options := []
	if globals.encounters.encounter_number != 1:
		globals.player.pathos.repress()
	var new_options := _get_journal_options(CFUtils.randi_range(2,3))
#	print_debug(globals.player.pathos.repressed, new_options)
	for option in new_options:
		match option:
			Terms.RUN_ACCUMULATION_NAMES.enemy:
				var next_enemy = remaining_enemies.pop_back()
				var difficulty : String
				if globals.player.pathos.repressed[option] < 30\
						and globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < 40:
					difficulty = "easy"
				elif globals.player.pathos.repressed[option] < 30\
						or globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < 40:
					difficulty = "medium"
				else:
					difficulty = "hard"
				journal_options.append(EnemyEncounter.new(next_enemy, difficulty))
			Terms.RUN_ACCUMULATION_NAMES.rest:
				journal_options.append(preload("res://src/dreamscape/Run/NCE/Rest.gd").new())
			Terms.RUN_ACCUMULATION_NAMES.shop:
				journal_options.append(preload("res://src/dreamscape/Run/NCE/Shop.gd").new())
			Terms.RUN_ACCUMULATION_NAMES.artifact:
				journal_options.append(preload("res://src/dreamscape/Run/NCE/Artifact.gd").new())
			Terms.RUN_ACCUMULATION_NAMES.nce:
				journal_options.append(preload("res://src/dreamscape/Run/NCE/RandomNCE.gd").new())
			Terms.RUN_ACCUMULATION_NAMES.boss:
				journal_options.append(BossEncounter.new(Act1.BOSSES[boss_name], boss_name))
	return(journal_options)


func _get_journal_options(requested_options := 3) -> Array:
	var journal_choices_list := []
	var selected_options := []
	# If boss accumulation is >= 100, then it becomes the only option
	if globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] >= 100:
		selected_options.append(Terms.RUN_ACCUMULATION_NAMES.boss)
	else:
		for acc in globals.player.pathos.repressed:
			if acc == Terms.RUN_ACCUMULATION_NAMES.boss:
				continue
			for _iter in range(globals.player.pathos.repressed[acc]):
				journal_choices_list.append(acc)
		CFUtils.shuffle_array(journal_choices_list)
		for _iter in range(requested_options):
			var choice = journal_choices_list.pop_back()
			while choice in journal_choices_list:
				journal_choices_list.erase(choice)
			selected_options.append(choice)
	return(selected_options)
