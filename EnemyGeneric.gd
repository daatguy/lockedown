extends RigidBody2D
var ticks = 0 #make time in future?
export (PackedScene) var Bullet
export var ticks_per_shot = 30

func _process(delta): #everything else ignores delta ¯\_(ツ)_/¯
	ticks += 1
	if ticks > ticks_per_shot:
		ticks %= ticks_per_shot
		shoot(Vector2(25, -25))

func shoot(v):
	var bullet = Bullet.instance()
	$"..".add_child(bullet)
	bullet.position = position
	bullet.velocity = v
