extends "res://EnemyGeneric.gd"

func shoot_pattern():
	var angle = angle_to_player()
	shoot_angle(400, angle + .2, 800, 20)
	shoot_angle(400, angle - .2, 800, 20)
	shoot_angle(400, angle, 800, 50)
