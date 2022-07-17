class_name SingleRun
extends Reference

signal encounter_changed(act_name, encounter_number)

# The chance to get this many choices for the next encounter
const choices_chances = [3,3,2,2,2,2,2,2,2,1,1]
# If none of the pathos have reached the threshold to select them as an encounter
# fallback to this one only.
const fallback_encounter = Terms.RUN_ACCUMULATION_NAMES.enemy

var available_acts := [Act1, Act2, Act3]
var current_act
var remaining_enemies : Array
var remaining_elites : Array
var remaining_nce := {
	"easy": [],
	"risky": [],
}
var boss_name : String
var deep_sleeps := 0
var shop_deck_removals := 0
var encounter_number := 0 setget set_encounter_number
var run_changes := RunChanges.new(self)
var interpretation_illustration: String setget ,get_interpretation_illustration
var confidence_illustration: String setget ,get_confidence_illustration
var card_back_texture: String setget ,get_card_back_texture


# Loads the next act from the list and prepares the encounters for it
func prepare_next_act(current_journal = null) -> void:
	if not available_acts.size():
		globals.journal.end_dev_version()
		return
	current_act = available_acts.pop_front()
	# Changing acts, heals the player a bit
	if current_act != Act1:
		var healing_done = globals.player.health * globals.difficulty.act_healing
		if healing_done > globals.player.damage:
			healing_done = globals.player.damage
		globals.player.damage -= healing_done
	remaining_enemies = current_act.ENEMIES.keys()
	remaining_elites = current_act.ELITES.keys()
	for nce_type in remaining_nce:
		_prepare_remaining_nce(nce_type)
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
		remaining_enemies = current_act.ENEMIES.keys()
		CFUtils.shuffle_array(remaining_enemies)
	if remaining_elites.empty():
		remaining_elites = current_act.ELITES.keys()
		CFUtils.shuffle_array(remaining_elites)
	var journal_options := []
	if encounter_number != 1:
		globals.player.pathos.repress()
	# Every journal page should have 1-3 options
	# The change to get 3 or 2 options is less than getting only 1 option
	var options_amount : int
	if globals.player.find_artifact(ArtifactDefinitions.NoChoice.canonical_name):
		options_amount = 1
	else:
		var cc := choices_chances.duplicate()
		CFUtils.shuffle_array(cc)
		options_amount = cc[0]
	var new_options := _get_journal_options(options_amount)
#	var new_options := _get_journal_options(1)
	# We use these to be able to adjust the amount of pathos increments in one place (Pathos class)
	var pathos_type_enemy: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
	var pathos_type_elite: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]
	var pathos_type_boss: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.boss]
	var enemy_pathos_avg = pathos_type_enemy.get_progression_average()
	var elite_pathos_avg = pathos_type_elite.get_progression_average()
	var boss_pathos_avg = pathos_type_boss.get_progression_average()
	var normal_difficulty := 'N/A'
	var elite_difficulty := 'N/A'
	for option in new_options:
		match option:
			Terms.RUN_ACCUMULATION_NAMES.enemy:
				var next_enemy = current_act.ENEMIES[remaining_enemies.pop_back()]
				if pathos_type_enemy.skipped < 2\
						and pathos_type_boss.repressed < boss_pathos_avg * 8:
					normal_difficulty = "easy"
				elif pathos_type_enemy.skipped < 2\
						or pathos_type_boss.repressed < boss_pathos_avg * 8:
					normal_difficulty = "medium"
				else:
					normal_difficulty = "hard"
				journal_options.append(EnemyEncounter.new(next_enemy, normal_difficulty))
			Terms.RUN_ACCUMULATION_NAMES.rest:
				journal_options.append(load("res://src/dreamscape/Run/NCE/Rest.gd").new())
			Terms.RUN_ACCUMULATION_NAMES.shop:
				journal_options.append(load("res://src/dreamscape/Run/NCE/Shop.gd").new())
			Terms.RUN_ACCUMULATION_NAMES.artifact:
				journal_options.append(load("res://src/dreamscape/Run/NCE/Artifact.gd").new())
			Terms.RUN_ACCUMULATION_NAMES.nce:
				journal_options.append(_get_next_nce())
			Terms.RUN_ACCUMULATION_NAMES.elite:
				var next_enemy = current_act.ELITES[remaining_elites.pop_back()]
				if pathos_type_elite.skipped < 1\
						and pathos_type_boss.repressed < boss_pathos_avg * 8:
					elite_difficulty = "easy"
				elif pathos_type_elite.skipped < 1\
						or pathos_type_boss.repressed < boss_pathos_avg * 8:
					elite_difficulty = "medium"
				else:
					elite_difficulty = "hard"
				journal_options.append(EliteEncounter.new(next_enemy, elite_difficulty))
			Terms.RUN_ACCUMULATION_NAMES.boss:
				journal_options.append(BossEncounter.new(current_act.BOSSES[boss_name]))
	if OS.has_feature("debug") and not cfc.is_testing:
		var _debug_encounter_paths := []
		var _debug_enemies := []
		for e in journal_options:
			_debug_encounter_paths.append(e.get_script().get_path())
			if e as EnemyEncounter:
				for t in e.enemies:
					_debug_enemies.append(t.definition.Name)
			if e as AdvancedCombatEncounter:
				for scene in e.enemy_scenes:
					_debug_enemies.append(scene.get_path())
		print("DEBUG INFO:Encounters: Encounter choices selected: ", _debug_encounter_paths)
		if _debug_enemies.size() > 0:
			print("DEBUG INFO:Encounters: (Normal Difficulty: %s/ Elite Difficulty: %s) enemies choices available: %s"\
					% [normal_difficulty.capitalize(), elite_difficulty.capitalize(), _debug_enemies])
	return(journal_options)


func _get_journal_options(requested_options := 3) -> Array:
	var journal_choices_list := []
	var selected_options := []
	var pathos : Pathos = globals.player.pathos
	# If boss accumulation is >= 100, then it becomes the only option
	var pathos_type_boss: PathosType = pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.boss]
	var boss_threshold = pathos_type_boss.threshold * pathos_type_boss.get_progression_average()
	if pathos_type_boss.repressed >= boss_threshold:
		selected_options.append(Terms.RUN_ACCUMULATION_NAMES.boss)
	else:
		for pathos_type in pathos.pathi.values():
			if pathos_type.name == Terms.RUN_ACCUMULATION_NAMES.boss:
				continue
			if pathos_type.repressed > pathos_type.get_threshold():
				for _iter in range(pathos_type.repressed):
					journal_choices_list.append(pathos_type.name)
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
	var pathos_type_nce: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]
	if  not remaining_nce["risky"].empty() and pathos_type_nce.skipped >= 1:
		nce_type = "risky"
	if OS.has_feature("debug"):
		print_debug("Current NCE skipped: %s. Chosen: %s" % [pathos_type_nce.skipped, nce_type])
	# In full release, I should not need to do this, as I should have enough NCE to never run out
	# In development version, we only reshuffle the easy NCE to avoid having the player eat
	# the fewer risky ones all the time.
	if remaining_nce[nce_type].empty():
		_prepare_remaining_nce(nce_type)
	var next_nce = remaining_nce[nce_type].pop_back()
	# Even though we do a pop, we also erase any other copies of the same NCE in the list
	# as we might have multiple NCEs of the same name, to increase their chances of appearing
	while next_nce in remaining_nce[nce_type]:
		remaining_nce[nce_type].erase(next_nce)
	if typeof(next_nce) == TYPE_STRING:
		next_nce = load(next_nce)
	run_changes.record_nce_used(next_nce)
	return(next_nce.new())


func set_encounter_number(value) -> void:
	encounter_number = value
	emit_signal("encounter_changed", current_act.get_act_name(), encounter_number)


func _prepare_remaining_nce(nce_type: String) -> void:
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Encounters: Reshuffling %s NCE" % [nce_type])
	remaining_nce[nce_type].clear()
	for nce_script in current_act.NCE[nce_type].values():
		remaining_nce[nce_type].append(nce_script)
	for nce_script in run_changes.get_unlocked_nces(current_act.get_act_name(), nce_type):
		remaining_nce[nce_type].append(nce_script)
	# For now, AlAct NCEs are the only ones we don't allow to recycle
	for nce_script in AllActs.NCE[nce_type].values():
		if run_changes.is_nce_used(nce_script):
			continue
		remaining_nce[nce_type].append(nce_script)
	CFUtils.shuffle_array(remaining_nce[nce_type])

func extract_save_state() -> Dictionary:
	var encounter_dict := {
		"available_acts" : [],
		"current_act": current_act.get_act_number(),
		"remaining_enemies" : remaining_enemies,
		"remaining_elites" : remaining_elites,
		"remaining_nce": remaining_nce,
		"boss_name" : boss_name,
		"deep_sleeps": deep_sleeps,
		"shop_deck_removals" : shop_deck_removals,
		"encounter_number": encounter_number,
		"run_changes" : run_changes.extract_save_state(),
		"interpretation_illustration" : interpretation_illustration,
		"confidence_illustration" : confidence_illustration,
		"card_back_texture" : card_back_texture,
	}
	for act in available_acts:
		encounter_dict["available_acts"].append(act.get_act_number())
	return(encounter_dict)

func restore_save_state(save_dict: Dictionary) -> void:
	available_acts.clear()
	for act in [Act1, Act2, Act3]:
		if act.get_act_number() in save_dict.available_acts:
			available_acts.append(act)
		if act.get_act_number() == save_dict.current_act:
			current_act = act
	remaining_enemies = save_dict.remaining_enemies
	remaining_elites = save_dict.remaining_elites
	remaining_nce = save_dict.remaining_nce
	boss_name = save_dict.boss_name
	deep_sleeps = save_dict.deep_sleeps
	shop_deck_removals = save_dict.shop_deck_removals
	encounter_number = save_dict.encounter_number
	run_changes.restore_save_state(save_dict.run_changes)
	interpretation_illustration = save_dict.interpretation_illustration
	confidence_illustration = save_dict.confidence_illustration
	card_back_texture = save_dict.card_back_texture

func get_interpretation_illustration() -> String:
	if not interpretation_illustration:
		interpretation_illustration = ImageLibrary.get_multiple_art_option("Interpretation")
	return(interpretation_illustration)


func get_confidence_illustration() -> String:
	if not confidence_illustration:
		confidence_illustration = ImageLibrary.get_multiple_art_option("Confidence")
	return(confidence_illustration)


func get_card_back_texture() -> String:
	if not card_back_texture:
		card_back_texture = HypnagoniaCardBack.get_random_card_back()
	return(card_back_texture)
		
