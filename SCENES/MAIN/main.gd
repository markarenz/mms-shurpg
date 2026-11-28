# main.gd

extends Node2D

const SCENES: Dictionary[String, PackedScene] = {
	"area_0": preload("res://SCENES/FLYING_MODE/AREAS/area_0.tscn"),
	"area_1": preload("res://SCENES/FLYING_MODE/AREAS/area_1.tscn"),
	"area_outpost_a": preload("res://SCENES/EVA_MODE/AREAS/area_outpost_a.tscn")
}

func _ready() -> void:
	Globals.area_changed.connect(_on_area_changed)
	load_area(Globals.stats.player.area)

func _on_area_changed() -> void:
	load_area(Globals.stats.player.area)

func load_area(area_id: String) -> void:
	var existing_area_scenes = get_tree().get_nodes_in_group("area")
	for area_to_remove in existing_area_scenes:
		area_to_remove.queue_free()

	var area := SCENES[area_id].instantiate()
	area.z_index = GameUtils.Z_INDEX.AREA
	get_tree().current_scene.add_child(area)
