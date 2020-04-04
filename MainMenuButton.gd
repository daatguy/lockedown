extends Label

func _ready():
	set_process_input(true)
	connect("mouse_entered", self, "_mouse_entered")
	connect("mouse_exited", self, "_mouse_exited")

func _mouse_entered():
	add_color_override("font_color", Color("FFFFFF"))

func _mouse_exited():
	add_color_override("font_color", Color("000000"))
