extends Control

func _ready():
	$"Main Menu Buttons/Play".connect("play_pressed", self, "_on_Play_play_pressed")
	
func _on_Play_play_pressed():
	hide()
