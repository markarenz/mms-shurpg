extends Node2D

const SCENES: Dictionary[String, PackedScene] = {
	"area_0": preload("res://SCENES/AREAS/area_0.tscn"),
	"area_1": preload("res://SCENES/AREAS/area_1.tscn")
}
var camera_scene = preload("res://SCENES/CAMERA/camera.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.area_changed.connect(_on_area_changed)
	load_area(Globals.player_area)

func _on_area_changed() -> void:
	# get_tree().paused = false
	load_area(Globals.player_area)

func load_area(area_id: String) -> void:
	var existing_area_scenes = get_tree().get_nodes_in_group("area")
	for area_to_remove in existing_area_scenes:
		area_to_remove.queue_free()

	var area := SCENES[area_id].instantiate()
	area.z_index = 1
	get_tree().current_scene.add_child(area)

	var teleporter_chute_entry = area.get_node("TransporterChute_" + Globals.player_area_last)
	if (teleporter_chute_entry):
		teleporter_chute_entry.handle_player_area_entry_teleport()
	else:
		var player_start_obj = area.get_node("PlayerStart")
		var player = get_node("Player")
		if player_start_obj:
			player.position = player_start_obj.position


	var camera = camera_scene.instantiate()
	add_child(camera)
	camera.offset = Vector2(0, 0)
	camera.position = Vector2(80, 120)
