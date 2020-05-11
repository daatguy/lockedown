extends Node

var time = 0;
# Declare member variables here. Examples:
func _process(delta):
	if(time>0):
		time -= delta
		get_tree().paused = true
		$"../AnimatedSprite".animation = "attack"
		var frame = $"..".direction*2
		if(time<0.1):
			frame += 1
		$"../AnimatedSprite".frame = frame
		$"Hit".play()
		return
	elif(time<0):
		time = 0
	if(!get_parent().get_parent().get_node("PauseController").paused==true):
		get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
