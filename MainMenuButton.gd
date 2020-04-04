extends Button

var wasHovered = false;
onready var hoverSound = get_parent().get_node("Hover")
onready var clickSound = get_parent().get_node("Click")
const vol = -48;
const gain = 4;
const shakeGrow = 0.025;
const shakeMin = 3;
const shakeMax = 24;
var shakeSize = shakeMin;
var x;
var y;

func _pressed():
	clickSound.play();

func _ready():
	x = self.rect_global_position.x;
	y = self.rect_global_position.y;

func _process(delta):
	if(self.is_hovered()):
		wasHovered = true;
		hoverSound.playing = true;
		hoverSound.pitch_scale = 1+(self.shakeSize-shakeMin)/shakeMax;
		hoverSound.volume_db = vol+gain*(self.shakeSize-shakeMin)/shakeMax;
		self.rect_global_position.x = randf()*shakeSize-shakeSize/2+x;
		self.rect_global_position.y = randf()*shakeSize-shakeSize/2+y;
		if(shakeSize<shakeMax):
			self.shakeSize += shakeGrow;
	elif(wasHovered):
		wasHovered = false;
		hoverSound.playing = false;
		hoverSound.pitch_scale = 1
		hoverSound.volume_db = vol;
		self.shakeSize = shakeMin;
		self.rect_global_position.x = x;
		self.rect_global_position.y = y;
