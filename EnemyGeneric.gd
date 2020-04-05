extends RigidBody2D
var time = 0
export (PackedScene) var Bullet
export var seconds_per_shot = 1

func _process(delta):
	time += delta
	if time > seconds_per_shot:
		time = fmod(time, seconds_per_shot)
		shoot_angle(300, angle_to_player())

func shoot(v):
	var bullet = Bullet.instance()
	$"..".add_child(bullet)
	bullet.position = position
	bullet.velocity = v

func shoot_angle(speed, angle):
	var v = Vector2(speed, 0)
	v = v.rotated(angle)
	shoot(v)
	
func angle_to_player():
	return PI + position.angle_to_point($"../Player".position)
