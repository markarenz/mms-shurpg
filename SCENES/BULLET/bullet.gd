# bullet.gd
class_name Bullet
extends Area2D

@export var speed: float = 800.0
var splash_scene = preload("res://SCENES/FX/SPLASH/splash.tscn")

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	hit()

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	hit()

func hit():
	var splash = splash_scene.instantiate()
	get_tree().current_scene.add_child(splash)
	splash.global_transform = global_transform
	queue_free()
	
