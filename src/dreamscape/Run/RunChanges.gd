# This class is responsible for storing changes that happen throughout the run
# such as unlocked NCEs, used artifacts, loading legacy elements from disk etc.
class_name RunChanges
extends Reference

signal nce_unlocked(nce)

# NCEs which have been unlocked to appear during this run
var unlocked_nce := {
	"easy": {},
	"risky": {},
}
# The parent script which owns this reference
var encounters
# Stores which NCEs (Reference the player has already seen, to avoid replaying them
# technically only relevant for AllActs NCEs
var used_nce := []
# Generic place to store vars, so that events can store and retrieve info
# might change this into a class later if it becomes too convoluted.
var store := {}

func _init(_encounters) -> void:
	encounters = _encounters

# Unlocks an NCE to be found in later encounters
func unlock_nce(nce_name: String, nce_type: String, is_immediate := true) -> void:
	# We go through each act class we know, and look for the NCE name
	for act in [Act1, Act2, AllActs]:
		var act_name = act.get_act_name()
		if "LOCKED_NCE" in act:
			if act["LOCKED_NCE"].has(nce_name):
				if not unlocked_nce[nce_type].has(act_name):
					unlocked_nce[nce_type][act_name] = []
				var unl_nce = act["LOCKED_NCE"][nce_name]
				if typeof(unl_nce) == TYPE_STRING:
					unl_nce = load(unl_nce)
				if not _is_nce_unlocked(unl_nce.nce):
					unlocked_nce[nce_type][act_name].append(unl_nce)
					emit_signal("nce_unlocked", unl_nce)
					# After unlocking an NCE, we automatically inject it into
					# The still available NCEs
					# TODO: Later this will also coordinate the multiple acts
					if is_immediate:
						for _iter in range(unl_nce.chance_multiplier):
							encounters.remaining_nce[nce_type].append(unl_nce.nce)
							CFUtils.shuffle_array(encounters.remaining_nce[nce_type])
					# We should not have a locked NCE with the same key in multiple acts.
					break


# This is typically called when NCEs are being refreshed because their list is empty.
func get_unlocked_nces(act: String, nce_type: String) -> Array:
	var ret_nces := []
	for act_key in ["AllActs", act]:
		for unl_nce in unlocked_nce[nce_type].get(act_key, []):
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
	if not nce in used_nce and not nce in AllActs.REPEATING_NCE:
		used_nce.append(nce)


func _is_nce_unlocked(nce) -> bool:
	for nce_type in unlocked_nce.values():
		for unlnce_list in nce_type.values():
			for unl_nce in unlnce_list:
				if typeof(nce) == TYPE_STRING and unl_nce.nce == nce:
					return(true)
				if nce is GDScript and unl_nce.nce == nce.resource_path:
					return(true)
	return(false)

func extract_save_state() -> Dictionary:
	var run_dict := {
		"unlocked_nce": unlocked_nce,
		"used_nce": used_nce,
		"store" : store,
	}
	return(run_dict)
