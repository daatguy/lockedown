extends Area2D

var timer = 0;
export var EnemyGeneric = preload("res://EnemyGeneric.gd")

func _process(delta):
	timer += delta
	$"Sprite".modulate = Color(1,1,1,1.1-timer*4)
	if timer > .5:
		queue_free()
	for body in get_overlapping_bodies():
		if body is EnemyGeneric:
			body.queue_free()
