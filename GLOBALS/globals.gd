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
signal health_updated(new_health: float)
signal player_death()

func init_player():
	health = max_health

func player_health_change(value: int) -> void:
	if health > 0:
		health += value
		health_updated.emit(health)
		print(health)
		if (health <= 0):
			#get_tree().paused = true
			player_input_lock = true
			player_death.emit()
			print('You are dead, brother.')	


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
