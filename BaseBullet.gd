extends Area2D

var velocity = Vector2() setget set_velocity
var direction = 0

func _ready():
	$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")

func set_velocity(v):
	direction = v.angle()
	$AnimatedSprite.rotation = direction
	velocity = v

#since Player doen't use delta, I suppose we may as well make
#everything FPS-based until when we may decide to fix that
func _process(delta):
	position += velocity
	#something something hit

func _on_Visibility_screen_exited():
	queue_free()
