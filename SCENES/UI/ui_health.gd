# ui_helth.gd

extends Node2D

var health_sprite_scene = preload("res://SCENES/UI/ui_health_sprite.tscn")

func _ready() -> void:
	Globals.player_health_updated.connect(_on_player_health_updated)
	handle_health_change(Globals.stats.player.health)

func _on_player_health_updated(new_health: float) -> void:
	handle_health_change(new_health)

func handle_health_change(new_health: float):
	var max_health = Globals.stats.player.max_health
	var num_health_sprites = ceil(max_health)

	for i in range(num_health_sprites):
		var sprite = get_tree().current_scene.find_child("UiHealthSprite_" + str(i), true, false)
		if sprite:
			var value = 0;
			var val1 = new_health > i
			var val2 = new_health >= i + 1
			if (val1 and val2):
				value = 1.0
			elif (val1 and not val2):
				value = 0.5
			sprite.set_sprite_frame_from_value(value)
