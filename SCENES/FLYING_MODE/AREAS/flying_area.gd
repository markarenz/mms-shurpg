# flying_area.gd

class_name FlyingArea
extends Node2D

var player_scene = preload("res://SCENES/FLYING_MODE/PLAYER/player.tscn")
var camera_scene = preload("res://SCENES/FLYING_MODE/CAMERA/camera.tscn")

func _ready() -> void:
	var player := player_scene.instantiate()
	player.z_index = GameUtils.Z_INDEX.PLAYER
	add_child(player)

	var teleporter_chute_entry = get_node_or_null("TransporterChute_" + Globals.stats.player.area_last)
	if (teleporter_chute_entry):
		teleporter_chute_entry.handle_player_area_entry_teleport()
	else:
		var player_start_obj = get_node("PlayerStart")
		player.z_index = GameUtils.Z_INDEX.PLAYER
		if player_start_obj:
			player.position = player_start_obj.position
	var camera = camera_scene.instantiate()
	add_child(camera)
	camera.offset = Vector2(0, 0)
	camera.position = Vector2(80, 120)
