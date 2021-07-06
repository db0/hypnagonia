class_name EnemyEntity
extends CombatEntity

signal finished_activation(enemy)

onready var intents: EnemyIntents = $Intents

func _process(delta: float) -> void:
	if is_dead:
		for node in [incoming]:
			if node.visible:
				node.visible = false



func _ready() -> void:
	entity_type = "torment"
	intents.combat_entity = self
	if _properties.has('Intents'):
		intents.all_intents = _properties.Intents.duplicate(true)
	if _properties.has('_art_scene'):
		var art_scene = load(_properties.get('_art_scene')).instance()
		art.add_child(art_scene)
		art_scene.scale = Vector2(0.24,0.24)
		art_scene.position =+ art.rect_size + Vector2(0,55)
		entity_texture.visible = false
	intents.prepare_intents()


func setup(entity_name: String, properties: Dictionary) -> void:
	.setup(entity_name,properties)
	health += CFUtils.randi_range(-properties['_health_variability'], properties['_health_variability'])
		
	
func activate() -> void:
	# Just in case the end-turn button is pressed too fast
	if is_dead: 
		emit_signal("finished_activation", self)
		return
	var sceng = intents.execute_scripts()
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	yield(get_tree().create_timer(0.1), "timeout")
#	print_debug("Activated: " + canonical_name)
	emit_signal("finished_activation", self)
	intents.prepare_intents()
