# asteroid.gd
class_name Enemy
extends Node2D

@export var damage: float = 1.0
@export var speed: float = -100.0
@export var rot_speed: float = 1
@export var tilemap_main: TileMapLayer

@onready var sprite: Sprite2D = $Sprite2D
@onready var hurt: Area2D = $Hurt
var splash_scene = preload("res://SCENES/FX/SPLASH/splash.tscn")
var invincible: bool = false

func initialize() -> void:
	if hurt:
		hurt.start_invincibility(0.5)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	sprite.rotation += rot_speed * delta
	unload_if_outside_tilemap()

func _on_hurt_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not Globals.player_input_lock:
		var area_groups = area.get_groups()
		if (area_groups.has("player_bullet")):
			hit(true)

func _on_hurt_body_entered(body: Node2D) -> void:
	if GameUtils.is_player(body) and not Globals.player_input_lock:
		hit(false)

func show_splash():
	var splash = splash_scene.instantiate()
	get_tree().current_scene.add_child(splash)
	splash.global_transform = global_transform

func hit(_spawn_children: bool) -> void:
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
