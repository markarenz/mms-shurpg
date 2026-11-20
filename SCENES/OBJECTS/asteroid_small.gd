extends Enemy

const small_asteroid_scene: PackedScene = preload("res://SCENES/OBJECTS/asteroid_small.tscn")

func hit():
	show_splash()
	queue_free()
