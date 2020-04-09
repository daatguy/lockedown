extends Node

var time = 0;
# Declare member variables here. Examples:
func _process(delta):
	if(time>0):
		time -= delta
		get_tree().paused = true
		$"../AnimatedSprite".animation = "hit"
		$"../AnimatedSprite".frame = $"..".direction;
		$"../Camera2D/HealthBar".animation = "hit"
		$"../Camera2D/HealthBar".frame = $"..".health-1;
		$"Hit".play()
		return
	elif(time<0):
		time = 0
	if(!get_parent().get_parent().get_node("PauseController").paused==true):
		get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
