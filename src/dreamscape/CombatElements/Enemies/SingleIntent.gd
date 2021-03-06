extends CombatSignifier

var intent_script : Dictionary
var owning_entity

func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	.setup(signifier_details, signifier_name)
	intent_script = signifier_details.duplicate(true)
	intent_script["starting_position_node"] = self
#	recalculate_amount()
# warning-ignore:return_value_discarded
#	cfc.connect("cache_cleared", self, 'recalculate_amount')
	signifier_icon_container.visible = false
	signifier_extra_container.visible = false

func recalculate_amount(snapshot_id: float) -> void:
	var sceng = cfc.scripting_engine.new(
		[intent_script],
		get_parent().combat_entity,
		get_parent(),
		{})
	var adjusted_amount = sceng.predict_intent_amount(snapshot_id)
	if typeof(intent_script.get("amount")) != TYPE_INT:
		# If the amount is a string, we assume it's a per_ which usually returns positive integers
		# in case I need to return a negative one, I'll refactor this.
		if adjusted_amount < 0:
			adjusted_amount = 0
	else:
		if intent_script.get("amount",0) > 0 and adjusted_amount < 0:
			adjusted_amount = 0
		elif intent_script.get("amount",0) < 0 and adjusted_amount > 0:
			adjusted_amount = 0
	update_amount(adjusted_amount)
