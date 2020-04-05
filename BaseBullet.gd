extends Area2D

var velocity = Vector2() setget set_velocity
var direction = 0
signal hit(damage)

func _ready():
	$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")
	connect("hit", $"../Player", "_on_Bullet_hit")
	connect("body_entered", self, "_on_self_body_entered")

func set_velocity(v):
	velocity = v
	direction = fposmod(floor(rad2deg(-velocity.angle())/45),8)
	$AnimatedSprite.frame = direction

#since Player doen't use delta, I suppose we may as well make
#everything FPS-based until when we may decide to fix that
func _process(delta):
	position += velocity
	#something something hit

func _on_self_body_entered(body):
	if body == $"../Player":
		emit_signal("hit", 37)
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()

func _on_Visibility_screen_exited():
	queue_free()
