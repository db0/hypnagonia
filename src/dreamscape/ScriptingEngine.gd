#class_name DreamscapeScriptingEngine
extends ScriptingEngine

# Just calls the parent class.
func _init(state_scripts: Array,
		owner,
		_trigger_object: Node,
		_trigger_details: Dictionary).(state_scripts,
		owner,
		_trigger_object,
		_trigger_details) -> void:
	pass


func predict() -> void:
	run_type = CFInt.RunType.COST_CHECK
	var prev_subjects := []
	for task in scripts_queue:
		# We put it into another variable to allow Static Typing benefits
		var script: ScriptTask = task
		# We store the temp modifiers to counters, so that things like
		# info during targetting can take them into account
		cfc.NMAP.board.counters.temp_count_modifiers[self] = {
				"requesting_object": script.owner,
				"modifier": _retrieve_temp_modifiers(script,"counters")
			}
		# This is provisionally stored for games which need to use this
		# information before card subjects have been selected.
		cfc.card_temp_property_modifiers[self] = {
			"requesting_object": script.owner,
			"modifier": _retrieve_temp_modifiers(script, "properties")
		}
		script.subjects = predict_subjects(script, prev_subjects)
		prev_subjects = script.subjects
		#print("Scripting Subjects: " + str(script.subjects)) # Debug
		if script.script_name == "custom_script": # TODO
			# This class contains the customly defined scripts for each
			# card.
			var custom := CustomScripts.new(costs_dry_run())
			custom.custom_script(script)
		for entity in script.subjects:
#				entity.temp_properties_modifiers[self] = {
#					"requesting_object": script.owner,
#					"modifier": _retrieve_temp_modifiers(script, "properties")
#				}
			var prediction_method = "calculate_" + script.script_name
			if not script.is_skipped and has_method(prediction_method):
				var amount = call(prediction_method, entity, script)
				if amount is GDScriptFunctionState:
					amount = yield(amount, "completed")
				entity.show_predictions(amount)


# Will return the adjusted amount of whatever the scripts are doing
# if there is one.
func predict_intent_amount() -> int:
	run_type = CFInt.RunType.COST_CHECK
	var total_amount := 0
	var prev_subjects := []
	for task in scripts_queue:
		# We put it into another variable to allow Static Typing benefits
		var script: ScriptTask = task
		# We store the temp modifiers to counters, so that things like
		# info during targetting can take them into account
		cfc.NMAP.board.counters.temp_count_modifiers[self] = {
				"requesting_object": script.owner,
				"modifier": _retrieve_temp_modifiers(script,"counters")
			}
		# This is provisionally stored for games which need to use this
		# information before card subjects have been selected.
		cfc.card_temp_property_modifiers[self] = {
			"requesting_object": script.owner,
			"modifier": _retrieve_temp_modifiers(script, "properties")
		}
		script.subjects = predict_subjects(script, prev_subjects)
		prev_subjects = script.subjects
		#print("Scripting Subjects: " + str(script.subjects)) # Debug
		if script.script_name == "custom_script": # TODO
			# This class contains the customly defined scripts for each
			# card.
			var custom := CustomScripts.new(costs_dry_run())
			custom.custom_script(script)
		var prediction_method = "calculate_" + script.script_name
		for entity in script.subjects:
#				entity.temp_properties_modifiers[self] = {
#					"requesting_object": script.owner,
#					"modifier": _retrieve_temp_modifiers(script, "properties")
#				}
			if not script.is_skipped and has_method(prediction_method):
				var amount = call(prediction_method, entity, script)
				if amount is GDScriptFunctionState:
					amount = yield(amount, "completed")
				total_amount += amount
			# If there's multiple targets, we calculate the amount only for a single of them
			break
	return(total_amount)


func predict_subjects(script: ScriptTask, prev_subjects: Array) -> Array:
	match script.get_property(SP.KEY_SUBJECT):
		SP.KEY_SUBJECT_V_TARGET:
			return(cfc.get_tree().get_nodes_in_group("EnemyEntities"))
		SP.KEY_SUBJECT_V_PREVIOUS:
			return(prev_subjects)
		SP.KEY_SUBJECT_V_PLAYER:
			if is_instance_valid(cfc.NMAP.board.dreamer) and not cfc.NMAP.board.dreamer.is_dead:
				return([cfc.NMAP.board.dreamer])
			else:
				return([])
		SP.KEY_SUBJECT_V_SELF:
			return([script.owner])
		_:
			return([])


func calculate_modify_damage(subject: CombatEntity, script: ScriptTask) -> int:
	var modification: int
	var alteration = 0
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the damage is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT)
	alteration = _check_for_effect_alterants(script, modification, subject, self)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	return(modification + alteration)


func modify_damage(script: ScriptTask) -> int:
	var retcode: int
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	for combat_entity in script.subjects:
		if combat_entity.is_dead:
			continue
		var modification = calculate_modify_damage(combat_entity, script)
		# To allow effects like advantage to despawn
		yield(cfc.get_tree().create_timer(0.01), "timeout")
		retcode = combat_entity.modify_damage(
				modification,
				costs_dry_run(),
				tags,
				script.owner)
	return(retcode)


func calculate_assign_defence(subject: CombatEntity, script: ScriptTask) -> int:
	var modification: int
	var alteration = 0
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the modification is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT)
	alteration = _check_for_effect_alterants(script, modification, subject, self)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	return(modification + alteration)

func assign_defence(script: ScriptTask) -> int:
	var retcode: int
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	for combat_entity in script.subjects:
		if combat_entity.is_dead:
			continue
		var defence = calculate_assign_defence(combat_entity, script)
		# To allow effects like advantage to despawn
		yield(cfc.get_tree().create_timer(0.01), "timeout")
		retcode = combat_entity.receive_defence(
				defence,
				costs_dry_run(),
				tags,
				script.owner)
	return(retcode)

func apply_effect(script: ScriptTask) -> int:
	var retcode: int
	var modification: int
	var alteration = 0
	var effect_name: String = script.get_property(SP.KEY_EFFECT)
	var upgrade_name: String = script.get_property(SP.KEY_UPGRADE_NAME, '')
	# We inject the tags from the script into the tags sent by the signal
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	if str(script.get_property(SP.KEY_MODIFICATION)) == SP.VALUE_RETRIEVE_INTEGER:
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_MODIFICATION)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_MODIFICATION),
				script.owner,
				script.get_property(script.get_property(SP.KEY_MODIFICATION)),
				null,
				script.subjects)
		modification = per_msg.found_things
		print_debug(per_msg.found_things, modification)
	else:
		modification = script.get_property(SP.KEY_MODIFICATION)
	var set_to_mod: bool = script.get_property(SP.KEY_SET_TO_MOD)
	var stacks_diff := 0
	for e in script.subjects:
		var entity: CombatEntity = e
		if entity.is_dead:
			continue
		if not set_to_mod:
			alteration = _check_for_effect_alterants(script, modification, entity, self)
			if alteration is GDScriptFunctionState:
				alteration = yield(alteration, "completed")
		var current_stacks: int
		# If we're storing the integer, we want to store the difference
		# cumulative difference between the current and modified effect stacks
		# among all the tasrgets
		# If we set set stacks to 1, and one entity had 3 stacks,
		# while another had 0
		# The total stored integer would be -1
		# This allows us to do an effect like
		# Remove all Poison stacks from all entities, gain 1 health for each stack removed.
		if script.get_property(SP.KEY_STORE_INTEGER):
			current_stacks = entity.active_effects.get_effect_stacks(effect_name)
			if set_to_mod:
				stacks_diff += modification + alteration - current_stacks
			elif current_stacks + modification + alteration < 0:
				stacks_diff += -current_stacks
			else:
				stacks_diff = modification + alteration
		retcode = entity.active_effects.mod_effect(
				effect_name,
				modification + alteration,
				set_to_mod,
				costs_dry_run(),
				tags,
				upgrade_name)
	if script.get_property(SP.KEY_STORE_INTEGER):
		stored_integer = stacks_diff
	return(retcode)


func remove_card_from_deck(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		# We inject the tags from the script into the tags sent by the signal
		var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
		var is_permanent: bool = script.get_property(SP.KEY_PERMANENT, true)
		for card in script.subjects:
			card.remove_from_deck(is_permanent, tags)
	return(retcode)


func autoplay_card(script: ScriptTask) -> int:
	var retcode : int = CFConst.ReturnCode.CHANGED
	# If your subject is "self" make sure you know what you're doing
	# or you might end up in an inifinite loop
	for card in script.subjects:
		if not costs_dry_run():
			# We store this to send it later with a signal
			var previous_parent = card.get_parent()
			var prev_pos = card.global_position
			card.get_parent().remove_child(card)
			cfc.NMAP.board.add_child(card)
			card.set_is_faceup(true)
			# We first move it to the center of the view and hold it there
			# for a few seconds, for the player to see the card being played.
			card.state = card.ExtendedCardState.AUTOPLAY_DISPLAY
			card._add_tween_global_position(
					prev_pos,
					cfc.get_viewport().size / 2 - CFConst.CARD_SIZE/2,
					1,
					Tween.TRANS_SINE,
					Tween.EASE_IN_OUT)
			card._add_tween_rotation(0,360, 1)
			card._tween.start()
			yield(card._tween, "tween_all_completed")
			yield(card.get_tree().create_timer(1), "timeout")
			var card_scripts = card.retrieve_scripts("manual")
			var autoplay_exec : String = card.get_state_exec()
			if not card_scripts.get("hand"):
				if card.get_property("Type") == "Concentration":
					card_scripts[autoplay_exec] = card.generate_remove_from_deck_tasks()
				else:
					card_scripts[autoplay_exec] = card.generate_discard_tasks(false)
			else:
				if card.get_property("Type") == "Concentration":
					card_scripts[autoplay_exec] = card_scripts["hand"] + card.generate_remove_from_deck_tasks()
				else:
					card_scripts[autoplay_exec] = card_scripts["hand"] + card.generate_discard_tasks(false)
			card_scripts[autoplay_exec] += card.generate_play_confirm_scripts()
			for script_task in card_scripts[autoplay_exec]:
				if script_task.get("subject") and script_task["subject"] == 'target':
					script_task["subject"] = "boardseek"
					script_task["subject_count"] = 1
					script_task["sort_by"] = "random"
					if script_task.get("filter_state_subject"):
						script_task["filter_state_seek"] = script_task.get("filter_state_subject")
				script_task["is_cost"] = false
			card.scripts["autoplay"] = card_scripts
			var sceng = card.execute_scripts(
					script.owner,
					"autoplay",
					{}, costs_dry_run())
			# We make sure we wait until the execution is finished
			# before cleaning out the temp properties/counters
			if sceng is GDScriptFunctionState:
				sceng = yield(sceng, "completed")
	return(retcode)


func perturb(script: ScriptTask) -> void:
	var card: Card
	var count: int
	var alteration = 0
	var canonical_name: String = script.get_property(SP.KEY_CARD_NAME)
	var dest_container: CardContainer = script.get_property(SP.KEY_DEST_CONTAINER)
	if str(script.get_property(SP.KEY_OBJECT_COUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		count = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			count *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_OBJECT_COUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_OBJECT_COUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_OBJECT_COUNT)),
				null,
				script.subjects)
		count = per_msg.found_things
	else:
		count = script.get_property(SP.KEY_OBJECT_COUNT)
	alteration = _check_for_alterants(script, count)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	for iter in range(count + alteration):
		card = cfc.instance_card(canonical_name)
		cfc.NMAP.board.add_child(card)
		card.scale = Vector2(0.1,0.1)
		if 'rect_global_position' in script.owner:
			card.global_position = script.owner.rect_global_position
		else:
			card.global_position = script.owner.global_position
		card.global_position.x += \
				iter * CFConst.CARD_SIZE.x * 0.2
		card.pertub_destination = dest_container
		card.state = DreamCard.ExtendedCardState.SPAWNED_PERTURBATION
		yield(cfc.get_tree().create_timer(0.2), "timeout")


func spawn_enemy(script: ScriptTask) -> void:
	var count: int
	var alteration = 0
	var enemy_properties: Dictionary = script.get_property(SP.KEY_ENEMY)
	if str(script.get_property(SP.KEY_OBJECT_COUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		count = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			count *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_OBJECT_COUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_OBJECT_COUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_OBJECT_COUNT)),
				null,
				script.subjects)
		count = per_msg.found_things
	else:
		count = script.get_property(SP.KEY_OBJECT_COUNT)
	alteration = _check_for_alterants(script, count)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	for _iter in range(count + alteration):
		var enemy_entity : EnemyEntity = cfc.NMAP.board.spawn_enemy(enemy_properties)
		yield(cfc.get_tree().create_timer(0.05), "timeout")
		# We need to set it as activated or the board will never re-enable the
		# end-turn button
		if enemy_entity:
			var health_modify: int = script.get_property(SP.KEY_MODIFY_SPAWN_HEALTH, 0)
			enemy_entity.health += health_modify
			enemy_entity.emit_signal("finished_activation", enemy_entity)
			var stating_intent = script.get_property('starting_intent', null)
			if stating_intent:
				# This delay is needed to allow the starting intent to be added
				# so that it can be seen to be queued_free
				yield(cfc.get_tree().create_timer(0.01), "timeout")
				enemy_entity.intents.prepare_intents(stating_intent)
			var stating_effects = script.get_property('starting_effects', null)
			if stating_effects:
				for effect in stating_effects:
					enemy_entity.active_effects.mod_effect(effect["name"],effect["stacks"])


func draw_cards(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		# We inject the tags from the script into the tags sent by the signal
		var _tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
		var card_count: int = script.get_property(SP.KEY_CARD_COUNT)
		for _iter in range(card_count):
			cfc.NMAP.hand.draw_card(cfc.NMAP.deck)
			yield(cfc.get_tree().create_timer(0.05), "timeout")
	return(retcode)

# Used to perform some post-play activities, once all the script costs
# have been paid.
func confirm_play(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		if not cfc.NMAP.board.dreamer.active_effects.get_effect_stacks("Creative Block"): 
			if script.owner.deck_card_entry.record_use():
				cfc.NMAP.board.dreamer.upgrades_increased += 1
		var turn_event_count = cfc.NMAP.board.turn.turn_event_count
		var encounter_event_count = cfc.NMAP.board.turn.encounter_event_count
		for tag in script.owner.get_property("Tags"):
			var existing_turn_count = turn_event_count.get(tag,0)
			turn_event_count[tag] = existing_turn_count + 1
			var existing_encounter_count = encounter_event_count.get(tag,0)
			encounter_event_count[tag] = existing_encounter_count + 1
	return(retcode)


# Initiates a seek through the owner and target combat entity to see if there's any effects
# which modify the intensity of the task in question
static func _check_for_effect_alterants(
		script: ScriptTask,
		value: int,
		subject: CombatEntity,
		sceng) -> int:
	var alteration_details = {}
	var source_object: CombatEntity
	var new_value := value
	if script.owner.get_class() == "Card":
		source_object = cfc.NMAP.board.dreamer
	elif "combat_entity" in script.owner:
		source_object = script.owner.combat_entity
	else:
		source_object = script.owner
	var organized_effects := {
		"adders" : [],
		"multipliers" : [],
		"setters" : [],
	}
	# We grab the full list of source and subject items, in order to specify
	# correctly to the alterants which is which.
	# E.g. we don't want effects which decrease damage when attacked, to decrease
	# damage when we're attacking someone else.
	var source_effects : Array = source_object.active_effects.get_all_effects().values()
	var subject_effects : Array = subject.active_effects.get_all_effects().values()
	var artifacts : Array = cfc.NMAP.board.player_info.get_all_artifacts().values()
	# We grab the ordered dictionary for each type of effect. Source, Subject and Artifact
	# We will organize the alterants so that adders are first, then multipliers, the setters.
	# This way we allow an effect which multiplies the attack, to take into account additions first.
	organized_effects = source_object.active_effects.get_ordered_effects(organized_effects)
	organized_effects = subject.active_effects.get_ordered_effects(organized_effects)
	organized_effects = cfc.NMAP.board.player_info.get_ordered_artifacts(organized_effects)
	var ordered_effects = organized_effects.adders + organized_effects.multipliers + organized_effects.setters
	for effect in ordered_effects:
		var is_source := false
		if effect in source_effects:
			is_source = true
		# The artifacts consider themselves to be the source of the alteration
		# only if the effect is triggered by the dreamer or their cards.
		if effect in artifacts and source_object == cfc.NMAP.board.dreamer:
			is_source = true
		var alteration : int = effect.get_effect_alteration(
				script,
				new_value,
				sceng,
				is_source,
				sceng.costs_dry_run(),
				subject)
		alteration_details[effect] = alteration
		new_value += alteration
	return(new_value - value)


