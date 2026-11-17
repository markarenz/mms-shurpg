extends CharacterBody2D

@export_category("Stats")
@export var max_speed: float = 200.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0

@onready var playerGroup: Node2D = $PlayerGroup
@onready var engineSprite: AnimatedSprite2D = $PlayerGroup/EngineSprite

var move_direction: Vector2 = Vector2.ZERO
var is_accelerating: bool = false
var facing: int = 1

func _physics_process(delta: float) -> void:
	movement_loop(delta)

func movement_loop(delta: float) -> void:
	move_direction = Input.get_vector("left", "right", "up", "down")
	is_accelerating = move_direction != Vector2.ZERO
	if is_accelerating:
		velocity = velocity.move_toward(move_direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()

	if move_direction.x < 0:
		facing = -1
	elif move_direction.x > 0:
		facing = 1

	playerGroup.scale.x = facing

	if is_accelerating:
		engineSprite.visible = true
		engineSprite.play()
	else:
		engineSprite.visible = false
		engineSprite.stop()
		
