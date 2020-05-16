extends "res://EnemyGeneric.gd"

export var bullet_velocity = Vector2(300, 0)
var height = 32;

func _ready():
	moveSpeed = 0;
	shootRange = 1200;
	z_offset = 99+height;
	recoilAmount = 0;
	
func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if(distance<shootRange):
		var bullet = shoot(bullet_velocity, 1200, 1)
		bullet.z_offset += height;
		bullet_velocity = bullet_velocity.rotated(-PI/4)
		get_node("ShootSound").pitch_scale = pitch-pitchVariation/2+pitchVariation*randf();
		get_node("ShootSound").play();
