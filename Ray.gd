extends Area2D

var timer = 0;
export var EnemyGeneric = preload("res://EnemyGeneric.gd")
export var EnemySpiral = preload("res://EnemySpiral.gd")

func _ready():
	$"Sound".play()
	for body in get_overlapping_bodies():
		if body is EnemyGeneric && !(body is EnemySpiral):
			body.queue_free()
		$"Sound2".play()

func _process(delta):
	timer += delta
	$"Sprite".modulate = Color(1,1,1,1.1-timer*4)
	if timer > .5:
		queue_free()
	
