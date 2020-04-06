extends Node2D

var timer = 0;

func _process(delta):
	timer =+ delta
	$"Sprite".modulate = Color(1,1,1,1.1-timer*4)

func _on_self_body_entered(body):
	if body != $"../Player":
		body.get_parent().remove_child(body);
