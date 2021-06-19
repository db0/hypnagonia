class_name CombatEntity
extends VBoxContainer

onready var collision_shape := $Texture/Area2D/CollisionShape2D
onready var area2d := $Texture/Area2D
onready var entity_texture :=  $Texture
onready var health_label : Label = $HBC/Health
onready var name_label : Label = $Name
onready var armor_label : Label = $HBC/Armor

var health : int setget set_health
var max_health : int setget set_max_health
var armor : int setget set_armor
var canonical_name: String
var type: String
var entity_size : Vector2
var active_effects := []
# Holding all the details from the CombatEntity, in case
# we need to retrieve some extra ones, depending on the type
var _properties : Dictionary

# Typically used during
# an [execute_scripts()](ScriptingEngine#execute_scripts] task.
var temp_properties_modifiers := {}

func setup(entity_name: String, properties: Dictionary) -> void:
	canonical_name = entity_name
	name = entity_name
	health = properties['Health']
	max_health = properties['Max Health']
	type = properties['Type']
	_properties = properties
	entity_size = Vector2(properties['_texture_size_x'],properties['_texture_size_y'])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_texture.rect_min_size = entity_size
	collision_shape.shape.extents = entity_size / 2
	area2d.position = entity_size / 2
	name_label.text = canonical_name
	_update_health_label()

func set_armor(value) -> void:
	armor = value
	_update_health_label()

func set_health(value) -> void:
	health = value
	_update_health_label()

func set_max_health(value) -> void:
	max_health = value
	_update_health_label()

func take_damage(amount: int, dry_run := false, tags := ["Manual"]) -> int:
	if not dry_run:
		if armor > 0:
			if amount >= armor:
				amount -= armor
				armor = 0
			else:
				armor -= amount
				amount = 0
		health -= amount
		_update_health_label()
	return(CFConst.ReturnCode.CHANGED)

func receive_armor(amount: int, dry_run := false, tags := ["Manual"]) -> int:
	if not dry_run:
		armor += amount
		_update_health_label()
	return(CFConst.ReturnCode.CHANGED)
	
func get_class() -> String:
	return("CombatEntity")

func _update_health_label() -> void:
	health_label.text = str(health) + '/' + str(max_health)
	armor_label.text = '(' + str(armor) + ')'
