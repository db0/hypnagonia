class_name SingleRun
extends Reference

# The chance to get this many choices for the next encounter
const choices_chances = [3,2,2,2,2,2,1,1,1,1,1]

var remaining_enemies := Act1.ENEMIES.duplicate(true)
var remaining_elites := Act1.ELITES.duplicate(true)
var remaining_nce := Act1.NCE.duplicate(true)
var boss_name : String
var current_encounter
var deep_sleeps := 0
var shop_deck_removals := 0
var encounter_number := 0

func setup() -> void:
	CFUtils.shuffle_array(remaining_enemies)
	CFUtils.shuffle_array(remaining_elites)
	CFUtils.shuffle_array(remaining_nce)
	var boss_choices := Act1.BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]


func generate_journal_choices() -> Array:
	# Until we have enough enemies to be able to provide enough different encounters
	# for each torment encounter, we add this code to reshuffle the pile if we run out
	if remaining_enemies.empty():
		remaining_enemies = Act1.ENEMIES.duplicate(true)
		CFUtils.shuffle_array(remaining_enemies)
	if remaining_elites.empty():
		remaining_elites = Act1.ELITES.duplicate(true)
		CFUtils.shuffle_array(remaining_elites)
	if remaining_nce.empty():
		remaining_nce = Act1.NCE.duplicate(true)
		CFUtils.shuffle_array(remaining_nce)
	var journal_options := []
	if globals.encounters.encounter_number != 1:
		# We want to avoid the player encountering elites in the first 3
		# encounters.
		if globals.encounters.encounter_number <= 3:
			globals.player.pathos.repress([Terms.RUN_ACCUMULATION_NAMES.elite])
		else:
			globals.player.pathos.repress()
	# Every journal page should have 1-3 options
	# The change to get 3 or 2 options is less than getting only 1 option
	var cc := choices_chances.duplicate()
	CFUtils.shuffle_array(cc)
	var new_options := _get_journal_options(cc[0])
#	var new_options := _get_journal_options(1)
#	print_debug(globals.player.pathos.repressed, new_options)
	# We use these to be able to adjust the amount of pathos increments in one place (Pathos class)
	var enemy_pathos_avg = globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.enemy)
	var elite_pathos_avg = globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.elite)
	var boss_pathos_avg = globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.boss)
	for option in new_options:
		match option:
			Terms.RUN_ACCUMULATION_NAMES.enemy:
				var next_enemy = remaining_enemies.pop_back()
				var difficulty : String
				if globals.player.pathos.repressed[option] < enemy_pathos_avg * 2\
						and globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < boss_pathos_avg * 8:
					difficulty = "easy"
				elif globals.player.pathos.repressed[option] < enemy_pathos_avg * 2\
						or globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < boss_pathos_avg * 8:
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
				var next_nce = remaining_nce.pop_back()
				journal_options.append(next_nce.new())
			Terms.RUN_ACCUMULATION_NAMES.elite:
				var next_enemy = remaining_elites.pop_back()
				var difficulty : String
				if globals.player.pathos.repressed[option] < elite_pathos_avg * 4\
						and globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < boss_pathos_avg * 8:
					difficulty = "easy"
				elif globals.player.pathos.repressed[option] < elite_pathos_avg * 4\
						or globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < boss_pathos_avg * 8:
					difficulty = "medium"
				else:
					difficulty = "hard"
				journal_options.append(EliteEncounter.new(next_enemy, difficulty))
			Terms.RUN_ACCUMULATION_NAMES.boss:
				journal_options.append(BossEncounter.new(Act1.BOSSES[boss_name], boss_name))
		### Debug ###
#		journal_options.append(preload("res://src/dreamscape/Run/NCE/Act1/TheCandyman.gd").new())
		### End Debug ##
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
