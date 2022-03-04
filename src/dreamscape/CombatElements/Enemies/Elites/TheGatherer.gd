extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "The Gatherer",
	"Health": 200,
	"Type": "Absurdity",
	"Damage": 0,
	"_texture_size_x": 160,
	"_texture_size_y": 160,
	"_character_art": 'Nobody',
	"_is_ordered": true,
	"_health_variability": 7,
}


func _ready() -> void:
	cfc.NMAP.board.turn.connect("player_turn_started", self, "_check_dream_fragment")
#	cfc.NMAP.board.dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.disruption.name, 1, false, false, ["Init"])

func _check_dream_fragment(_turn: Turn) -> void:
	var found_dream_fragment := false
	for c in cfc.NMAP.hand.get_all_cards():
		if c.canonical_name == "Dream Fragment":
			found_dream_fragment = true
	if not found_dream_fragment:
		var spawn_fragment = [
			{
				"name": "spawn_card_to_container",
				"card_name": "Dream Fragment",
				"immediate_placement": true,
				"dest_container": "hand",
				"tags": [],
			}
		]
		execute_script(spawn_fragment)

# Executes a custom script defined in an effect
func execute_script(
		script := [],
		trigger_object: Node = self,
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	sceng = cfc.scripting_engine.new(
			script,
			self,
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
