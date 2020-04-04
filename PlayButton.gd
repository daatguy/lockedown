extends "res://MainMenuButton.gd"

signal play_displayed

func _ready():
	._ready();
	get_node("../../Title").connect("displayed", self, "_on_Title_displayed");

func _on_Title_displayed():
	show();

func _get_max_text():
	return "play game";

func _on_finished_text():
	emit_signal("play_displayed");
