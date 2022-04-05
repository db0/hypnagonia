extends CenterContainer

onready var back_button = $"PC/VBC/Back"
onready var _total_difficulty := $"PC/VBC/TotalDifficulty"
onready var desc_popup := $"Descriptions"
onready var desc_label := $"Descriptions/Description"
onready var difficulty_options_container := $"PC/VBC"

func _ready() -> void:
	_total_difficulty.text = "Difficulty: " + str(globals.difficulty.total_difficulty)
	for cnode in difficulty_options_container.get_children():
		if cnode is DifficultyOption:
			cnode.connect("mouse_entered", self, "_on_difficulty_mouse_entered", [cnode])
			cnode.connect("mouse_exited", self, "_on_difficulty_mouse_exited")
	# warning-ignore:return_value_discarded
	globals.difficulty.connect("total_difficulty_recalculated", self, "_on_total_difficulty_changed")

func _process(_delta: float) -> void:
	if desc_popup.visible:
		desc_popup.rect_global_position =\
			get_local_mouse_position() + Vector2(-desc_popup.rect_size.x / 2, -desc_popup.rect_size.y - 10)

func _on_CheckBox_toggled(value: bool, difficulty_key: String) -> void:
	globals.difficulty[difficulty_key] = value

func _on_total_difficulty_changed(total_difficulty) -> void:
	_total_difficulty.text = "Difficulty: " + str(total_difficulty)

func _on_difficulty_mouse_entered(cnode: Node) -> void:
	if not globals.difficulty.DESCRIPTIONS.has(cnode.difficulty_key):
		return
	desc_label.text = globals.difficulty.DESCRIPTIONS[cnode.difficulty_key]
	desc_popup.visible = true
	desc_popup.rect_size = Vector2(0,0)

func _on_difficulty_mouse_exited() -> void:
	desc_popup.visible = false
