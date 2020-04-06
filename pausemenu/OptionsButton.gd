extends "res://MenuButton.gd"

signal options_displayed

func _get_max_text():
	return "options"

func _ready():
	._ready()

func _on_finished_text():
	emit_signal("options_displayed")
