extends Node2D

func _ready() -> void:
	Globals.area_change_triggered.connect(_on_area_change_triggered)

func _on_area_change_triggered() -> void:
	$AnimationPlayer.play('area_change_transition')

func area_change_transition_faded_out() -> void:
	Globals.area_change_transition_complete()
