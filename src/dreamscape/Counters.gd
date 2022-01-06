extends Counters

const COUNTER_DESCRIPTIONS := {
	"immersion": {
		"CounterTitle": "Immersion: ",
		"Description": "Immersion: Each card you play costs some. "\
				+ "You cannot play cards which cost more Immersion that you have available",
		"Value": 0},
	}

onready var _description_popup := $DescriptionPanel
onready var _description_label := $DescriptionPanel/Label

# * The `counters_container` has to point to the scene path, relative to your
#	counters scene, where each counter will be placed.
# * value_node specified the name of the label which holds
#	the value of the counter as displayed to the player
# * The needed_counters dictionary has one key per counter used in your game
#	Each value hold a dictionary with details about this counter.
#	* The key matching `value_node` will be used to set the starting
#		value of this counter
#	* All other keys specified have to match a label node name in the counter scene
#		and their value will be set as that label's text.
# * spawn_needed_counters() has to be called at the end, to actually
#	add the specified counters to your counters scene.
func _ready() -> void:
	counters_container = $VBC
	value_node = "Value"
	needed_counters = COUNTER_DESCRIPTIONS
	var all_counters = spawn_needed_counters()
	for counter in all_counters:
		counter.connect("mouse_entered", self, "_on_counter_enterred", [counter])
		counter.connect("mouse_exited", self, "_on_counter_exited")


# We need to extend this function so that we can capture counter increases
# as events
func mod_counter(counter_name: String,
		value: int,
		set_to_mod := false,
		check := false,
		requesting_object = null,
		tags := ["Manual"]) -> int:
	var retcode = .mod_counter(
			counter_name,
			value,
			set_to_mod,
			check,
			requesting_object,
			tags
	)
	if not check and retcode == CFConst.ReturnCode.CHANGED:
		# We store each immersion increase as an event, but not those happening
		# automatically at turn start
		if counter_name == "immersion" and value > 0:
			if not "New Turn" in tags:
				var total_immersion_gain := value
				if set_to_mod:
					total_immersion_gain = value - counters[counter_name]
				if total_immersion_gain > 1:
					var event_name = "immersion_increased"
					var turn_event_count = cfc.NMAP.board.turn.turn_event_count
					var existing_turn_count = turn_event_count.get(event_name,0)
					turn_event_count[event_name] = existing_turn_count + 1
					var encounter_event_count = cfc.NMAP.board.turn.encounter_event_count
					var existing_encounter_count = encounter_event_count.get(event_name,0)
					encounter_event_count[event_name] = existing_encounter_count + 1
					# We also accumulate all immersion gained throughout the game for 
					# filters
					var immersion_total_gained = encounter_event_count.get("total_immersion_gained",0)
					encounter_event_count["total_immersion_gained"] = immersion_total_gained + total_immersion_gain
			elif "Buffer" in tags:
				var event_name = "buffer_immersion_gained"
				var turn_event_count = cfc.NMAP.board.turn.turn_event_count
				var existing_turn_count = turn_event_count.get(event_name,0)
				turn_event_count[event_name] = existing_turn_count + 1
	return(retcode)

func _on_player_turn_ended(turn: Turn) -> void:
	# warning-ignore:return_value_discarded
	mod_counter("immersion", 0, true, false, turn, ["End Turn"])

func _on_player_turn_started(turn: Turn) -> void:
	# warning-ignore:return_value_discarded
	mod_counter("immersion", 3, false, false, turn, ["New Turn"])

func _on_counter_enterred(counter_node: Control) -> void:
	var description_text : String = needed_counters[counter_node.name]["Description"]
	if description_text:
		_description_label.text = description_text
		_description_popup.visible = true
		_description_popup.rect_size = Vector2(0,0)
		_description_popup.rect_global_position = counter_node.rect_global_position + Vector2(20,-50)

func _on_counter_exited() -> void:
	_description_popup.hide()
