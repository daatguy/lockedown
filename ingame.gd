extends Node

export (PackedScene) var PauseMenu = preload("res://pausemenu.tscn")
var menu
var paused = false;

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		paused = get_tree().paused
		if(paused):
			menu = PauseMenu.instance()
			add_child(menu)
			menu.get_node("Resume").pausecontroller = self
		else:
			remove_child(menu)
