# This class is responsible for storing changes that happen throughout the run
# such as unlocked NCEs, used artifacts, loading legacy elements from disk etc.
class_name RunChanges
extends Reference

# NCEs which have been unlocked to appear during this run
var unlocked_nce := {}
var encounters

func _init(_encounters) -> void:
	encounters = _encounters

# Unlocks an NCE to be found in later encounters
func unlock_nce(nce_name: String) -> void:
	# We go througheach act class we know, and look for the NCE name
	for act in [Act1, AllActs]:
		var act_name = act.get_act_name()
		if "LOCKED_NCE" in act:
			if act["LOCKED_NCE"].has(nce_name):
				if not unlocked_nce.has(act_name):
					unlocked_nce[act_name] = []
				var unl_nce = act["LOCKED_NCE"][nce_name]
				unlocked_nce[act_name].append(unl_nce)
				# After unlocking an NCE, we automatically inject it into
				# The still available NCEs
				# TODO: Later this will also coordinate the multiple acts
				for _iter in range(unl_nce.chance_multiplier):
					encounters.remaining_nce.append(unl_nce.nce)
					CFUtils.shuffle_array(encounters.remaining_nce)
				break


# This is typically called when NCEs are being refreshed because their list is empty.
func get_unlocked_nces(act: String) -> Array:
	var ret_nces := []
	for act_key in ["AllActs", act]:
		for unl_nce in unlocked_nce.get(act_key, []):
			for _iter in range(unl_nce.chance_multiplier):
				ret_nces.append(unl_nce.nce)
	return(ret_nces)
