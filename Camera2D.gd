extends Camera2D

const pixelSize = 12;
var shakeAmount = 0;
var shakeDecay = 0.65;

# Called when the node enters the scene tree for the first time.
func _ready():
	shakeAmount = 0;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	shakeAmount *= shakeDecay;
	var shakeVector = Vector2(0,0);
	shakeVector.x = (randf()-0.5)*shakeAmount;
	shakeVector.y = (randf()-0.5)*shakeAmount;
	
	var pixelPos = get_global_transform().origin
	offset.x = -fposmod(pixelPos.x,pixelSize)/scale.x;
	offset.y = -fposmod(pixelPos.y,pixelSize)/scale.y;
	offset += shakeVector;
