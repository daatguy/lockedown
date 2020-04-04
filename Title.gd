extends AnimatedSprite

onready var sounds = get_node("Sounds")
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#Reset the frame
	frame = 0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if(time>1):
		play("Start")
	if(frame==2):
		sounds.get_node("LOCKE").play()
	elif(frame==14):
		sounds.get_node("DOWN").play()
	pass
