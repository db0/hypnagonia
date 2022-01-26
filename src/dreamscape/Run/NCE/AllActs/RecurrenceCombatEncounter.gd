extends SurpriseCombatEncounter

# This is the average stacks per turn required to be played by the player
# before we consider a counteract.
# If an effect is not listed here, the threshold is 1.0
# This means that if the dreamer played at least 1 stack per turn, on average
# we will consider countermeasures for it.
const AVERAGE_THRESHOLDS := {
	"average_attacks": 4.0,
	"defence_average": 9.0,
	"high_defences": 3.0,
	"high_attacks": 3.0,
	# This one is special, as it doesn't check the average, but the absolute
	"heals": 10.0,
	"average_cards": 6.0
}

var lessons_learned := {
	"attacks": [],
	"defences": [],
	"heals": [],
	"buffs": [],
	"debuffs": [],
	"cards": [],
}
var countermeasures_considered := {
}


func _init(encounter: Dictionary, difficulty: String, nce).(encounter, difficulty, nce):
	if not globals.encounters.run_changes.store.has("Recurrence"):
		globals.encounters.run_changes.store["Recurrence"] = []


func finish_surpise_ordeal() -> void:
	.finish_surpise_ordeal()
	var total_turns : float = lessons_learned.cards.size()
	if total_turns == 0:
		total_turns = 1
	var effect_totals := {}
	for list in [lessons_learned.buffs, lessons_learned.debuffs]:
		for turn in list:
			for effect_name in turn:
				print_debug(effect_name, turn)
				effect_totals[effect_name] = effect_totals.get(effect_name,0) + turn[effect_name]
	for effect in effect_totals:
#		print_debug([effect, float(buff_totals[effect]) / float(total_turns)])
		# How many buffs per turn the dreamer assigned to themselves
		var effect_average = float(effect_totals[effect]) / total_turns
		if effect_average >= AVERAGE_THRESHOLDS.get(effect, 1.0):
			countermeasures_considered[effect] = effect_average
	var total_high_defence_turns : float = 0
	var defence_total : float = 0
	for turn in lessons_learned.defences:
		if turn > 14: 
			total_high_defence_turns += 1
		defence_total += turn
	var defence_average : float = defence_total / total_turns
	# If the player averages more than 8 defence per turn, we try to counteract it
	if defence_average >= AVERAGE_THRESHOLDS["defence_average"]:
		countermeasures_considered["defence_average"] = defence_average / AVERAGE_THRESHOLDS["defence_average"]
	if total_high_defence_turns >= AVERAGE_THRESHOLDS["high_defences"]:
		countermeasures_considered["high_defences"] = total_high_defence_turns / AVERAGE_THRESHOLDS["high_defences"]
	var total_high_attack_turns : float = 0
	var total_attacks : float = 0
	for turn in lessons_learned.attacks:
		for attack in turn: 
			if attack > 14:
				total_high_attack_turns += 1
		total_attacks += turn.size()
#	print_debug([total_high_attack_turns, total_high_attack_turns >= AVERAGE_THRESHOLDS["high_attacks"]])
	var average_attacks : float = total_attacks / total_turns
	# If the player averages more than 6 defence per turn, we try to counteract it
	if average_attacks >= AVERAGE_THRESHOLDS["average_attacks"]:
		countermeasures_considered["average_attacks"] = average_attacks / AVERAGE_THRESHOLDS["average_attacks"]
	if total_high_attack_turns >= AVERAGE_THRESHOLDS["high_attacks"]:
		countermeasures_considered["high_attacks"] = total_high_attack_turns / AVERAGE_THRESHOLDS["high_attacks"]
	var total_heals : float = 0
	for turn in lessons_learned.heals:
		total_heals += turn
	if total_heals >= AVERAGE_THRESHOLDS["heals"]:
		# Using this to avoid increasing the countermeasures very slow or very fast.
		countermeasures_considered["heals"] = 1.0 + (total_high_defence_turns / 3.0)
	var total_cards : float = 0
	for turn in lessons_learned.cards:
		total_cards += turn
	var average_cards : float = total_cards / total_turns
	# If the player averages more than 8 defence per turn, we try to counteract it
	if average_cards >= AVERAGE_THRESHOLDS["average_cards"]:
		countermeasures_considered["average_cards"] = average_cards / AVERAGE_THRESHOLDS["average_cards"]
#	print_debug(countermeasures_considered)
	var chosen_countermeasure := ''
	var countermeasure_rating : float = 0
	for cm in countermeasures_considered:
		if countermeasures_considered[cm] > countermeasure_rating:
			chosen_countermeasure = cm
	if chosen_countermeasure == '':
		chosen_countermeasure = "nonspecific"
	globals.encounters.run_changes.store["Recurrence"].append(chosen_countermeasure)
		

func on_learning_finished(lessons: Dictionary) -> void:
	for key in lessons:
		lessons_learned[key].append(lessons[key])


func _on_board_instanced() -> void:
	._on_board_instanced()
	# warning-ignore:return_value_discarded
	enemy_entity.connect("learning_finished", self, "on_learning_finished")
