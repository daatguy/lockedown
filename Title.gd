extends AnimatedSprite

onready var sounds = get_node("Sounds")
var time = 0
signal main_menu_animation_done
# Called when the node enters the scene tree for the first time.
func _ready():
	#Reset the frame
	frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if(time>1):
		play("Start")
	if(frame==2):
		sounds.get_node("LOCKE").play()
	elif(frame==14):
		sounds.get_node("DOWN").play()
	if(frame==22):
		emit_signal("main_menu_animation_done")
