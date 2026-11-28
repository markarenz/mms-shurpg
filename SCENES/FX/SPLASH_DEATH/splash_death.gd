# splash_death.gd

extends Node2D

@onready var particles_1 = $CPUParticles2D

func _ready() -> void:
	particles_1.emitting = true

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
