# hurt.gd
extends Area2D

@onready var timer = $Timer
@onready var collisionShape = $CollisionShape2D
var invincible = false

signal invincibility_started
signal invincibility_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_invincible(val):
	invincible = val
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(dur):
	set_invincible(true)
	timer.start(dur)
	
func _on_timer_timeout() -> void:
	set_invincible(false)

func _on_Hurtbox_invincibility_started() -> void:
	collisionShape.set_deferred("disabled", true)

func _on_Hurtbox_invincibility_ended() -> void:
	collisionShape.disabled = false
