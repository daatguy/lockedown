extends "res://MenuButton.gd"

signal options_displayed

func _get_max_text():
	return "options";

func _ready():
	._ready()
	get_node("../Play").connect("play_displayed", self, "_on_play_displayed")

func _on_play_displayed():
	show()

func _on_finished_text():
	emit_signal("options_displayed");
