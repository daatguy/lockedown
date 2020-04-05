extends RigidBody2D
var ticks = 0 #make time in future?
export (PackedScene) var Bullet
var ticks_per_shot = 30

func _process(delta): #everything else ignores delta ¯\_(ツ)_/¯
	ticks += 1
	if ticks > ticks_per_shot:
		print("shot")
		ticks %= ticks_per_shot
		var bullet = Bullet.instance()
		$"..".add_child(bullet)
		bullet.position = position
		bullet.velocity = Vector2(25, -25)
