extends CenterContainer

var type : String = "ordeal"
var current_index: int
var popup_node : Popup

var tutorials := {
	"ordeal": [
		preload("res://src/dreamscape/Tutorials/OrdealHelpPage1.tscn"),
		preload("res://src/dreamscape/Tutorials/OrdealHelpPage2.tscn"),
	]
}

onready var _page_container = $PC/VBC/HBC/PageContainer
onready var _next = $PC/VBC/HBC/RightButtons/Next
onready var _previous = $PC/VBC/HBC/LeftButtons/Previous
onready var _title = $PC/VBC/HBC2/Title

func _ready() -> void:
	_title.add_font_override("font", theme.get_font("TutorialHeader", "Label"))
	

func setup(tutorial_type: String, _popup_node: Popup) -> void:
	popup_node = _popup_node	
	current_index = 0
	type = tutorial_type
	var page = tutorials[type][current_index].instance()
	_add_page(page)
	if tutorials[type].size() == 1:
		_next.visible = false


func _on_Previous_pressed() -> void:
	_clear_page()
	_next.visible = true
	current_index -= 1
	var page = tutorials[type][current_index].instance()
	_add_page(page)
	if current_index == 0:
		_previous.visible = false


func _on_Next_pressed() -> void:
	_clear_page()
	_previous.visible = true
	current_index += 1
	var page = tutorials[type][current_index].instance()
	_add_page(page)
	if tutorials[type].size() == current_index + 1:
		_next.visible = false


func _on_Exit_pressed() -> void:
	popup_node.hide()
	_clear_page()
	cfc.game_paused = false


func _clear_page() -> void:
	for h in _page_container.get_children():
		h.queue_free()

func _add_page(page_node: Control) -> void:
	_page_container.add_child(page_node)
	_title.text = page_node.get_node("Title").text
