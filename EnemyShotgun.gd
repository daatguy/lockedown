extends "res://EnemyGeneric.gd"

func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if(distance<sightRange):
		var angle = angle_to_player()
		shoot_angle(400, angle + .2, 800, 20)
		shoot_angle(400, angle - .2, 800, 20)
		shoot_angle(400, angle, 800, 50)
		get_node("ShootSound").pitch_scale = pitch-pitchVariation/2+pitchVariation*randf();
		get_node("ShootSound").play();
