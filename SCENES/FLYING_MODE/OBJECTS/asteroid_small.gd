# asteroid_small.gd
extends Enemy

const small_asteroid_scene: PackedScene = preload("res://SCENES/FLYING_MODE/OBJECTS/asteroid_small.tscn")
const xp_value = 1

func _ready() -> void:
	damage = 0.5

func hit(_spawn_children: bool) -> void:
	show_splash()
	Globals.add_xp(xp_value)
	queue_free()
