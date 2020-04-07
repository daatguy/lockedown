extends "res://MenuButton.gd"

func _ready():
	._ready()
	#warning-ignore: RETURN_VALUE_DISCARDED
	get_node("../Options").connect("options_displayed", self, "_on_options_displayed")

func _get_max_text():
	return "quit";

func _pressed():
	._pressed();
	get_tree().quit();

func _on_options_displayed():
	show()
