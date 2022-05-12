extends CenterContainer

var immersion := 3

onready var particles_left := $"ImmersionIcon/ParticlesLeft"
onready var particles_right := $"ImmersionIcon/ParticlesRight"

func _ready():
	set_rotation_speed(immersion)
	
func _process(delta):
	$ImmersionIcon.rect_rotation += delta * immersion

func set_rotation_speed(_immersion) -> void:
	immersion = _immersion
	var c: float
	match immersion:
		0: c = 0.6
		1: c = 0.72
		2: c = 0.85
		3: c = 1.0
		4: c = 1.20
		5: c = 1.35
		_: c = 1.40
	var new_color =  Color(c,c,c,c)
	$Tween.remove_all()
	$Tween.interpolate_property($ImmersionIcon, "self_modulate:a", $ImmersionIcon.self_modulate.a, c, 1,Tween.TRANS_SINE,Tween.EASE_OUT)
	$Tween.start()
#	$ImmersionIcon.modulate.a = c
	for p in [particles_left, particles_right]:
		if immersion == 0:
			p.emitting = false
		else:
			p.emitting = true
			var rot
			var amount = immersion * 5
			var lifetime = 0.7 + immersion * 0.1
			if lifetime > 1.5: 
				lifetime = 1.5
			p.amount = amount
			p.lifetime =lifetime
		
		
