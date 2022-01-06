extends Artifact


func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.OVERWORLD:
		globals.player.deck.connect("card_added", self, "_on_card_added")
#	else:
#		# We need to call it manually the first turn, because the signal will have fired
#		# before this is mapped
#		if not cfc.are_all_nodes_mapped:
#			yield(cfc, "all_nodes_mapped")
#		_on_player_turn_started(cfc.NMAP.board.turn)
	signifier_icon.modulate = Color(HConst.COLOR2_CODES[artifact_object.modifiers.colour])


# Every time a card of the chosen type is added, it's immediately removed.
# TODO: Add a visual signifier the card is eaten by the doll.
func _on_card_added(card_entry: CardEntry)  -> void:
	if card_entry.get_property("Type") == HConst.COLOUR_MAP2[artifact_object.modifiers.colour]:
		var progress = artifact_object.modifiers.get("progress", 0)
		if progress < _get_threshold():
			globals.player.deck.remove_card(card_entry)
			artifact_object.modifiers["progress"] = progress + 1
			if artifact_object.modifiers["progress"] >= _get_threshold():
				globals.player.deck.disconnect("card_added", self, "_on_card_added")
				artifact_object.context = ArtifactDefinitions.EffectContext.BATTLE
				artifact_object.definition["description"] =\
					"{colour} {artifact_name} ({progress}): At the start of the turn:\n"\
						+ "If you have 2 or 3 {card_type} cards, draw 1 card and gain 1 {immersion}.\n"\
						+ "If you have 4 or more {card_type} cards. draw 2 cards and gain 1 {immersion}."


func _add_extra_description_format(format_dict) -> void:
	var extra_fmt := get_extra_description_format()
	for key in extra_fmt:
		format_dict[key] = extra_fmt[key]

func get_extra_description_format() -> Dictionary:
	var format_dict := {}
	format_dict["card_type"] = "{%s}" % [HConst.COLOUR_MAP2[artifact_object.modifiers.colour].to_lower()]
	format_dict["colour"] = artifact_object.modifiers.colour
	format_dict["threshold"] = str(_get_threshold())
	var progress = artifact_object.modifiers.get("progress", 0)
	if progress == 10:
		format_dict["progress"] = "Completed"
	else:
		format_dict["progress"] = str(progress) + "/" + str(_get_threshold())
	return(format_dict)

	

func _get_threshold() -> int:
	match HConst.COLOUR_MAP2[artifact_object.modifiers.colour]:
		"Perturbation":
			return(3)
		"Concentration":
			return(6)
		_:
			return(10)


func _on_player_turn_started(_turn: Turn) -> void:
	var counter = 0
	for c in cfc.NMAP.hand.get_all_cards():
		if c.get_property("Type") == HConst.COLOUR_MAP2[artifact_object.modifiers.colour]:
			counter += 1
	if counter >= 2:
		var blessing = 1
		if counter >= 4:
			blessing = 2
		var script = [
			{
				"name": "mod_counter",
				"counter_name": "immersion",
				"modification": 1,
				"tags": ["Curio"],
			},
			{
				"name": "draw_cards",
				"card_count": blessing
			},
		]
		execute_script(script)
