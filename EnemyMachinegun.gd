extends "res://EnemyGeneric.gd"

export var shots_per_volley = 10
var shots_taken = shots_per_volley
export var between_volley_shots = .2
export var between_volleys = 4

func ready():
	pitchVariation = 0;

func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if (shots_taken == shots_per_volley):
		if(distance<sightRange):
			shots_taken = 0
			seconds_per_shot = between_volleys
			get_node("ShootSound").play();
		else:
			seconds_per_shot = 0.1;
		return
	elif (shots_taken == 0):
		seconds_per_shot = between_volley_shots
	shoot_angle(500, angle_to_player(), 1500, 10)
	shots_taken += 1
