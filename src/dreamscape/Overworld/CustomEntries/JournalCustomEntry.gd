class_name JournalCustomEntry
extends VBoxContainer

func _reveal_entry(
		rich_text_node: RichTextLabel,
		connect_rte_signals := false,
		extra_gui_input_args = null) -> void:
	globals.journal.pre_highlight_bbcode_texts[rich_text_node] = rich_text_node.bbcode_text
	rich_text_node.show()
	if connect_rte_signals:
		# warning-ignore:return_value_discarded
		rich_text_node.connect("mouse_entered", globals.journal, "_on_rte_mouse_entered", [rich_text_node] )
		# warning-ignore:return_value_discarded
		rich_text_node.connect("mouse_exited", globals.journal, "_on_rte_mouse_exited", [rich_text_node] )
		# warning-ignore:return_value_discarded
		rich_text_node.connect("gui_input", self, "_on_rte_gui_input", [rich_text_node, extra_gui_input_args] )
	globals.journal._tween.interpolate_property(rich_text_node,
			'modulate:a', 0, 1, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	globals.journal._tween.start()


func _on_rte_gui_input(event, rt_label: RichTextLabel, type = 'card_draft') -> void:
	if event.is_pressed() and event.get_button_index() == 1:
		_disconnect_gui_inputs(rt_label)
		globals.journal.grey_out_label(rt_label)
		_execute_custom_entry()

# Overridable function for custom code
func _execute_custom_entry() -> void:
	pass


func _disconnect_gui_inputs(rich_text_node: RichTextLabel) -> void:
	# warning-ignore:return_value_discarded
	rich_text_node.disconnect("mouse_entered", globals.journal, "_on_rte_mouse_entered")
	# warning-ignore:return_value_discarded
	rich_text_node.disconnect("mouse_exited", globals.journal, "_on_rte_mouse_exited")
	# warning-ignore:return_value_discarded
	rich_text_node.disconnect("gui_input", self, "_on_rte_gui_input")
