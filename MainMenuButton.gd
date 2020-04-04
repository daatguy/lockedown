extends Label

func _ready():
	set_process_input(true)
	connect("mouse_entered", self, "_mouse_entered")
	connect("mouse_exited", self, "_mouse_exited")

func _mouse_entered():
	print_debug("hi mom")
	add_color_override("font_color", Color("#ff2f2f"))

func _mouse_exited():
	add_color_override("font_color", Color("#9a0256"))
	
