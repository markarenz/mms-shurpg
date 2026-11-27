class_name Player
extends CharacterBody2D

var splash_death_scene = preload("res://SCENES/FX/SPLASH_DEATH/splash_death.tscn")
var splash_scene = preload("res://SCENES/FX/SPLASH/splash.tscn")

@export_category("Stats")
@export var max_speed: float = 200.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0
@export var bullet_scene: PackedScene
@export var facing: int = 1
@export var is_hurt = false

@onready var playerGroup: Node2D = $PlayerGroup
@onready var engineSprite: AnimatedSprite2D = $PlayerGroup/EngineSprite
@onready var muzzle: Marker2D = $PlayerGroup/Muzzle
@onready var hurt: Area2D = $Hurt

var move_direction: Vector2 = Vector2.ZERO
var is_accelerating: bool = false

func _ready() -> void:
	z_index = GameConstants.Z_INDEX.PLAYER
	Globals.init_player()
	Globals.player_death.connect(_on_player_death)


func _physics_process(delta: float) -> void:
	movement_loop(delta)

func clear_movement() -> void:
	move_direction = Vector2.ZERO
	velocity = Vector2.ZERO

func movement_loop(delta: float) -> void:
	if not Globals.player_input_lock:
		if (Input.is_action_just_pressed("fire_main")):
			fire_main()
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

func fire_main():
	if not bullet_scene:
		return
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.z_index = GameConstants.Z_INDEX.BULLET
	bullet.global_transform = muzzle.global_transform

func _on_player_hurt_area_entered(area: Area2D) -> void:
	if not Globals.player_input_lock:
		var target = area.get_parent()
		if "damage" in target:
			Globals.player_health_change(-1 * target.damage)
		hurt.start_invincibility(0.5)

func _on_hurt_body_entered(_body: Node2D) -> void:
	if not Globals.player_input_lock:
		var splash = splash_scene.instantiate()
		get_tree().current_scene.add_child(splash)
		splash.global_transform = global_transform
		modulate.a = 0
		const damage = 0.5
		Globals.player_health_change(-1 * damage)
		hurt.start_invincibility(0.5)

func _on_player_hurt_invincibility_ended() -> void:
	if not Globals.player_input_lock:
		modulate.a = 1.0
	is_hurt = false

func _on_player_hurt_invincibility_started() -> void:
	if not Globals.player_input_lock:
		modulate.a = 0.5
	is_hurt = true

func _on_player_death():
	var splash = splash_death_scene.instantiate()
	get_tree().current_scene.add_child(splash)
	splash.global_transform = global_transform
	modulate.a = 0
