extends RigidBody2D
var time = 0
export (PackedScene) var Bullet = preload("res://BaseBullet.tscn")
export (float) var seconds_per_shot = 1

func _process(delta):
	time += delta
	if time > seconds_per_shot:
		time = fmod(time, seconds_per_shot)
		shoot_pattern()
		
func shoot_pattern():
	shoot_angle(800, angle_8_to_player(), 3000, 37)

func shoot(v, reach, damage):
	var bullet = Bullet.instance()
	$"..".add_child(bullet)
	bullet.position = position
	bullet.velocity = v
	bullet.reach = reach
	bullet.damage = damage

func shoot_angle(speed, angle, reach, damage):
	var v = Vector2(-speed, 0)
	v = v.rotated(angle)
	shoot(v, reach, damage)
	
func angle_to_player():
	return position.angle_to_point($"../Player".position)
	
func angle_8_to_player():
	return deg2rad(floor(rad2deg(angle_to_player())/45+0.5)*45)
