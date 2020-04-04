extends Button

const shakeGrow = 0.025;
const shakeMin = 3;
const shakeMax = 24;
var shakeSize = shakeMin;
var x;
var y;

func _ready():
	x = self.rect_global_position.x;
	y = self.rect_global_position.y;
	hide()
	$Parent/Title.connect("displayed", self, "_on_Title_displayed")
	
func _on_Title_displayed():
	show()

func _process(delta):
	if(self.is_hovered()):
		self.rect_global_position.x = randf()*shakeSize-shakeSize/2+x;
		self.rect_global_position.y = randf()*shakeSize-shakeSize/2+y;
		if(shakeSize<shakeMax):
			shakeSize += shakeGrow;
	else:
		shakeSize = shakeMin;
		self.rect_global_position.x = x;
		self.rect_global_position.y = y;
