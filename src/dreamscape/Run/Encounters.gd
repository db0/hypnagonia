class_name SingleRun
extends Reference

# The chance to get this many choices for the next encounter
const choices_chances = [3,2,2,2,2,2,1,1,1,1,1]
# If none of the pathos have reached the threshold to select them as an encounter
# fallback to this one only.
const fallback_encounter = Terms.RUN_ACCUMULATION_NAMES.enemy

var remaining_enemies := Act1.ENEMIES.duplicate(true)
var remaining_elites := Act1.ELITES.duplicate(true)
var remaining_nce := Act1.NCE.duplicate(true)
var boss_name : String
var current_encounter
var deep_sleeps := 0
var shop_deck_removals := 0
var encounter_number := 0
var run_changes : RunChanges

func setup() -> void:
	CFUtils.shuffle_array(remaining_enemies)
	CFUtils.shuffle_array(remaining_elites)
	CFUtils.shuffle_array(remaining_nce)
	var boss_choices := Act1.BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]
	run_changes = RunChanges.new(self)


func generate_journal_choices() -> Array:
	# Until we have enough enemies to be able to provide enough different encounters
	# for each torment encounter, we add this code to reshuffle the pile if we run out
	if remaining_enemies.empty():
		remaining_enemies = Act1.ENEMIES.duplicate(true)
		CFUtils.shuffle_array(remaining_enemies)
	if remaining_elites.empty():
		remaining_elites = Act1.ELITES.duplicate(true)
		CFUtils.shuffle_array(remaining_elites)
	var journal_options := []
	if globals.encounters.encounter_number != 1:
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
				journal_options.append(_get_next_nce())
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
#		journal_options.append(preload("res://src/dreamscape/Run/NCE/Shop.gd").new())
#		journal_options.append(preload("res://src/dreamscape/Run/NCE/Act1/PopPsychologist1.gd").new())
#		journal_options.append(preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd").new())
#		journal_options.append(EnemyEncounter.new(Act1.Squirrel, "hard"))
		### End Debug ##
	return(journal_options)


func _get_journal_options(requested_options := 3) -> Array:
	var journal_choices_list := []
	var selected_options := []
	var pathos : Pathos = globals.player.pathos
	# If boss accumulation is >= 100, then it becomes the only option
	if pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] >= 100:
		selected_options.append(Terms.RUN_ACCUMULATION_NAMES.boss)
	else:
		for acc in pathos.repressed:
			if acc == Terms.RUN_ACCUMULATION_NAMES.boss:
				continue
			if pathos.repressed[acc] > pathos.get_threshold(acc):
				for _iter in range(pathos.repressed[acc]):
					journal_choices_list.append(acc)
#			else:
#				print_debug(pathos.repressed[acc], acc, pathos.get_threshold(acc))
		CFUtils.shuffle_array(journal_choices_list)
		for _iter in range(requested_options):
			if journal_choices_list.empty():
				break
			var choice = journal_choices_list.pop_back()
			while choice in journal_choices_list:
				journal_choices_list.erase(choice)
			selected_options.append(choice)
	if selected_options.empty():
		selected_options.append(fallback_encounter)
	return(selected_options)


func _get_next_nce() -> NonCombatEncounter:
	if remaining_nce.empty():
		remaining_nce = Act1.NCE.duplicate(true)
		remaining_nce += run_changes.get_unlocked_nces("Act1")
		CFUtils.shuffle_array(remaining_nce)
	# TODO: Adjust the Act dynamically
	var next_nce = remaining_nce.pop_back()
	# Even though we do a pop, we also erase any other copies of the same NCE in the list
	# as we might have multiple NCEs of the same name, to increase their chances of appearing
	remaining_nce.erase(next_nce)
	return(next_nce.new())

