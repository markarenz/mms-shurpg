extends Node2D

@export var is_paused = false

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("pause")):
		if (is_paused):
			is_paused = false
			visible = false
			get_tree().paused = false
		else:
			is_paused = true
			visible = true
			get_tree().paused = true
