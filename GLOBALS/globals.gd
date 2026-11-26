extends Node

var player_input_lock = false
var camera_lock = false
var player_area = 'area_0'
var player_area_last = ''
var score: int = 0
var max_health = 4.0
var health = 4.0
var xp = 0

signal score_updated(new_score: int)
signal camera_lock_changed()
signal area_change_triggered()
signal area_changed()
signal player_health_updated(new_health: float)
signal player_death()
signal xp_updated()

func set_camera_lock(val: bool) -> void:
	camera_lock = val
	camera_lock_changed.emit()

func add_score(points: int) -> void:
	score += points
	score_updated.emit(score)

func add_xp(points: int) -> void:
	xp += points
	xp_updated.emit()
	
func init_player():
	health = max_health
	player_health_change(0)

func player_health_change(value: float) -> void:
	if health > 0:
		health = clamp(health + value, 0, max_health)
		player_health_updated.emit(health)
		if (health <= 0):
			player_input_lock = true
			player_death.emit()

func change_area(next_area_id: String) -> void:
	player_area_last = player_area
	player_area = next_area_id
	area_change_triggered.emit()

func area_change_transition_complete() -> void:
	area_changed.emit()

#func clearInputs() -> void:
	#for action in InputMap.get_actions():
		#Input.action_release(action)

#class saved_game
# score
# player health
# max player health
# experience
# level - attack
# money
# current scene (location)
# inventory
# flags
# ship upgrades?
