extends "res://MenuButton.gd"

signal options_displayed

func _get_max_text():
	return "options"

func _ready():
	._ready()
	get_node("../Resume").connect("resume_displayed", self, "_on_resume_displayed")
	self.owner.connect("about_to_show", self, "_on_PauseMenu_about_to_show")

func _on_PauseMenu_about_to_show():
	hide()
	textLength = 0

func _on_resume_displayed():
	show()

func _on_finished_text():
	emit_signal("options_displayed")
