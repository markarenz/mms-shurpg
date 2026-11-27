extends StaticBody2D

var is_active = false

func process_health() -> void:
	Globals.player_health_change(0.5)

func run_process() -> void:
	if is_active:
		$AnimationPlayer.play('process')
		await $AnimationPlayer.animation_finished
		run_process()
	if Globals.stats.player.health >= Globals.stats.player.max_health:
		is_active = false

func _on_area_process_trigger_body_entered(_body: Node2D) -> void:
	is_active = true
	run_process()

func _on_area_process_trigger_body_exited(_body: Node2D) -> void:
	is_active = false
