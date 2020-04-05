extends Camera2D

var shakeAmount = 0;
var shakeDecay = 0.6;

# Called when the node enters the scene tree for the first time.
func _ready():
	shakeAmount = 32;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shakeAmount *= shakeDecay;
	var shakeAmount = Vector2();
	shakeAmount.x = (randf()-0.5)*shakeAmount;
	shakeAmount.y = (randf()-0.5)*shakeAmount;
	offset = shakeAmount;
	pass
