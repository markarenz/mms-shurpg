extends Camera2D

@export var target: Node2D
@export var tilemap: TileMapLayer
@export var smooth_speed: float = 5.0

var targetFacing = 0

func _physics_process(delta: float) -> void:
	if (targetFacing != target.facing):
		targetFacing = target.facing
		setXOffset()
	if target == null:
		return
	global_position = global_position.lerp(target.global_position, smooth_speed * delta)

func _ready() -> void:
	if tilemap == null:
		return
	var map_rect: Rect2i = tilemap.get_used_rect()
	var tile_size: int = tilemap.tile_set.tile_size.x
	# Convert tile coordinates to pixel limits
	limit_top = map_rect.position.y * tile_size
	limit_bottom = (map_rect.position.y + map_rect.size.y) * tile_size
	#limit_left = map_rect.position.x * tile_size
	#limit_right = (map_rect.position.x + map_rect.size.x) * tile_size

func setXOffset():
	var nextOffset = 80 if targetFacing > 0 else -80
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "offset:x", nextOffset, 1.0)
	
