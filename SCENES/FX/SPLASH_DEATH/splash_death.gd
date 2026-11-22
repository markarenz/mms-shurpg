extends Node2D


func _ready() -> void:
	var particles_1 = $CPUParticles2D
	var particles_2 = $CPUParticles2D2
	particles_1.emitting = true
	particles_2.emitting = true

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
