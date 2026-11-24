extends Node

var player_input_lock = false

var score: int = 0
signal score_updated(new_score: int)

func add_score(points: int) -> void:
	score += points
	score_updated.emit(score)

#--- HEALTH
var max_health = 4.0
var health = 4.0
signal player_health_updated(new_health: float)
signal player_death()

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
