extends CombatSignifier

var intent_script : Dictionary

func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	.setup(signifier_details, signifier_name)
	intent_script = signifier_details.duplicate(true)
	recalculate_amount()
# warning-ignore:return_value_discarded
	cfc.connect("cache_cleared", self, 'recalculate_amount')
	signifier_icon_container.visible = false

func recalculate_amount() -> void:
	var sceng = cfc.scripting_engine.new(
		[intent_script],
		get_parent().combat_entity,
		get_parent(),
		{})
	var adjusted_amount = sceng.predict_intent_amount()
	update_amount(adjusted_amount)
