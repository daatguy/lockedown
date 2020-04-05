extends Area2D

var velocity = Vector2() setget set_velocity
var direction = 0

func set_velocity(v):
	direction = v.angle()
	$AnimatedSprite.rotation = direction
	velocity = v

#since Player doen't use delta, I suppose we may as well make
#everything FPS-based until when we may decide to fix that
func _process(delta):
	position += velocity
	#something something hit
