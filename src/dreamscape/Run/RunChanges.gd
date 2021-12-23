# This class is responsible for storing changes that happen throughout the run
# such as unlocked NCEs, used artifacts, loading legacy elements from disk etc.
class_name RunChanges
extends Reference

# NCEs which have been unlocked to appear during this run
var unlocked_nce := {}
# The parent script which owns this reference
var encounters
# Stores which NCEs (Reference the player has already seen, to avoid replaying them
# technically only relevant for AllActs NCEs
var used_nce := []

func _init(_encounters) -> void:
	encounters = _encounters

# Unlocks an NCE to be found in later encounters
func unlock_nce(nce_name: String) -> void:
	print_debug(unlocked_nce)
	# We go through each act class we know, and look for the NCE name
	for act in [Act1, Act2, AllActs]:
		var act_name = act.get_act_name()
		if "LOCKED_NCE" in act:
			if act["LOCKED_NCE"].has(nce_name):
				if not unlocked_nce.has(act_name):
					unlocked_nce[act_name] = []
				var unl_nce = act["LOCKED_NCE"][nce_name]
				if not _is_nce_unlocked(unl_nce.nce):
					unlocked_nce[act_name].append(unl_nce)
					# After unlocking an NCE, we automatically inject it into
					# The still available NCEs
					# TODO: Later this will also coordinate the multiple acts
					for _iter in range(unl_nce.chance_multiplier):
						encounters.remaining_nce.append(unl_nce.nce)
						CFUtils.shuffle_array(encounters.remaining_nce)
					break
	print_debug(unlocked_nce)


# This is typically called when NCEs are being refreshed because their list is empty.
func get_unlocked_nces(act: String) -> Array:
	var ret_nces := []
	for act_key in ["AllActs", act]:
		for unl_nce in unlocked_nce.get(act_key, []):
			for _iter in range(unl_nce.chance_multiplier):
				ret_nces.append(unl_nce.nce)
	return(ret_nces)


# Returns true is a NCE has been used during this run
# Else returns false
func is_nce_used(nce: GDScript) -> bool:
	if nce in used_nce:
		return(true)
	return(false)


# Marks an NCE as used during this run
func record_nce_used(nce: GDScript) -> void:
	if not nce in used_nce:
		used_nce.append(nce)


func _is_nce_unlocked(nce: GDScript) -> bool:
	for unlnce_list in unlocked_nce.values():
		for unl_nce in unlnce_list:
			if unl_nce.nce == nce:
				return(true)
	return(false)
