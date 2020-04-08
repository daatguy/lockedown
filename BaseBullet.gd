extends Area2D

var velocity = Vector2() setget set_velocity
var reach = 1200
var direction = 0
var damage = 37
signal hit(damage, direction)
var z_offset = 100;

func _ready():
	#warning-ignore: RETURN_VALUE_DISCARDED
	$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")
	#warning-ignore: RETURN_VALUE_DISCARDED
	connect("hit", $"../Player", "_on_Bullet_hit")
	#warning-ignore: RETURN_VALUE_DISCARDED
	connect("body_entered", self, "_on_self_body_entered")

func set_velocity(v):
	velocity = v
	direction = fposmod(round(rad2deg(-velocity.angle())/45),8);
	#if(velocity.y>0):
	#	direction += 1
	$AnimatedSprite.frame = direction


func _process(delta):
	#Y Sorting
	z_index = z_offset+position[1]*0.1
	
	if reach <= 0:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
	position += velocity * delta
	reach -= velocity.length() * delta

func _on_self_body_entered(body):
	if body == $"../Player":
		body.dashBulletCount += 1;
		if(body.is_valid_hit(damage,direction)):
			emit_signal("hit", damage, direction)
			hide()
			$CollisionShape2D.set_deferred("disabled", true)
			queue_free()

func _on_Visibility_screen_exited():
	queue_free()
