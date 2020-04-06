extends "res://MenuButton.gd"

func _ready():
	._ready()
	get_node("../Options").connect("options_displayed", self, "_on_options_displayed")
	self.owner.connect("about_to_show", self, "_on_PauseMenu_about_to_show")

func _on_PauseMenu_about_to_show():
	hide()
	textLength = 0

func _get_max_text():
	return "quit"

func _pressed():
	._pressed()
	get_tree().quit()

func _on_options_displayed():
	show()
