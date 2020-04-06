extends 'res://MenuButton.gd'

var pausecontroller

func _get_max_text():
	return "quit"

func _ready():
	show()
	
func _pressed():
	._pressed();
	get_tree().paused = false
	pausecontroller.paused = false
	$"../..".remove_child($"../..".get_node("PauseMenu"))
