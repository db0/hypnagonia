class_name SingleRun
extends Reference

signal encounter_changed(act_name, encounter_number)

# The chance to get this many choices for the next encounter
const choices_chances = [3,2,2,2,2,2,1,1,1,1,1]
# If none of the pathos have reached the threshold to select them as an encounter
# fallback to this one only.
const fallback_encounter = Terms.RUN_ACCUMULATION_NAMES.enemy

var available_acts := [Act1, Act2]
var current_act
var remaining_enemies : Array
var remaining_elites : Array
var remaining_nce := {
	"easy": [],
	"risky": [],
}
var boss_name : String
var current_encounter
var deep_sleeps := 0
var shop_deck_removals := 0
var encounter_number := 0 setget set_encounter_number
var run_changes := RunChanges.new(self)


# Loads the next act from the list and prepares the encounters for it
func prepare_next_act(current_journal = null) -> void:
	# Changing acts, heals the player a bit
	var healing_done = globals.player.health * 0.75
	if healing_done > globals.player.damage:
		healing_done = globals.player.damage
	if not available_acts.size():
		globals.journal.end_dev_version()
		return
	current_act = available_acts.pop_front()
	remaining_enemies = current_act.ENEMIES.duplicate(true)
	remaining_elites = current_act.ELITES.duplicate(true)
	for nce_type in remaining_nce:
		remaining_nce[nce_type] = current_act.NCE[nce_type].duplicate(true)
		for nce in AllActs.NCE[nce_type]:
			if not run_changes.is_nce_used(nce):
				remaining_nce[nce_type].append(nce)
		CFUtils.shuffle_array(remaining_nce[nce_type])
#	for nce in remaining_nce["easy"]:
#		print(nce.get_path())
	CFUtils.shuffle_array(remaining_enemies)
	CFUtils.shuffle_array(remaining_elites)
	var boss_choices = current_act.BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]
	if current_journal:
		current_journal.proceed_to_next_act()


func generate_journal_choices() -> Array:
	# Until we have enough enemies to be able to provide enough different encounters
	# for each torment encounter, we add this code to reshuffle the pile if we run out
	if remaining_enemies.empty():
		remaining_enemies = current_act.ENEMIES.duplicate(true)
		CFUtils.shuffle_array(remaining_enemies)
	if remaining_elites.empty():
		remaining_elites = current_act.ELITES.duplicate(true)
		CFUtils.shuffle_array(remaining_elites)
	var journal_options := []
	if encounter_number != 1:
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
	var difficulty : String
	for option in new_options:
		match option:
			Terms.RUN_ACCUMULATION_NAMES.enemy:
				var next_enemy = remaining_enemies.pop_back()
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
				if globals.player.pathos.repressed[option] < globals.player.pathos.get_threshold(option) + elite_pathos_avg\
						and globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < boss_pathos_avg * 8:
					difficulty = "easy"
				elif globals.player.pathos.repressed[option] < globals.player.pathos.get_threshold(option) + elite_pathos_avg\
						or globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss] < boss_pathos_avg * 8:
					difficulty = "medium"
				else:
					difficulty = "hard"
				journal_options.append(EliteEncounter.new(next_enemy, difficulty))
			Terms.RUN_ACCUMULATION_NAMES.boss:
				journal_options.append(BossEncounter.new(current_act.BOSSES[boss_name]))
	if OS.has_feature("debug"):
		var _debug_encounter_paths := []
		var _debug_enemies := []
		for e in journal_options:
			_debug_encounter_paths.append(e.get_script().get_path())
			if e as EnemyEncounter:
				for t in e.enemies:
					_debug_enemies.append(t.definition.Name)
			if e as EliteEncounter or e as BossEncounter:
				_debug_enemies.append(e.enemy_scene.get_path())
		print("DEBUG INFO:Encounters: Encounter choices selected: ", _debug_encounter_paths)
		if _debug_enemies.size() > 0:
			print("DEBUG INFO:Encounters: %s enemies choices available: %s" % [difficulty.capitalize(), _debug_enemies])
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
	var nce_type = "easy"
	var nce_pathos_avg = globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.nce)
	var current_nce_level = globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.nce]
	var nce_pathos_threshold = globals.player.pathos.get_threshold(Terms.RUN_ACCUMULATION_NAMES.nce)
	if current_nce_level > nce_pathos_threshold + nce_pathos_avg * 2:
		nce_type = "risky"
	print_debug("Current NCE Level: %s. Bad Threshold %s. Chosen: %s" % [current_nce_level, nce_pathos_threshold + nce_pathos_avg * 2, nce_type])
	# In full release, I should not need to do this, as I should have enough NCE to never run out
	if remaining_nce[nce_type].empty():
		if OS.has_feature("debug"):
			print("DEBUG INFO:Encounters: Reshuffling %s NCE" % [nce_type])
		remaining_nce[nce_type] = current_act.NCE[nce_type].duplicate(true)
		remaining_nce[nce_type] += run_changes.get_unlocked_nces(current_act.get_act_name(), nce_type)
		CFUtils.shuffle_array(remaining_nce[nce_type])
	var next_nce = remaining_nce[nce_type].pop_back()
	# Even though we do a pop, we also erase any other copies of the same NCE in the list
	# as we might have multiple NCEs of the same name, to increase their chances of appearing
	remaining_nce[nce_type].erase(next_nce)
	run_changes.record_nce_used(next_nce)
	return(next_nce.new())


func set_encounter_number(value) -> void:
	encounter_number = value
	emit_signal("encounter_changed", current_act.get_act_name(), encounter_number)
