extends 'res://MenuButton.gd'

signal resume_displayed
var time = 0
var about_to_pause = false

func _ready():
	._ready()
	self.owner.connect("about_to_show", self, "_on_PauseMenu_about_to_show")

func _on_PauseMenu_about_to_show():
	about_to_pause = true

func _pressed():
	._pressed()
	print(self.owner)
	self.owner.hide()
	if not self.owner.already_paused:
		get_tree().paused = false

func _process(delta):
	if(about_to_pause && time<0.8):
		time += delta
	elif(about_to_pause && time>=0.8):
		show()
		about_to_pause = false

func _get_max_text():
	return "play game"

func _on_finished_text():
	emit_signal("resume_displayed")
