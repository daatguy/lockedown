extends Node

var time = 0;
var casted = false;
var angleVector = Vector2.ZERO;
var enemy = null
var oldZP = 0
var oldZE = 0
# Declare member variables here. Examples:
func _process(delta):
	if(time>0):
		time -= delta
		get_tree().paused = true
		$"../AnimatedSprite".animation = "attack"
		var frame = $"..".direction*2
		if(time<0.3):
			if(!casted):
				casted = true
				$"AttackShadow".set_angle(angleVector);
				$"AttackShadow".visible = true
				oldZE = enemy.z_index 
				enemy.z_index = 4091
				oldZP = $"..".z_index 
				$"..".z_index = 4092
				enemy.update()
				$"..".update()
			frame += 1
		$"../AnimatedSprite".frame = frame
		$"Hit".play()
		return
	elif(time<0):
		$"AttackShadow".visible = false
		time = 0
		casted = false
		enemy.z_index = oldZE
		$"..".z_index = oldZP
	if(!get_parent().get_parent().get_node("PauseController").paused==true):
		get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
