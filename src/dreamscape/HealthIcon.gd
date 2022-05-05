extends HBoxContainer

const NO_ANXIETY = Color(0,1,0)
const MAX_ANXIETY = Color(1,0,0)

onready var _label := $Label
onready var _icon := $Texture
onready var _anim := $AnimationPlayer

func _ready():
	# warning-ignore:return_value_discarded
	globals.player.connect("health_changed", self, "_update_health_label")
	_update_health_label()
	_anim.play("Beating")


func connect_dreamer_signals(dreamer: PlayerEntity) -> void:
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_damaged", self, "_on_player_health_changed")
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_healed", self, "_on_player_health_changed")
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_health_modified", self, "_on_player_health_changed")


func _on_player_health_changed(entity, _amount, _trigger, _tags) -> void:
	_update_health_label(entity.damage, entity.health)


func _update_health_label(current := globals.player.damage, total := globals.player.health) -> void:
	_label.text = str(current) + '/' + str(total)
	_adjust_icon_by_anxiety(float(current) / float(total))


func _adjust_icon_by_anxiety(current_pct: float) -> void:
	var modulate_color := NO_ANXIETY
	_icon.self_modulate = modulate_color.linear_interpolate(MAX_ANXIETY,current_pct)
	_anim.playback_speed = 1 + (1.8 - 1) * current_pct

