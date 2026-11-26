extends Area2D

@export var next_area_id = ''
@onready var player = $"../../Player"
#@onready var timer = $Timer

var disable_collision_check = false

func _on_body_entered(body: Node2D) -> void:
	if (disable_collision_check == false):
		body.clear_movement()
		Globals.set_camera_lock(true)
		get_tree().paused = true
		var next_x = player.global_position.x + 426 * player.facing
		var tween := create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(player, "global_position:x", next_x, 1.0)
		await tween.finished
		Globals.change_area(next_area_id)

func handle_player_area_entry_teleport() -> void:
	#timer.start(0.1)
	Globals.set_camera_lock(false)
	disable_collision_check = true
	player.global_position = global_position
	player.global_position.x = global_position.x - 128 * player.facing
	# WAIT
	await get_tree().process_frame
	var next_x = global_position.x + 64 * player.facing
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(player, "global_position:x", next_x, 1.0)
	await tween.finished
	disable_collision_check = false
	get_tree().paused = false

#func _on_timer_timeout() -> void:
	#var next_x = global_position.x + 64 * player.facing
	#var tween := create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_QUINT)
	#tween.tween_property(player, "global_position:x", next_x, 0.5)
	#await tween.finished
	#disable_collision_check = false
	#get_tree().paused = false
