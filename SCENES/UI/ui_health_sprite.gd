# ui_helth_sprite.gd

extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

func set_sprite_frame_from_value(value: float) -> void:
	if (value == 1.0):
		sprite.frame = 1 # full
	elif (value == 0.5):
		sprite.frame = 2 # half
	else:
		sprite.frame = 3 # empty
