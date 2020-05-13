extends Node

var bpm : float = 118
var timer : float = 0
var beattimer : float = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	timer += delta
	beattimer += delta
	while(beattimer>60/bpm):
		beattimer -= 60/bpm
		
func get_beat_time():
	return beattimer
			
func get_time_to_next_beat():
	return 60/bpm-beattimer
	
func get_time_to_next_beat_delay(delay):
	var t = get_time_to_next_beat()
	while(t<delay): t += 60/bpm
	return t


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
