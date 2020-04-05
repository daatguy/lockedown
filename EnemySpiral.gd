extends "res://EnemyGeneric.gd"

export var bullet_velocity = Vector2(300, 0)

func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if(distance<sightRange):
		shoot(bullet_velocity, 1200, 37)
		bullet_velocity = bullet_velocity.rotated(-PI-4)
		get_node("ShootSound").pitch_scale = pitch-pitchVariation/2+pitchVariation*randf();
		get_node("ShootSound").play();
