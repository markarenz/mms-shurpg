extends Enemy

const small_asteroid_scene: PackedScene = preload("res://SCENES/OBJECTS/asteroid_small.tscn")

func _ready() -> void:
	damage = 0.5

func hit(_spawn_children: bool) -> void:
	show_splash()
	queue_free()
