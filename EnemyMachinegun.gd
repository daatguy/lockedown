extends "res://EnemyGeneric.gd"

export var shots_per_volley = 7
var shots_taken = 0
export var between_volley_shots = .2
export var between_volleys = 6

func shoot_pattern():
	if (shots_taken == shots_per_volley):
		shots_taken = 0
		seconds_per_shot = between_volleys
		return
	elif (shots_taken == 0):
		seconds_per_shot = between_volley_shots
	shoot_angle(500, angle_to_player(), 1500, 10)
	shots_taken += 1
