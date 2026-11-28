extends Area2D

@export var next_area_id = ''
@onready var animation_player = $AnimationPlayer

var disable_collision_check = false

func _on_body_entered(body: Node2D) -> void:
	if (GameUtils.is_player(body) and disable_collision_check == false):
		var player = $"../Player"
		var facing = Globals.stats.player.facing
		print('is player? ', player)
		player.clear_movement()
		Globals.set_camera_lock(true)
		get_tree().paused = true
		animation_player.play("active")
		var next_x = player.global_position.x + 426 * facing
		var tween := create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(player, "global_position:x", next_x, 1.0)
		await tween.finished
		Globals.change_area(next_area_id)

func handle_player_area_entry_teleport() -> void:
	Globals.set_camera_lock(false)
	disable_collision_check = true
	var player = $"../Player"
	var facing = Globals.stats.player.facing
	player.global_position = global_position
	player.global_position.x = global_position.x - 128 * facing
	# WAIT
	await get_tree().process_frame
	var next_x = global_position.x + 64 * facing
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(player, "global_position:x", next_x, 1.0)
	await tween.finished
	disable_collision_check = false
	get_tree().paused = false

func _on_waker_body_entered(body: Node2D) -> void:
	if (GameUtils.is_player(body)):
		animation_player.play('idle')

func _on_waker_body_exited(body: Node2D) -> void:
	if (GameUtils.is_player(body)):
		animation_player.play('init')
