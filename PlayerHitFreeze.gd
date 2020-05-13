extends Node

var time = 0;
var casted = false;
var angle = 0;
onready var onecolor = preload("res://shaders/onecolor.material")
# Declare member variables here. Examples:
func _process(delta):
	if(time>0):
		time -= delta
		get_tree().paused = true
		$"../AnimatedSprite".material = onecolor
		$"../AnimatedSprite".material.set_shader_param("u_replacement_color", Color("#FFFFFF"))
		$"../AnimatedSprite".frame = $"..".direction
		$"Hit".play()
		return
	elif(time<0):
		time = 0
		casted = false
		$"../AnimatedSprite".material = null
	if(!get_parent().get_parent().get_node("PauseController").paused==true):
		get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
