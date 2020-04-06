extends Node2D

var timer = 0;

func _process(delta):
	timer += delta
	$"Sprite".modulate = Color(1,1,1,1.1-timer*4)
