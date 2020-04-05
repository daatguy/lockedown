extends "res://MenuButton.gd"

signal options_displayed

func _get_max_text():
	return "options"

func _ready():
	._ready()
	get_node("../Resume").connect("resume_displayed", self, "_on_resume_displayed")

func _on_resume_displayed():
	show()

func _on_finished_text():
	emit_signal("options_displayed")
