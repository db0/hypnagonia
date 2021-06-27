class_name CombatEntity
extends VBoxContainer

const INCOMING_SIGNIFIER_SCENE = preload("res://src/dreamscape/CombatElements/IncomingSignifier.tscn")

signal effect_modified(entity,trigger,details)
signal entity_killed


onready var collision_shape := $Texture/Area2D/CollisionShape2D
onready var area2d := $Texture/Area2D
onready var entity_texture :=  $Texture
onready var health_label : Label = $HBC/Health
onready var name_label : Label = $Name
onready var defence_label : Label = $HBC/Defence
onready var active_effects := $ActiveEffects
onready var incoming := $CenterContainer/Incoming

var damage : int setget set_damage
var health : int setget set_health
var defence : int setget set_armor
var canonical_name: String
var type: String
var entity_type: String
var entity_size : Vector2

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
	type = properties['Type']
	damage = properties.get('Damage', 0)
	_properties = properties
	entity_size = Vector2(properties['_texture_size_x'],properties['_texture_size_y'])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entity_texture.rect_min_size = entity_size
	collision_shape.shape.extents = entity_size / 2
	area2d.position = entity_size / 2
	name_label.text = canonical_name
	_update_health_label()
	active_effects.combat_entity = self


func set_armor(value) -> void:
	defence = value
	_update_health_label()

func set_damage(value) -> void:
	damage = value
	if damage >= health:
		die()
	else:
		_update_health_label()

func set_health(value) -> void:
	modify_health(value)

func die() -> void:
	emit_signal("entity_killed")
	queue_free()

func modify_health(amount: int, dry_run := false, tags := ["Manual"]) -> int:
	if not dry_run:
		if defence > 0 and "Damage" in tags:
			if amount >= defence:
				amount -= defence
				defence = 0
			else:
				defence -= amount
				amount = 0
		damage += amount
		if damage < 0:
			damage = 0
		if damage >= health:
			die()
		_update_health_label()
	return(CFConst.ReturnCode.CHANGED)

func receive_defence(amount: int, dry_run := false, tags := ["Manual"]) -> int:
	if not dry_run:
		defence += amount
		_update_health_label()
	return(CFConst.ReturnCode.CHANGED)
	
func get_class() -> String:
	return("CombatEntity")

func show_predictions(value: int) -> void:
	var incoming_node = INCOMING_SIGNIFIER_SCENE.instance()
	incoming.add_child(incoming_node)
	incoming_node.get_node("Label").text = str(value)

func clear_predictions() -> void:
	for node in incoming.get_children():
		node.queue_free()

# The entities do not have starting health which decreases as they take damage
# Rather they have a damage meter which increases until it hits their max health.
func _update_health_label() -> void:
	health_label.text = str(damage) + '/' + str(health)
	defence_label.text = '(' + str(defence) + ')'
