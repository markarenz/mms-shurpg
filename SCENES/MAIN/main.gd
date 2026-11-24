extends Node2D

const SCENES: Dictionary[String, PackedScene] = {
	"area_0": preload("res://SCENES/AREAS/area_0.tscn")
}
var camera_scene = preload("res://SCENES/CAMERA/camera.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_area('area_0')

func load_area(area_id: String) -> void:
	var current_scene = get_tree().current_scene
	if current_scene and current_scene.has_node("Main/Area"):
		current_scene.get_node("Main/Area").queue_free()
	var area := SCENES[area_id].instantiate()
	add_child(area)
	var player_start_obj = area.get_node("PlayerStart")
	var player = get_node("Player")
	if player_start_obj:
		player.position = player_start_obj.position
	var camera = camera_scene.instantiate()
	add_child(camera)
	camera.offset = Vector2(0, 0)
	camera.position = Vector2(80, 120)
