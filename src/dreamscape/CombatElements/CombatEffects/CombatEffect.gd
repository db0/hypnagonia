class_name CombatEffect
extends CombatSignifier

signal scripting_started(sceng)
signal scripting_finished(sceng)
signal stacks_modified(value)

var self_decreasing : int = Terms.SELF_DECREASE.FALSE
var decrease_type : int = Terms.DECREASE_TYPE.REDUCE
var priority : int = Terms.ALTERANT_PRIORITY.ADD

var entity_type: String
var owning_entity: CombatEntity
var stacks: int = 0 setget set_stacks
# This is used to track how many stacks have been used during a predictions run
var snapshot_stacks: Dictionary
# Used for custom effects from cards which can be upgraded
# The string signifies the upgrade used, and should be handled
# By the script code directly.
var upgrade: String
# A delayed effect has no impact until the player starts their turn,
# after which it becomes active.
# This allows the enemy to assign intents to the player which will not disappear/reduce
# before the player has a chance to see them.
var is_delayed := false
var effect_definition : Dictionary


func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	.setup(signifier_details, signifier_name)
	entity_type = signifier_details["entity_type"]
	self_decreasing = effect_definition.get("self_decreasing", Terms.SELF_DECREASE.FALSE)
	decrease_type = effect_definition.get("decrease_type", Terms.DECREASE_TYPE.REDUCE)
	priority = effect_definition.get("alterant_priority", Terms.ALTERANT_PRIORITY.ADD)


func set_stacks(value: int, tags := ["Manual"], can_go_negative := false) -> void:
	if value < 0 and not can_go_negative:
		value = 0
	if not "Init" in tags:
		owning_entity.emit_signal(
				"effect_modified",
				owning_entity,
				"effect_modified",
				{"effect_name": name,
				"effect_node": self,
				SP.TRIGGER_PREV_COUNT: stacks,
				SP.TRIGGER_NEW_COUNT: value,
				"tags": tags})
	if value == 0:
		stacks = 0
		queue_free()
	else:
		# if the script had a delayed tag, it will not become active
		# until the next time the player's turn starts (so that they see it and take it into account)
		# Unless the player already had some stacks, in which case it is effective
		# immediately.
		if "Delayed" in tags and stacks == 0:
			is_delayed = true
#		signifier_amount.text = str(value)
		update_amount_animated(value, stacks < value)
		stacks = value
		# If it's an effect that can go to negative values, then we make the icon red
		# when it is negative
		if stacks < 0:
			signifier_icon.modulate = Color(1,0,0)
		# Otherwise we ensure the icon stays at it's normal colour
		elif can_go_negative:
			signifier_icon.modulate = Color(1,1,1)
	emit_signal("stacks_modified", value)

# To override. This is called by the scripting engine
# Is source is telling this script whether we're checking for alterants affecting the
# entity applying this effect, or the antity receiving this effect.
func get_effect_alteration(
		_script: ScriptTask,
		_value: int,
		_sceng,
		_is_source: bool,
		_dry_run:= true,
		_subject: Node = null) -> int:
	return(0)

func _on_CombatSingifier_mouse_entered() -> void:
	_set_current_description()
	._on_CombatSingifier_mouse_entered()


func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[entity_type].duplicate()
	var effect_entry = Terms.get_term_entry(canonical_name, 'description')
	var diff_description = Terms.get_term_entry(canonical_name, 'description')
	format["effect_name"] = name
	if effect_entry.has("rich_text_icon"):
		format["effect_icon"] = "[img=18x18]" + effect_entry.rich_text_icon + "[/img]"
	format["amount"] = str(stacks)
	format["double_amount"] = str(2*stacks)
	format["triple_amount"] = str(3*stacks)
	# warning-ignore:integer_division
	format["half_amount"] = str(stacks/2)
	format["increased"] = "increased"
	format["upgrade"] = upgrade
	# Impervious/Marked effects max out at 3 stacks.
	var imp_mark_stacks = stacks
	if imp_mark_stacks > 3:
		imp_mark_stacks = 3
	format["imp_mark_pct"] = str(imp_mark_stacks * 0.25 * 100) + '%'
	if stacks < 0:
		format["increased"] = "decreased"
		format["amount"] = str(abs(stacks))
	decription_label.bbcode_text = _get_effect_description().\
			format(format).format(Terms.get_bbcode_formats(18))
	if effect_entry.get("linked_terms"):
		var linked_terms = {
			"already_added": [],
			"dreamer": [],
			"torment": [],
		}
		linked_terms[entity_type] = effect_entry.get("linked_terms")
		cfc.ov_utils.add_linked_terms(focus_info, linked_terms)

func _get_effect_description() -> String:
	var effect_entry : Dictionary = Terms.ACTIVE_EFFECTS[_get_template_name()]
	var effect_description : String = effect_entry.get('description', '')
	var diff_desc :Dictionary= effect_entry.get('difficulty_adjusted_description', {})
	if not diff_desc.empty():
		for key in diff_desc:
			effect_description = diff_desc[key].get(globals.difficulty[key], effect_description)
	if owning_entity.type == Terms.PLAYER:
		effect_description += effect_entry.get('extra_dreamer_description', '')
	if effect_entry.get("is_card_reference"):
		var card_reference = cfc.card_definitions.get(name)
		if effect_description == '':
			# The format_key_to_replace_with_amount key, when set, allows us to specify an effect that
			# while it's using the card text as its string, it nevertheless, replaces one format key of the
			# card description with the {amount} key, which will be replaced with the amount of stacks
			# on this condition. This is typically used on conditions which apply multiple stacks
			# If concentration_stacks is used in the description, it is also assumed we want to
			# replace it with the stack amount
			var repl_key = effect_entry.get('format_key_to_replace_with_amount', "concentration_stacks")
			if repl_key:
				effect_description = card_reference["Abilities"].format({repl_key: "{amount}"}).format(card_reference.get("_amounts", {}))
			else:
				effect_description = card_reference["Abilities"].format(card_reference.get("_amounts", {}))
		else:
				effect_description = effect_description.format(card_reference.get("_amounts", {}))
	return(effect_description)

# Returns the lowercase name of the token, including its upgrade modifier
func get_effect_name() -> String:
	return(name)

# Returns the "generic" name of this effect as found in Terms
# E.g. if the poison effect has been renamed doubt
# This method will return 'poison'
func _get_template_name() -> String:
	var template_name := canonical_name
	for effect in Terms.ACTIVE_EFFECTS:
		if Terms.ACTIVE_EFFECTS[effect].name == canonical_name:
			template_name = effect
	return(template_name)

# Executes a custom script defined in an effect
func execute_script(
		script := [],
		trigger_object: Node = self,
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	for task in script:
		task["starting_position_node"] = self
	sceng = cfc.scripting_engine.new(
			script,
			get_parent().combat_entity,
			trigger_object,
			trigger_details)
	emit_signal("scripting_started", sceng)
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
	emit_signal("scripting_finished", sceng)
	return(sceng)

func take_snapshot(snapshot_id: float) -> void:
	snapshot_stacks[snapshot_id] = stacks

func clear_snapshot(snapshot_id: int) -> void:
	# warning-ignore:return_value_discarded
	snapshot_stacks.erase(snapshot_id)


# This is connected in the BoardSignalConnector class
func _on_player_turn_ended(_turn: Turn) -> void:
	if entity_type == Terms.PLAYER and self_decreasing == Terms.SELF_DECREASE.TURN_END:
		_decrease_stacks()

# This is connected in the BoardSignalConnector class
func _on_player_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.PLAYER and self_decreasing == Terms.SELF_DECREASE.TURN_START:
		if is_delayed:
			is_delayed = false
		else:
			_decrease_stacks()
	elif is_delayed:
		is_delayed = false

# This is connected in the BoardSignalConnector class
func _on_enemy_turn_ended(_turn: Turn) -> void:
	if entity_type == Terms.ENEMY and self_decreasing == Terms.SELF_DECREASE.TURN_END:
		if is_delayed:
			is_delayed = false
		else:
			_decrease_stacks()

# This is connected in the BoardSignalConnector class
func _on_enemy_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.ENEMY and self_decreasing == Terms.SELF_DECREASE.TURN_START:
		_decrease_stacks()

func _decrease_stacks() -> void:
	match decrease_type:
		Terms.DECREASE_TYPE.REDUCE:
			set_stacks(stacks - 1, ["Turn Decrease"])
		Terms.DECREASE_TYPE.HALVE:
			# warning-ignore:integer_division
			set_stacks(stacks / 2, ["Turn Decrease"])
		Terms.DECREASE_TYPE.ZERO:
			set_stacks(0, ["Turn Decrease"])
