extends RigidBody2D
var time = 0
export (PackedScene) var Bullet
export var seconds_per_shot = 1

func _process(delta):
	time += delta
	if time > seconds_per_shot:
		time = fmod(time, seconds_per_shot)
		shoot(Vector2(-300, 300))
		shoot(Vector2(300, 300))
		shoot(Vector2(-300, -300))
		shoot(Vector2(300, -300))
		shoot(Vector2(0, 300))
		shoot(Vector2(0, -300))
		shoot(Vector2(-300, 0))
		shoot(Vector2(300, 0))

func shoot(v):
	var bullet = Bullet.instance()
	$"..".add_child(bullet)
	bullet.position = position
	bullet.velocity = v
