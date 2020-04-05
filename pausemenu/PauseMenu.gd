extends Popup

onready var already_paused = false
onready var pause_enabled = true
onready var paused = false

func is_paused():
	return paused

func disable():
	pause_enabled = false

func enable():
	pause_enabled = true

func is_enabled():
	return pause_enabled

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			print(is_paused(), is_enabled(), already_paused)
			if is_enabled():
				if not is_paused():
					get_tree().paused = true
					popup()
					paused = true
				else:
					hide()
					if not already_paused:
						get_tree().paused = false
					paused = false
