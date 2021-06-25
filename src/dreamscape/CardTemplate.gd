extends Card

# Going negative to avoid conflicting with CGF in case it extends its own card states
enum ExtendedCardState {
	REMOVE_FROM_GAME = -5
}
const remove_from_game_shader := preload("res://shaders/consume.shader")

var shader_progress := 0.0
var attempted_action_drop_to_board := false
var tutorial_disabled := false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	match state:
		ExtendedCardState.REMOVE_FROM_GAME:
			z_index = 99
			set_focus(false)
			set_control_mouse_filters(false)
			buttons.set_active(false)
			set_card_rotation(0,false,false)
			shader_progress += delta
#			print_debug(shader_progress, delta)
			card_front.material.set_shader_param(
						'progress', shader_progress)
			if get_parent().is_in_group("hands"):
				var parent = get_parent()
				var currect_pos = global_position
				parent.remove_child(self)
				cfc.NMAP.board.add_child(self)
				global_position = currect_pos
				for c in parent.get_all_cards():
						c.interruptTweening()
						c.reorganize_self()
			if shader_progress > 0.1:
				for label in card_front.card_labels:
					if card_front.card_labels[label].visible:
						card_front.card_labels[label].visible = false
			if shader_progress > 0.8:
				queue_free()

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
	var found_scripts = .retrieve_scripts(trigger).duplicate(true)
	if trigger == "manual" and get_state_exec() == "hand":
		found_scripts = insert_payment_costs(found_scripts)
		if get_property("Type") == "Concentration":
			found_scripts["hand"] += generate_remove_from_deck_tasks()
		else:
			found_scripts["hand"] += generate_discard_tasks()
	return(found_scripts)

# Sets a flag when an action card is dragged to the board manually
# which will trigger the game to execute its scripts
# warning-ignore:unused_argument
func common_pre_move_scripts(new_container: Node, old_container: Node, tags: Array) -> Node:
	var target_container := new_container
	if new_container == cfc.NMAP.board \
			and old_container == cfc.NMAP.hand:
		attempted_action_drop_to_board = true
	return(target_container)

# Executes some extra logic depending on the type of card moved
func common_post_move_scripts(new_container: Node, old_container: Node, tags: Array) -> void:
	# If a non-shader was moved to the board from hand, we want to pay its costs
	if new_container == cfc.NMAP.board\
			and old_container == cfc.NMAP.hand\
			and not "Scripted" in tags:
		pay_play_costs()
	# if an action was dragged to the board, it will have returned to hand now
	# and have a special flag set. Therefore we execute its scripts
	if attempted_action_drop_to_board:
		execute_scripts()
		attempted_action_drop_to_board = false
	# We record the first played card of each type, for effect triggers
	if new_container == cfc.NMAP.discard and old_container == cfc.NMAP.hand:
		var firsts = cfc.NMAP.board.turn.firsts
		if firsts.empty() or not firsts.get(properties.Type):
			firsts[properties.Type] = self

func get_modified_immersion_cost() -> Dictionary:
	var immersion_cost_details : Dictionary =\
			get_property_and_alterants("Cost")
	var modified_cost : int = immersion_cost_details.value
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

# Uses a template to create task definitions for paying time and kudos costs
# then returns it to the calling function to execute or insert it into
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
	if immersion_cost:
		var cost_script = payment_script_template.duplicate()
		cost_script["modification"] = -immersion_cost
		cost_script["counter_name"] = "immersion"
		pay_tasks.append(cost_script)
	return(pay_tasks)

# Uses a template to create task definitions for discarding a card
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
func generate_discard_tasks() -> Array:
	var discard_script_template := {
			"name": "move_card_to_container",
			"subject": "self",
			"tags": ["Played"],
			"dest_container": cfc.NMAP.discard}
	var discard_tasks = [discard_script_template]
	return(discard_tasks)

# Uses a template to create task definitions for discarding a card
# then returns it to the calling function to execute or insert it into
# the cards existing scripts for its state.
func generate_remove_from_deck_tasks() -> Array:
	var remove_script_template := {
			"name": "remove_card_from_game",
			"subject": "self",
			"tags": ["Played"]}
	var remove_tasks = [remove_script_template]
	return(remove_tasks)

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

func execute_scripts(
		trigger_card: Card = self,
		trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = .execute_scripts(
		trigger_card,
		trigger,
		trigger_details,
		only_cost_check)
	if sceng is GDScriptFunctionState: # Still working.
		sceng = yield(sceng, "completed")
	for entity in cfc.get_tree().get_nodes_in_group("CombatEntities"):
		entity.clear_predictions()

func common_pre_run(sceng) -> void:
	sceng.predict()

func remove_from_game() -> void:
	card_front.material = ShaderMaterial.new()
	card_front.material.shader = remove_from_game_shader
	state = ExtendedCardState.REMOVE_FROM_GAME
	cfc.flush_cache()

