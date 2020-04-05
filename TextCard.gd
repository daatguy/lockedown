extends Node2D

onready var sound = get_node("ClickSound")
var timer = 0;
var maxTimer : float;
var textContent : String;
var done = false;

func _ready():
	get_tree().paused = true;
	get_node("CanvasLayer").get_node("Text").text = textContent
	pass
	
func _process(delta):
	timer += delta
	if(timer>maxTimer && !done):
		sound.play()
		get_tree().paused = false;
		done = true;
		get_node("CanvasLayer").get_node("ColorRect").hide()
		get_node("CanvasLayer").get_node("Text").hide()
	if(done && sound.get_playback_position()>=1):
		queue_free()
