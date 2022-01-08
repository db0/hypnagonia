class_name ArtifactPreviewPopup
extends PopupPanel

var artifact_name: String
var artifact_definition : Dictionary
onready var _icon := $HBC/CC/Icon
onready var _decription_label := $HBC/CC2/ArtifactDescription
onready var _hbc := $HBC

func _process(_delta: float) -> void:
	if visible:
		rect_position = get_preview_placement()

func setup(_artifact_name: String) -> void:
	var artifact_format
	if _artifact_name in MemoryDefinitions:
		artifact_definition = MemoryDefinitions[_artifact_name].duplicate(true)
		var upgrades := 0
		var existing_memory = globals.player.find_memory(_artifact_name)
		if existing_memory:
			upgrades = existing_memory.upgrades_amount
		artifact_format = MemoryDefinitions.get_memory_bbcode_format(artifact_definition,upgrades)
	else:
		artifact_definition = ArtifactDefinitions[_artifact_name].duplicate(true)
		artifact_format = ArtifactDefinitions.get_artifact_bbcode_format(artifact_definition)
	artifact_name = artifact_definition["name"]
	_icon.texture = CFUtils.convert_texture_to_image(artifact_definition["icon"])
	var artifact_description = artifact_definition["description"]
	_decription_label.bbcode_text = artifact_description.\
			format(Terms.COMMON_FORMATS[Terms.PLAYER]).\
			format(Terms.get_bbcode_formats(18)).\
			format(artifact_format)


func get_preview_placement() -> Vector2:
	var ret := Vector2(0,0)
	var popup_size = _hbc.rect_size
	if get_global_mouse_position().x\
			+ popup_size.x\
			+ 20\
			> get_viewport().size.x:
		ret.x = get_global_mouse_position().x - popup_size.x - 20
	else:
		ret.x = get_global_mouse_position().x + 20
	var popup_offscreen_y = get_global_mouse_position().y + popup_size.y
	if popup_offscreen_y > get_viewport().size.y:
		ret.y = get_viewport().size.y - popup_size.y
	else:
		ret.y = get_global_mouse_position().y
#	print_debug(ret)
	return(ret)


func show_preview_artifact() -> void:
	rect_position = get_preview_placement()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = true


func hide_preview_artifact()  -> void:
	hide()
