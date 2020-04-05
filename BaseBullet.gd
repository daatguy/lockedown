extends Area2D

var velocity = Vector2() setget set_velocity
var reach = 1200
var direction = 0
signal hit(damage)

func _ready():
	$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")
	connect("hit", $"../Player", "_on_Bullet_hit")
	connect("body_entered", self, "_on_self_body_entered")

func set_velocity(v):
	velocity = v
	direction = fposmod(floor(rad2deg(-velocity.angle())/45),8);
	if(velocity.y>0):
		direction += 1
	$AnimatedSprite.frame = direction


func _process(delta):
	if reach <= 0:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
	position += velocity * delta
	reach -= velocity.length() * delta

func _on_self_body_entered(body):
	if body == $"../Player":
		emit_signal("hit", 37)
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()

func _on_Visibility_screen_exited():
	queue_free()
