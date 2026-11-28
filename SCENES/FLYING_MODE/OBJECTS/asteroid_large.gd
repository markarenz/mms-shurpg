extends Enemy

const small_asteroid_scene: PackedScene = preload("res://SCENES/FLYING_MODE/OBJECTS/asteroid_small.tscn")
const xp_value = 5

func _ready() -> void:
	damage = 1.0

func hit(spawn_children: bool) -> void:
	show_splash()
	Globals.add_xp(xp_value)
	if spawn_children:
		var num_to_spawn = randi_range(1, 2)
		var y_gap = 0
		if num_to_spawn > 0:
			y_gap = randf_range(10.0, 20.0)
		for i in range(num_to_spawn):
			var small_asteroid = small_asteroid_scene.instantiate()
			small_asteroid.speed = speed - randf_range(10.0, 50.0)
			small_asteroid.rot_speed = rot_speed
			get_parent().add_child.call_deferred(small_asteroid)
			small_asteroid.global_transform = global_transform
			small_asteroid.global_position.y += y_gap / 2 - (i % 2) * y_gap
			small_asteroid.initialize()
			small_asteroid.tilemap_main = tilemap_main
	queue_free()
