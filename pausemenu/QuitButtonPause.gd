extends "res://MenuButton.gd"

func _get_max_text():
	return "quit"

func _ready():
	show()
	
func _pressed():
	._pressed();
	get_tree().quit();
