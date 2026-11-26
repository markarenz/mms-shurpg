extends Area2D

@export var min_spawn = 2
@export var max_spawn = 6

@onready var collision_shape = $CollisionShape2D
@onready var tilemap_main: TileMapLayer = $"../TileMapLayerMain"

var asteroid_large_scene = preload("res://SCENES/OBJECTS/asteroid_large.tscn")
var asteroid_small_scene = preload("res://SCENES/OBJECTS/asteroid_small.tscn")

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var num_to_spawn = randi_range(min_spawn, max_spawn)
	var h = collision_shape.shape.size.y
	for i in range(num_to_spawn):
		var asteroid
		if (randf() < .25):
			asteroid = asteroid_small_scene.instantiate()
		else:
			asteroid = asteroid_large_scene.instantiate()
		get_parent().add_child.call_deferred(asteroid)
		asteroid.tilemap_main = tilemap_main
		asteroid.global_position = body.global_position
		asteroid.global_position.x += randf_range(600.0, 800.0) * body.facing
		asteroid.global_position.y = global_position.y + randf_range(-0.5 * h, 0.5 * h)
		asteroid.speed = randf_range(75.0, 150.0) * body.facing * -1
