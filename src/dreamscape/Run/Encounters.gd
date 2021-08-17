class_name SingleRun
extends Reference

var accumulations := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: 20,
	Terms.RUN_ACCUMULATION_NAMES.rest: 0,
	Terms.RUN_ACCUMULATION_NAMES.nce: 5,
	Terms.RUN_ACCUMULATION_NAMES.shop: 5,
	Terms.RUN_ACCUMULATION_NAMES.elite: 0,
	Terms.RUN_ACCUMULATION_NAMES.artifact: 0,
	Terms.RUN_ACCUMULATION_NAMES.boss: 0,
}

var accumulation_progressions := {
	Terms.RUN_ACCUMULATION_NAMES.enemy: range(10,20),
	Terms.RUN_ACCUMULATION_NAMES.rest: range(5,10),
	Terms.RUN_ACCUMULATION_NAMES.nce: range(7,11),
	Terms.RUN_ACCUMULATION_NAMES.shop: range(2,4),
	Terms.RUN_ACCUMULATION_NAMES.elite: range(5,10),
	Terms.RUN_ACCUMULATION_NAMES.artifact: range(2,3),
	Terms.RUN_ACCUMULATION_NAMES.boss: range(5,7),
}

var remaining_early_enemies := Act1.EARLY_ENEMIES.duplicate(true)
var remaining_enemies := Act1.ENEMIES.duplicate(true)
var boss_name : String
var current_encounter

func setup() -> void:
	CFUtils.shuffle_array(remaining_early_enemies)
	CFUtils.shuffle_array(remaining_enemies)
	var boss_choices := Act1.BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]


func generate_journal_choices() -> Array:
	var journal_options := []
	if globals.encounter_number != 1:
		accumulate()
	var new_options := _get_journal_options(CFUtils.randi_range(2,3))
	print_debug(accumulations, new_options)
	for option in new_options:
		match option:
			Terms.RUN_ACCUMULATION_NAMES.enemy:
				var next_enemy = remaining_enemies.pop_back()
				var difficulty : String
				if accumulations[option] < 30\
						and accumulations[Terms.RUN_ACCUMULATION_NAMES.boss] < 40:
					difficulty = "easy"
				elif accumulations[option] < 30\
						or accumulations[Terms.RUN_ACCUMULATION_NAMES.boss] < 40:
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
	if accumulations[Terms.RUN_ACCUMULATION_NAMES.boss] >= 100:
		selected_options.append(Terms.RUN_ACCUMULATION_NAMES.boss)
	else:
		for acc in accumulations:
			if acc == Terms.RUN_ACCUMULATION_NAMES.boss:
				continue
			for _iter in range(accumulations[acc]):
				journal_choices_list.append(acc)
		CFUtils.shuffle_array(journal_choices_list)
		for _iter in range(requested_options):
			var choice = journal_choices_list.pop_back()
			while choice in journal_choices_list:
				journal_choices_list.erase(choice)
			selected_options.append(choice)
	return(selected_options)

func accumulate() -> void:
	for acc in accumulations:
		var rand_array : Array = accumulation_progressions[acc].duplicate()
		CFUtils.shuffle_array(rand_array)
		accumulations[acc] += rand_array[0]
