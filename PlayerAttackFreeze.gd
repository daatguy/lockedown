extends Node

onready var onecolor = preload("res://shaders/onecolor.material")
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
		if(time<0.2):
			if(!casted):
				casted = true
				#$"../Fog Top".visible = false
				$"AttackShadow".set_angle(angleVector);
				$"AttackShadow".visible = true
				enemy.get_node("AnimatedSprite").material = onecolor
				enemy.get_node("AnimatedSprite").material.set_shader_param("u_replacement_color", Color("#001535"))
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
		$"../Camera2D".shakeAmount = 512
		#$"../Fog Top".visible = true
		enemy.get_node("AnimatedSprite").material = null
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
