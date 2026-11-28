extends Camera2D

@export var smooth_speed: float = 5.0
@export var shake = Vector2.ZERO

@onready var tilemap: TileMapLayer = $"../TileMapLayerMain"
@onready var target: Node2D = $"../Player"
@onready var anim_player: AnimationPlayer = $AnimationPlayer

var camera_lock = false
var camera_snap_position = false

var targetFacing = 0
var is_shaking = false

func _ready() -> void:
	if tilemap == null:
		return
	var map_rect: Rect2i = tilemap.get_used_rect()
	var tile_size: int = tilemap.tile_set.tile_size.x
	limit_top = map_rect.position.y * tile_size
	limit_bottom = (map_rect.position.y + map_rect.size.y) * tile_size
	Globals.camera_lock_changed.connect(_on_camera_lock_changed)

func _physics_process(delta: float) -> void:
	if target and camera_lock == false:
		var facing = Globals.stats.player.facing
		if !is_shaking and target.is_hurt:
			start_shake()
		if (targetFacing != facing):
			targetFacing = facing
			setXOffset()
		if target == null:
			return
		if (camera_snap_position == true):
			global_position = target.global_position
			camera_snap_position = false
		else:
			global_position = global_position.lerp(target.global_position + shake * 10, smooth_speed * delta)

func _on_camera_lock_changed() -> void:
	camera_lock = Globals.camera_lock
	camera_snap_position = true

func setXOffset():
	var nextOffset = 160 if targetFacing > 0 else -160
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "offset:x", nextOffset, 1.0)

func start_shake():
	is_shaking = true
	anim_player.play('shake')

func shake_anim_ended():
	is_shaking = false
