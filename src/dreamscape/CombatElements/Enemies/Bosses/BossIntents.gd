class_name BossIntents
extends EnemyIntents

func get_outrage() -> int:
	var outrage : int = combat_entity.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.outrage.name)
	return(outrage)
