# asteroid.gd
class_name Enemy
extends Node2D

@export var speed: float = -100.0
@export var rot_speed: float = 1
@export var tilemap_main: TileMapLayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hurt: Area2D = $Hurt
var splash_scene = preload("res://SCENES/FX/SPLASH/splash.tscn")
var invincible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialize() -> void:
	if hurt:
		hurt.start_invincibility(0.5)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	sprite.rotation += rot_speed * delta
	unload_if_outside_tilemap()

func _on_hurt_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	var area_groups = area.get_groups()
	if (area_groups.has("player_bullet")):
		hit()

func _on_hurt_body_entered(_body: Node2D) -> void:
	hit()

func show_splash():
	var splash = splash_scene.instantiate()
	get_tree().current_scene.add_child(splash)
	splash.global_transform = global_transform

func hit():
	pass

func _on_hurt_invincibility_ended() -> void:
	invincible = false;

func _on_hurt_invincibility_started() -> void:
	invincible = true;

func unload_if_outside_tilemap():
	if not tilemap_main:
		return
	var local_pos: Vector2 = tilemap_main.to_local(global_position)
	var cell_coords: Vector2i = tilemap_main.local_to_map(local_pos)
	var used_rect: Rect2i = tilemap_main.get_used_rect()
	var is_in_tilemap = used_rect.has_point(cell_coords)
	if not is_in_tilemap:
		queue_free()
