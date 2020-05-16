extends "res://EnemyGenericAnimated.gd"

func _ready():
	sightRange = 1600;
	moveSpeed = 400;
	movePause = 0.4;
	seconds_per_shot = 1.4;
	recoilAmount = 120;
	recoilDecay = 0.995;
	

func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if(distance<shootRange):
		var angle = angle_8_to_player()
		#shoot_angle(400, angle + .2, 800, 20)
		#shoot_angle(400, angle - .2, 800, 20)
		var bullet0 = shoot_angle(600, angle, 820, 1)
		#Perpendicular to bullet0's flight path
		var bulletOffset = Vector2(-bullet0.velocity.y, bullet0.velocity.x).normalized()*128;
		var bullet1 = shoot_angle(600, angle, 820, 1)
		bullet1.position += bulletOffset
		var bullet2 = shoot_angle(600, angle, 820, 1)
		bullet2.position -= bulletOffset
		get_node("ShootSound").pitch_scale = pitch-pitchVariation/2+pitchVariation*randf();
		get_node("ShootSound").play();
