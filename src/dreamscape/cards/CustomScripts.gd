# This class contains very custom scripts definitionsa for objects that need them
#
# The definition happens via object name
class_name CustomScripts
extends Reference

var costs_dry_run := false

func _init(_dry_run) -> void:
	costs_dry_run = _dry_run
# This fuction executes custom scripts
#
# It relies on the definition of each script being based the object's name
# Therefore the only thing we need, is the object itself to grab its name
# And to have a self-reference in case it affects itself
#
# You can pass a predefined subject, but it's optional.
func custom_script(script: ScriptObject) -> void:
	var card: DreamCard = script.owner
	var subjects: Array = script.subjects
	# I don't like the extra indent caused by this if,
	# But not all object will be Card
	# So I can't be certain the "canonical_name" var will exist
	match card.canonical_name:
		"The Joke", "* The Joke *", "= The Joke =", "+ The Joke +":
			# No demo cost-based custom scripts
			if not costs_dry_run:
				if subjects.size() and subjects[0] as EnemyEntity:
					var enemy_entity: EnemyEntity = subjects[0]
					var damage_amount = cfc.card_definitions[card.canonical_name]\
								.get("_amounts",{}).get("damage_amount")
					var effect_stacks = cfc.card_definitions[card.canonical_name]\
								.get("_amounts",{}).get("effect_stacks")
					if enemy_entity.active_effects.get_effect(Terms.ACTIVE_EFFECTS.disempower.name):
						var the_joke = [{
							"name": "modify_damage",
							"subject": "trigger",
							"amount": damage_amount,
							"tags": ["Attack", "Card"],
						}]
						execute_script(the_joke, script.owner, enemy_entity)
					else:
						var the_joke = [{
							"name": "apply_effect",
							"tags": ["Card"],
							"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
							"subject": "trigger",
							"modification": effect_stacks,
						}]
						execute_script(the_joke, script.owner, enemy_entity)
		"Barrel Through", "+ Barrel Through +", "= Barrel Through =":
			if not costs_dry_run:
				if subjects.size() and subjects[0] as EnemyEntity:
					var enemy_entity: EnemyEntity = subjects[0]
					if enemy_entity.active_effects.get_effect(Terms.ACTIVE_EFFECTS.vulnerable.name):
						var damage_amount = cfc.card_definitions[card.canonical_name]\
									.get("_amounts",{}).get("damage_amount")
						var barrel_through = [{
								"name": "modify_damage",
								"amount": damage_amount,
								"tags": ["Attack", "Card"],
								"subject": "boardseek",
								SP.KEY_SUBJECT_COUNT: "all",
								"sort_by": "random",
								"filter_state_seek": [{
									"filter_not_enemy": enemy_entity,
								}],
						}]
						execute_script(barrel_through, script.owner, enemy_entity)
		"Drag and Drop", "+ Drag and Drop +", "@ Drag and Drop @":
			if not costs_dry_run:
				if subjects.size():
					var dead_enemy = subjects[0]
					# Will execute the custom script either if the entry was
					# already removed, or if it has enough damage.
					if is_instance_valid(dead_enemy)\
							and ((dead_enemy in cfc.get_tree().get_nodes_in_group("EnemyEntities")
							and dead_enemy.damage < dead_enemy.health)
							or not dead_enemy in cfc.get_tree().get_nodes_in_group("EnemyEntities")):
						return
					var effect_stacks = cfc.card_definitions[card.canonical_name]\
								.get("_amounts",{}).get("effect_stacks")
					var fly_away = [{
						"name": "apply_effect",
						"tags": ["Card"],
						"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
						"subject": "dreamer",
						"modification": effect_stacks,
					}]
					execute_script(fly_away, script.owner, script.trigger_object)
		"Fowl Language","@ Fowl Language @","* Fowl Language *","% Fowl Language %":
			if not costs_dry_run:
				for subject in subjects:
					var dstacks = subject.active_effects.get_effect_stacks(
							Terms.ACTIVE_EFFECTS.disempower.name)
					if card.canonical_name == "% Fowl Language %":
						dstacks += 1
					var multiplier : int
					if card.deck_card_entry:
						multiplier = card.deck_card_entry\
								.get_property("_amounts").get("multiplier_amount")
					else:
						multiplier = cfc.card_definitions[card.canonical_name]\
								.get("_amounts",{}).get("multiplier_amount")
					var card_script := [{
							"name": "apply_effect",
							"tags": ["Card"],
							"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
							"subject": "trigger",
							"modification": dstacks * multiplier,
						}]
					execute_script(card_script, script.owner, subject)
		"Alertness":
			if not costs_dry_run:
				if cfc.NMAP.board.counters.get_counter("immersion") == 0:
					yield(cfc.NMAP.board.counters,"counter_modified")
				var decrease = cfc.card_definitions[card.canonical_name]\
						.get("_amounts",{}).get("immersion_amount")
				var card_script := [{
					"name": "mod_counter",
					"tags": ["Card"],
					"counter_name": "immersion",
					"modification": decrease,
				}]
				execute_script(card_script, script.owner, script.trigger_object)
		"Apathy":
			if not costs_dry_run and card.get_parent() == cfc.NMAP.deck:
				cfc.NMAP.deck.move_card_to_top(card)
		"Hyena", "+ Hyena +", "Ω Hyena Ω", "* Hyena *":
			if not costs_dry_run:
				if subjects.size() and subjects[0] as EnemyEntity:
					var enemy_entity: EnemyEntity = subjects[0]
					var buff = enemy_entity.active_effects.get_effect_with_most_stacks("Buff")
					if buff:
						var current_stacks = enemy_entity.active_effects.get_effect_stacks(buff)
						var modification = cfc.card_definitions[card.canonical_name]\
								.get("_amounts",{}).get("steal_amount", 2)
						if modification > current_stacks:
							modification = current_stacks
						var card_script := [
							{
								"name": "apply_effect",
								"tags": ["Card"],
								"effect_name": buff,
								"subject": "trigger",
								"modification": -modification,
							},
							{
								"name": "apply_effect",
								"tags": ["Card"],
								"effect_name": buff,
								"subject": "dreamer",
								"modification": modification,
							}
						]
						execute_script(card_script, script.owner, enemy_entity)
		"Subconscious", "= Subconscious =", "% Subconscious %":
			if not costs_dry_run:
#				print_debug(subjects[0].is_dead)
				if subjects.size() and subjects[0].is_dead:
					var increase_amount = cfc.card_definitions[card.canonical_name]\
								.get("_amounts",{}).get("increase_amount", 3)
					var payload := {
						"amount_key": "damage_amount",
						"amount_value": '+' + str(increase_amount),
					}
					card.deck_card_entry.modify_property("_amounts", payload)
		"Lethe":
			var rnd_memory = globals.player.get_random_memory()
			rnd_memory.lose_pathos(rnd_memory.pathos_threshold / 10.0)
		"Cockroach Infestation":
			var all_cards = cfc.get_tree().get_nodes_in_group("cards")
			CFUtils.shuffle_array(all_cards)
			for selected_card in all_cards:
				if selected_card.get_property("Type") == "Perturbation":
					continue
				if not selected_card.deck_card_entry:
					continue
				selected_card.deck_card_entry.scar()
				break
		"Cockroaches":
			var all_cards = cfc.get_tree().get_nodes_in_group("cards")
			CFUtils.shuffle_array(all_cards)
			for selected_card in all_cards:
				if selected_card.get_property("Type") == "Perturbation":
					continue
				if not selected_card.deck_card_entry:
					continue
				selected_card.deck_card_entry.enhance()
				break
		"Recurrence", "+ Recurrence +", "++ Recurrence ++":
			var all_intents = cfc.get_tree().get_nodes_in_group("SingleIntents")
			var owning_entity = null
			var stress := 0
			var perplex := 0
			var debuff := 0
			var buff := 0
			var other := 0
			var buff_selected : String
			var debuff_selected : String
			var special_effects := 0
			var stress_perplex_divider = 2.5
			var effect_divider = 2.0
			var special_multiplier = 1.0
			if card.canonical_name == "+ Recurrence +":
				stress_perplex_divider -= 0.5
				effect_divider -= 0.5
				special_multiplier += 0.5
			if card.canonical_name == "++ Recurrence ++":
				stress_perplex_divider -= 1
				effect_divider -= 1
				special_multiplier += 1
			for intent in all_intents:
				if intent.intent_script.name == "modify_damage":
					stress += int(intent.intent_script.amount)
				elif intent.intent_script.name == "assign_defence":
					perplex += int(intent.intent_script.amount)
				elif intent.intent_script.name == "apply_effect":
					if intent.intent_script.effect_name in Terms.get_all_effect_types('Buff'):
						if buff_selected == '':
							buff += int(intent.intent_script.modification)
							buff_selected = intent.intent_script.effect_name
					elif intent.intent_script.effect_name in Terms.get_all_effect_types('Debuff'):
						if debuff_selected == '':
							debuff += int(intent.intent_script.modification)
							debuff_selected = intent.intent_script.effect_name
					else:
						special_effects += 1
				else:
					other += 1
			var task : Dictionary
			var card_script := []
			var card_text := ''
			if stress > 0 or debuff > 0:
				task = {
					"name": "null_script",
					"tags": ["Card"],
					"subject": "target",
					"needs_subject": true,
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				}
				card_script.append(task)
				card_text += "Target a Torment. "
			if stress > 0:
				var interpret_amount := int(ceil(stress / stress_perplex_divider))
				task = {
						"name": "modify_damage",
						"amount": interpret_amount,
						"tags": ["Attack", "Card"],
						"subject": "previous",
				}
				card_script.append(task)
				card_text += "{attack} for %s. " % [interpret_amount]
			if perplex > 0:
				var perplex_amount := int(ceil(perplex / stress_perplex_divider))
				task = {
					"name": "assign_defence",
					"tags": ["Card"],
					"subject": "dreamer",
					"amount": perplex_amount
				}
				card_script.append(task)
				card_text += "Gain %s {defence} " % [perplex_amount]
			if buff > 0:
				var effect_amount = int(ceil(buff / effect_divider))
				task = {
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": buff_selected,
					"subject": "dreamer",
					"modification": effect_amount,
				}
				card_script.append(task)
				card_text += "Gain %s {%s} " % [effect_amount, buff_selected.to_lower()]
			if debuff > 0:
				var effect_amount = int(ceil(debuff / effect_divider))
				task = {
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": debuff_selected,
					"subject": "previous",
					"modification": effect_amount,
				}
				card_script.append(task)
				card_text += "Apply %s {%s} " % [effect_amount, debuff_selected.to_lower()]
			if special_effects > 0:
				var effect_amount = int(ceil(special_effects * special_multiplier))
				task = {
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": effect_amount,
				}
				card_script.append(task)
				card_text += "Gain %s {buffer} " % [effect_amount]
			if other > 0:
				var draw_amount = int(ceil(other * special_multiplier))
				task = {
					"name": "draw_cards",
					"tags": ["Card"],
					"card_count": draw_amount
				}
				card_script.append(task)
				card_text += "Draw %s Cards " % [draw_amount]
#			print_debug([stress, perplex, debuff, debuff_selected,buff, buff_selected ,other])
#			print_debug(card_text)
#			print_debug(card_script)
			var bbcode = Terms.get_bbcode_formats()
			card.modify_property("Abilities", card_text.format(bbcode))
			card.scripts = { "manual": { "hand": card_script }}
			var cost := 0
			if stress + perplex > 21:
				cost += 1
			if stress + perplex > 42:
				cost += 1
			if debuff + buff > 7:
				cost += 1
			if debuff + buff > 15:
				cost += 2
#			print_debug([stress + perplex, debuff + buff, cost])
			card.modify_property("Cost", cost)
			card.refresh_card_front()

# warning-ignore:unused_argument
func custom_alterants(script: ScriptObject) -> int:
	var alteration := 0
	return(alteration)


# Executes a custom script so that all modifiers are also handled.
func execute_script(
		script : Array,
		owner: Node,
		trigger_object: Node,
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	sceng = cfc.scripting_engine.new(
			script,
			owner,
			trigger_object,
			trigger_details)
	# In case the script involves targetting, we need to wait on further
	# execution until targetting has completed
	sceng.execute(CFInt.RunType.COST_CHECK)
	if not sceng.all_tasks_completed:
		yield(sceng,"tasks_completed")
	# If the dry-run of the ScriptingEngine returns that all
	# costs can be paid, then we proceed with the actual run
	if sceng.can_all_costs_be_paid and not only_cost_check:
		#print("DEBUG:" + str(state_scripts))
		# The ScriptingEngine is where we execute the scripts
		# We cannot use its class reference,
		# as it causes a cyclic reference error when parsing
		sceng.execute()
		if not sceng.all_tasks_completed:
			yield(sceng,"tasks_completed")
	# This will only trigger when costs could not be paid, and will
	# execute the "is_else" tasks
	elif not sceng.can_all_costs_be_paid and not only_cost_check:
		#print("DEBUG:" + str(state_scripts))
		sceng.execute(CFInt.RunType.ELSE)
	return(sceng)
