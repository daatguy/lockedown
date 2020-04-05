extends "res://BaseBullet.gd"

const EnemyGeneric = preload("res://EnemyGeneric.gd")

func _ready():
	connect("body_entered", self, "_on_self_body_entered")
	
func _on_self_body_entered(body):
	print(body)
	if (body is EnemyGeneric):
		body.health -= damage
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
