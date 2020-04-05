extends RigidBody2D
var time = 0
export (PackedScene) var Bullet = preload("res://BaseBullet.tscn")
export var seconds_per_shot = 1

func _process(delta):
	time += delta
	if time > seconds_per_shot:
		time = fmod(time, seconds_per_shot)
		shoot_pattern()
		
func shoot_pattern():
	shoot_angle(300, angle_to_player(), 1200)

func shoot(v, reach):
	var bullet = Bullet.instance()
	$"..".add_child(bullet)
	bullet.position = position
	bullet.velocity = v
	bullet.reach = 1200

func shoot_angle(speed, angle, reach):
	var v = Vector2(-speed, 0)
	v = v.rotated(angle)
	shoot(v, reach)
	
func angle_to_player():
	return position.angle_to_point($"../Player".position)
