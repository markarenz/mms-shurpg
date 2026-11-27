extends Node

# Ephemeral Vars
var player_input_lock = false
var camera_lock = false

# Vars that are saved/loaded
var stats = {
	"player": {
		"health": 4,
		"max_health": 4.0,
		"xp": 0,
		"area": 'area_0',
		"area_last": '',
		"flags": {},
		"inventory": {},
	},
}

signal camera_lock_changed()
signal area_change_triggered()
signal area_changed()
signal player_health_updated(new_health: float)
signal player_death()
signal xp_updated()

func set_camera_lock(val: bool) -> void:
	camera_lock = val
	camera_lock_changed.emit()

func add_xp(points: int) -> void:
	stats.player.xp += points
	xp_updated.emit()
	
func init_player():
	stats.player.health = stats.player.max_health
	player_health_change(0)

func player_health_change(value: float) -> void:
	if stats.player.health > 0:
		stats.player.health = clamp(stats.player.health + value, 0, stats.player.max_health)
		player_health_updated.emit(stats.player.health)
		if (stats.player.health <= 0):
			player_input_lock = true
			player_death.emit()

func change_area(next_area_id: String) -> void:
	stats.player.area_last = stats.player.area
	stats.player.area = next_area_id
	area_change_triggered.emit()

func area_change_transition_complete() -> void:
	area_changed.emit()

#func clearInputs() -> void:
	#for action in InputMap.get_actions():
		#Input.action_release(action)
