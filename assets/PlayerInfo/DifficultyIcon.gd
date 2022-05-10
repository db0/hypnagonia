extends TextureRect

onready var particles := $Particles2D

func _ready():
	particles.lifetime = 0.75 + (abs(globals.difficulty.total_difficulty) / 40)
	particles.amount = abs(globals.difficulty.total_difficulty) + 5
