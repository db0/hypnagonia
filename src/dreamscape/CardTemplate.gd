class_name DreamCard
extends Card


# Going negative to avoid conflicting with CGF in case it extends its own card states
enum ExtendedCardState {
	REMOVE_FROM_GAME = -5
	AUTOPLAY_DISPLAY
	SPAWNED_PERTURBATION
}

signal ready_to_remove

var shader_progress := 1.0
var attempted_action_drop_to_board := false
var tutorial_disabled := false
var pertub_destination : CardContainer
# Stores a referene to the DeckCard object for this card
# This is used to store permanent changes to this card that will persist
# Between encounters
var deck_card_entry
# Stores the riders currently active on this card
var enabled_riders := []
# Stores the original properties of the card
var printed_properties := {}
var check_front_refresh := false
var front_refresh_delta_wait := 0
# I use this to allow me to autoplay the same card more than 1 time
# as further autoplays, need to wait until this flag is cleared
var queued_autoplays := []

func _ready() -> void:
	# warning-ignore:return_value_discarded
	connect("state_changed", self, "_on_state_changed")
	# warning-ignore:return_value_discarded
	cfc.connect("cache_cleared", self, "_on_cache_cleared")


func _process(delta: float) -> void:
	match state:
		ExtendedCardState.REMOVE_FROM_GAME:
			z_index = 99
			set_focus(false)
			set_control_mouse_filters(false)
			buttons.set_active(false)
			# warning-ignore:return_value_discarded
			set_card_rotation(0,false,false)
			shader_progress -= delta
#			print_debug(shader_progress, delta)
#			card_front.shader_effect.material.set_shader_param(
#						'progress', shader_progress)
			card_front.material.set_shader_param(
						'dissolve_value', shader_progress)
			if get_parent().is_in_group("hands"):
				var parent = get_parent()
				var currect_pos = global_position
				parent.remove_child(self)
				cfc.NMAP.board.add_child(self)
				global_position = currect_pos
				for c in parent.get_all_cards():
						c.interruptTweening()
						c.reorganize_self()
#			if shader_progress > 0.1:
#				card_front._card_text.visible = false
#				card_front.cost_container.visible = false
#				card_front.tag_container1.visible = false
#				card_front.tag_container2.visible = false
#				card_front.card_design.visible = false
#				card_front.art.visible = false
			if shader_progress < 0.15:
				emit_signal("ready_to_remove")
			if shader_progress < 0.1:
				if cfc.NMAP.board.mouse_pointer.current_focused_card == self:
					cfc.NMAP.board.mouse_pointer.current_focused_card = null
				queue_free()
		ExtendedCardState.AUTOPLAY_DISPLAY:
			z_index = 0
			set_focus(false)
			set_control_mouse_filters(false)
			buttons.set_active(false)
		ExtendedCardState.SPAWNED_PERTURBATION:
			z_index = 0
			set_focus(false)
			set_control_mouse_filters(false)
			buttons.set_active(false)
			if not _tween.is_active()\
					and not scale.is_equal_approx(Vector2(1,1)):
				_add_tween_scale(scale, Vector2(1,1),0.75)
				_add_tween_global_position(global_position, get_viewport().size/2 - CFConst.CARD_SIZE/2)
				_tween.start()
				yield(_tween, "tween_all_completed")
				_tween_stuck_time = 0
				move_to(pertub_destination)
				pertub_destination = null
	if check_front_refresh:
		# To avoid the game clearing and resetting the prediction icons too many times
		# in the same tick, we spool all the requests to clear predictions, then set them
		# only one time
		front_refresh_delta_wait += 1
		if front_refresh_delta_wait >= 5:
			check_front_refresh = false
			front_refresh_delta_wait = 0
			highlight_modified_properties()


func setup() -> void:
	.setup()
	card_front.set_rarity()
	if get_parent().name != "Viewport":
		card_front.set_tag_icon(get_property("Tags"))
	if printed_properties.empty():
		printed_properties = properties.duplicate()
	var card_art
	var beta_art
	var card_animation
	var lookup_card_name: String = canonical_name
	if get_property("_is_upgrade"):
		lookup_card_name = find_upgrade_parent()
	if lookup_card_name == "Interpretation":
		if globals.encounters:
			card_art = globals.encounters.interpretation_illustration
		else:
			card_art = ImageLibrary.get_multiple_art_option("Interpretation")
	elif lookup_card_name == "Confidence":
		if globals.encounters:
			card_art = globals.encounters.confidence_illustration
		else:
			card_art = ImageLibrary.get_multiple_art_option("Confidence")
	else:
		beta_art = ImageLibrary.BETA_IMAGES.get(lookup_card_name)
		card_art = ImageLibrary.FINAL_IMAGES.get(lookup_card_name, beta_art)
		card_animation = ImageLibrary.FINAL_VIDEOS.get(lookup_card_name)
	var is_placeholder = false
	if card_art == beta_art:
		is_placeholder = true
	if card_animation:
		card_front.set_card_animation(card_animation, is_placeholder)
	elif card_art:
		card_front.set_card_art(card_art, is_placeholder)
	if deck_card_entry:
		if deck_card_entry.is_scarred():
			card_front.scarred.visible = true
		if deck_card_entry.is_enhanced():
			card_front.enhanced.visible = true


func refresh_property_label(property: String) -> void:
	if not is_instance_valid(card_front) or not card_front.card_labels.has(property):
		return
	.refresh_property_label(property)
	if get_parent().name != "Viewport" and property == 'Tags':
		card_front.set_tag_icon(get_property("Tags"))


# Sample code on how to figure out costs of a card
func get_modified_credits_cost() -> int:
	var modified_cost : int = properties.get("Cost", 0)
	return(modified_cost)

# Retrieves the card scripts either from those defined on the card
# itself, or from those defined in the script definition files
#
# Returns a dictionary of card scripts for this specific card
# based on the current trigger.
func retrieve_scripts(trigger: String) -> Dictionary:
	if tutorial_disabled:
		return({})
	var found_scripts
	if not scripts.empty() and not scripts.get(trigger,{}).empty():
		found_scripts = scripts.get(trigger,{}).duplicate(true)
	elif deck_card_entry:
		found_scripts = deck_card_entry.retrieve_scripts(trigger, properties)
	else:
		found_scripts= .retrieve_scripts(trigger).duplicate(true)
	if trigger == "manual" and get_state_exec() == "hand" and state != ExtendedCardState.AUTOPLAY_DISPLAY:
		found_scripts = insert_payment_costs(found_scripts)
		if typeof(found_scripts["hand"]) == TYPE_ARRAY:
			if get_property("Type") == "Concentration" or get_property("_is_concentration"):
				found_scripts["hand"] += generate_remove_from_deck_tasks()
			else:
				found_scripts["hand"] += generate_discard_tasks()
			found_scripts["hand"] += generate_play_confirm_scripts()
		# This injects into multiple-option dictionaries
		else:
			for key in found_scripts["hand"]:
				if get_property("Type") == "Concentration" or get_property("_is_concentration"):
					found_scripts["hand"][key] += generate_remove_from_deck_tasks()
				elif not has_move_script(found_scripts["hand"][key]):
					found_scripts["hand"][key] += generate_discard_tasks()
				found_scripts["hand"][key] += generate_play_confirm_scripts()
	return(found_scripts)


func has_move_script(script: Array) -> bool:
	for script_task in script:
		if script_task.name == "move_card_to_container":
			return(true)
	return(false)


# Sets a flag when an action card is dragged to the board manually
# which will trigger the game to execute its scripts
# warning-ignore:unused_argument
func common_pre_move_scripts(new_container: Node, old_container: Node, tags: Array) -> Node:
	if "Played" in tags:
		SoundManager.play_se(Sounds.get_card_play_sound())
	var target_container := new_container
	if new_container == cfc.NMAP.board \
			and old_container == cfc.NMAP.hand:
		attempted_action_drop_to_board = true
	return(target_container)


# Executes some extra logic depending on the type of card moved
func common_post_move_scripts(new_container: String, old_container: String, tags: Array) -> void:
	if new_container == cfc.NMAP.board.name\
			and old_container == cfc.NMAP.hand.name\
			and not "Scripted" in tags:
		pay_play_costs()
	# if an action was dragged to the board, it will have returned to hand now
	# and have a special flag set. Therefore we execute its scripts
	if attempted_action_drop_to_board:
		execute_scripts()
		attempted_action_drop_to_board = false
	# We record the first played card of each type, for effect triggers
	# Cards are considered "played" if they were moved to their final
	# CardContainer with a script using the "Played" tag
	if "Played" in tags:
		SoundManager.play_se(Sounds.get_card_play_sound())
		var firsts = cfc.NMAP.board.turn.firsts
		if firsts.empty() or not firsts.get(properties.Type):
			firsts[properties.Type] = self
		scripting_bus.emit_signal("card_played",
				self,
				{
					"destination": new_container,
					"source": old_container,
					"tags": tags
				}
		)


func get_modified_immersion_cost() -> Dictionary:
	var immersion_cost_details : Dictionary =\
			get_property_and_alterants("Cost")
	var modified_cost = immersion_cost_details.value
	if str(immersion_cost_details.value) == 'X':
		modified_cost = cfc.NMAP.board.counters.get_counter("immersion", self)
	var return_dict = {
		"modified_cost": modified_cost,
		"cards_modifier": immersion_cost_details.alteration.value_alteration,
		"alterant_cards": merge_modifier_dicts(immersion_cost_details)
	}
	return(return_dict)


# Merges alterant modifiers with temp_modifiers into one Dictionary
func merge_modifier_dicts(container_dict) -> Dictionary:
	var modifier_details : Dictionary =\
			container_dict.alteration.alterants_details.duplicate()
	for c in container_dict.temp_modifiers.modifier_details:
		if c in modifier_details.keys():
			modifier_details[c] += container_dict.temp_modifiers.modifier_details[c]
		else:
			modifier_details[c] = container_dict.temp_modifiers.modifier_details[c]
	return(modifier_details)


# Adds payment costs into a card's custom scripts under a special trigger
# and executes them so that they are all processed by the ScriptingEngine
func pay_play_costs() -> void:
	var state_exec = get_state_exec()
	scripts["payments"] = {}
	scripts["payments"][state_exec] = generate_play_costs_tasks()
	execute_scripts(self,"payments")
	scripts["payments"].clear()


# Uses a template to create task definitions for paying immersion costs
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
func generate_play_costs_tasks() -> Array:
	var payment_script_template := {
			"name": "mod_counter",
			"is_cost": true,
			"modification": 0,
			"tags": ["PlayCost"],
			"counter_name":  "counter"}
	var pay_tasks = []
	var immersion_cost = get_modified_immersion_cost().modified_cost
	if immersion_cost and typeof(immersion_cost) == TYPE_INT:
		var cost_script = payment_script_template.duplicate()
		cost_script["modification"] = -immersion_cost
		cost_script["counter_name"] = "immersion"
		pay_tasks.append(cost_script)
	return(pay_tasks)


# Uses a template to create task definitions for discarding a card
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
func generate_discard_tasks(specify_parent := "hand", tags := []) -> Array:
	if properties.get("_avoid_normal_discard"):
		return([])
	var discard_script_template := {
			"name": "move_card_to_container",
			"subject": "self",
			"tags": tags + ["Played"],
			"dest_container": cfc.NMAP.discard.name,
		}
	if specify_parent != '':
		discard_script_template["filter_state_subject"] = [{"filter_parent": specify_parent}]
	var discard_tasks = [discard_script_template]
	return(discard_tasks)


# Uses a template to inject a sceng task which increments a counter
# for each tag the card has. This allows us to keep track of how many cards
# with each tag we've played, to hook onto with other effects.
#
# The reason to go via sceng, is because we  don't want to increment if costs
# cannot be paid.
func generate_play_confirm_scripts() -> Array:
	var confirm_play_template := {
			"name": "confirm_play",
		}
	return([confirm_play_template])


# Uses a template to create task definitions for removing  a card permenanently from the deck
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
# If permanent is true, card will be removed for the whole run.
func generate_remove_from_deck_tasks(permanent := false, tags := []) -> Array:
	var remove_script_template := {
			"name": "remove_card_from_deck",
			"subject": "self",
			"is_permanent": permanent,
			"tags": tags + ["Played"]}
	var remove_tasks = [remove_script_template]
	return(remove_tasks)


# Injects the play costs into the existing scripts
func insert_payment_costs(found_scripts) -> Dictionary:
	var array_with_costs := generate_play_costs_tasks()
	var state_scripts = found_scripts.get("hand",[])
	if typeof(state_scripts) == TYPE_ARRAY:
		array_with_costs += state_scripts
		found_scripts["hand"] = array_with_costs.duplicate()
	else:
		for key in state_scripts:
			var temp_array = array_with_costs.duplicate(true)
			temp_array += state_scripts[key]
			found_scripts["hand"][key] = temp_array
	return(found_scripts)


# Extends the normal execute scripts to also clear the predicions shown
# on Enemy entities
func execute_scripts(
		trigger_card: Card = self,
		trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	if is_executing_scripts and trigger == "manual":
		return
	if trigger == "player_turn_started":
		pass
	var sceng = .execute_scripts(
		trigger_card,
		trigger,
		trigger_details,
		only_cost_check)
	if sceng is GDScriptFunctionState: # Still working.
		sceng = yield(sceng, "completed")


func get_state_exec() -> String:
	var state_exec = .get_state_exec()
	# We don't check according to the parent name
	# as that can change.
	# Might consier checking on the parent class if this gets too complicated.
	match state:
		CardState.DRAGGED, ExtendedCardState.AUTOPLAY_DISPLAY:
			state_exec = "hand"
	return(state_exec)


func common_pre_execution_scripts(_trigger: String, trigger_details: Dictionary) -> void:
	# We inject the amount of immersion we have into the trigger details
	# So that it may be used for filter_x_amount if it exists
	trigger_details["immersion_amount"] = cfc.NMAP.board.counters.get_counter("immersion")


# I'm using this to show the predicted damage on enemies
func common_pre_run(sceng) -> void:
	# We need to store the immersion before it's used by the scripts
	# so that the X effects remember what it was
	sceng.x_usage = cfc.NMAP.board.counters.get_counter("immersion")
	var snapshot_id = int(rand_range(1,100000))
	sceng.predict(snapshot_id)


# Removes this card from the game completely.
# This means the card is also removed permanently from the player's deck
# This change stays for all further encounters
func remove_from_deck(permanent := true, tags := []) -> void:
#	card_front.apply_shader("res://shaders/consume.shader")
	card_front.material = preload("res://shaders/dissolve.tres")
#	card_front.material.shader = CFConst.REMOVE_FROM_GAME_SHADER
	set_state(ExtendedCardState.REMOVE_FROM_GAME)
	# I am using a signal here so that I can abort the card removal If I need to
	connect("ready_to_remove", self, "_perform_remove_cleanup", [permanent, tags])
	if "Played" in tags:
		var firsts = cfc.NMAP.board.turn.firsts
		if firsts.empty() or not firsts.get(properties.Type):
			firsts[properties.Type] = self
		scripting_bus.emit_signal("card_played",
				self,
				{
					"destination": null,
					"source": get_parent().name,
					"tags": tags
				}
		)

func abort_deck_removal() -> void:
	if state != ExtendedCardState.REMOVE_FROM_GAME:
		return
	# Hardcoding the state change because normally if the card is being removed from the game
	# set_state() prevents changing state anymore. But in this instance this is exactly what we need
	if get_parent().is_in_group("hands"):
		state = CardState.IN_HAND
	# The extra if is in case the ViewPopup is currently active when the card
	# is being moved into the container
	elif get_parent().is_in_group("piles"):
		state =  CardState.IN_PILE
	elif "CardPopUpSlot" in get_parent().name:
		state =  CardState.IN_POPUP
	else:
		state = CardState.ON_PLAY_BOARD
	card_front.material = null
	shader_progress = 1.0
	

# THis function performs the cleanup of the card about to be removed from the board.
func _perform_remove_cleanup(ipermanent: bool, tags: Array) -> void:
	cfc.flush_cache()
	scripting_bus.emit_signal("card_removed",
			self,
			{
				"tags": tags
			}
	)
	# If this is a permanent removal, we also remove the card from the
	# whole run
	if deck_card_entry and ipermanent and not properties.get("_is_unremovable", false):
		globals.player.deck.remove_card(deck_card_entry)


func reorganize_self() ->void:
	if state == ExtendedCardState.REMOVE_FROM_GAME:
		return
	.reorganize_self()

func check_play_costs() -> Color:
	var ret : Color = CFConst.CostsState.OK
	var immersion_cost = get_modified_immersion_cost().modified_cost
	if typeof(immersion_cost) == TYPE_STRING:
		ret = CFConst.CostsState.IMPOSSIBLE
	elif immersion_cost > cfc.NMAP.board.counters.get_counter("immersion", self):
		ret = CFConst.CostsState.IMPOSSIBLE
	# I need to check the type due to X costs
	elif typeof(properties.get("Cost")) == TYPE_INT and immersion_cost > properties.get("Cost", 0):
		ret = CFConst.CostsState.INCREASED
	elif typeof(properties.get("Cost")) == TYPE_INT and immersion_cost < properties.get("Cost", 0):
		ret = CFConst.CostsState.DECREASED
	if cfc.NMAP.board.turn.current_turn != Turn.Turns.PLAYER_TURN:
		ret = CFConst.CostsState.IMPOSSIBLE
	if properties.get("_is_unplayable", false):
		ret = CFConst.CostsState.IMPOSSIBLE
	if properties.get("Tags", []).has(Terms.GENERIC_TAGS.init.name)\
			and cfc.NMAP.board.turn.turn_event_count.get("cards_played", 0) > 0:
		ret = CFConst.CostsState.IMPOSSIBLE
	if properties.get("Tags", []).has(Terms.GENERIC_TAGS.once_off.name):
		for variant in HUtils.get_all_card_variants(canonical_name):
			if cfc.NMAP.board.turn.turn_cards_played.get(variant, 0) > 0:
				ret = CFConst.CostsState.IMPOSSIBLE
	# Distracted Perturbation
	if typeof(properties.get("Cost")) == TYPE_INT\
			and immersion_cost >= 2\
			and cfc.NMAP.hand.has_card_name('Distracted'):
		ret = CFConst.CostsState.IMPOSSIBLE
	# Delighted Effect
	if cfc.NMAP.board.dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.delighted.name) > 0\
			and get_property("Type") == "Action":
		if not cfc.NMAP.board.dreamer.active_effects.get_effect(Terms.ACTIVE_EFFECTS.delighted.name).is_delayed:
			ret = CFConst.CostsState.IMPOSSIBLE
	return(ret)


# Riders are special flags set to the card which will perform something
# when a certain condition is met
func enable_rider(rider: String) -> void:
	if not rider in enabled_riders:
		enabled_riders.append(rider)
	match rider:
		# Resets the card's cost to its printed value after being played.
		"reset_cost_after_play":
			# warning-ignore:return_value_discarded
			scripting_bus.connect("card_played", self, "_on_self_played")


func connect_card_entry(card_entry) -> void:
	deck_card_entry = card_entry
	deck_card_entry.connect("card_entry_modified", self, "on_card_entry_modified")


func on_card_entry_modified(card_entry) -> void:
	properties = card_entry.properties.duplicate(true)
	refresh_card_front()


func set_state(value: int) -> void:
	if state == ExtendedCardState.REMOVE_FROM_GAME:
		return
	.set_state(value)


func _on_self_played(card, _details) -> void:
	if card != self:
		return
	if "reset_cost_after_play" in enabled_riders:
		# warning-ignore:return_value_discarded
		modify_property("Cost", printed_properties['Cost'])
		enabled_riders.erase("reset_cost_after_play")



# Overridable function for formatting card text
func _get_formatted_text(value) -> String:
	var text = str(value)
	var amounts_format = HUtils.get_amounts_format(properties, printed_properties)
	if not amounts_format.size():
		amounts_format = HUtils.get_amounts_format(cfc.card_definitions[canonical_name])
	return(text.format(amounts_format))


func highlight_modified_properties() -> void:
	# We don't check cards in deck to reduce operations
	if state == CardState.IN_PILE:
		return
	if state == CardState.DECKBUILDER_GRID:
		return
	if state == CardState.PREVIEW:
		return
	if not is_instance_valid(card_front):
		return
	for property in properties:
		if property.begins_with("_"):
			continue
		var label_node = card_front.card_labels[property]
		var current_property = get_property(property)
		if property in CardConfig.PROPERTIES_NUMBERS:
			var value_text := str(current_property)
			# To catch comparing things like 'X' to 0
			if str(current_property) != str(printed_properties.get(property))\
					and value_text != label_node.text:
				card_front.set_label_text(label_node,value_text)
			elif value_text != label_node.text:
				card_front.set_label_text(label_node,value_text)
			if typeof(current_property) != typeof(printed_properties.get(property)):
				label_node.modulate = Color(1,1,0)
			elif current_property < printed_properties.get(property):
				label_node.modulate = Color(0,1,0)
			elif current_property > printed_properties.get(property):
				label_node.modulate = Color(1,0,0)
			else:
				label_node.modulate = Color(1,1,1)


func find_upgrade_parent():
	return(HUtils.find_upgrade_parent(canonical_name))


func refresh_card_front() -> void:
	.refresh_card_front()
	highlight_modified_properties()
	if deck_card_entry.is_scarred():
		card_front.scarred.visible = true
	if deck_card_entry.is_enhanced():
		card_front.enhanced.visible = true

# Overridable function to allow games to extend the _on_Card_gui_input() functionality
func _process_more_card_inputs(event) -> void:
	if event.is_pressed() and event.get_button_index() == 2:
		if state == CardState.FOCUSED_IN_HAND:
			for c in get_parent().get_all_cards():
				c.reorganize_self()
		else:
			set_to_idle()
		var upgrade_options = properties.get("_upgrades", [])
		var select_return = cfc.ov_utils.select_card(
				upgrade_options, 0, "display", false, cfc.NMAP.board)
		if select_return is GDScriptFunctionState: # Still working.
			select_return = yield(select_return, "completed")


func _start_dragging(drag_offset: Vector2) -> void:
	._start_dragging(drag_offset)
	if is_executing_scripts:
		return
	var card_scripts = retrieve_scripts("manual")
	if typeof(card_scripts[get_state_exec()]) != TYPE_DICTIONARY:
		var _sceng = .execute_scripts(self, "manual", {}, true)


func _on_state_changed(_card: Card, old_state: int, _new_state: int) -> void:
	if old_state == CardState.DRAGGED:
		for entity in cfc.get_tree().get_nodes_in_group("CombatEntities"):
			entity.clear_predictions()

func _on_cache_cleared() -> void:
	check_front_refresh = true
	
func _determine_idle_state() -> void:
	if state == ExtendedCardState.AUTOPLAY_DISPLAY:
		return
	._determine_idle_state()
