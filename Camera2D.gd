extends Camera2D

const pixelSize = 12;
var shakeAmount = 0;
var shakeDecay = 0.65;
var shakeDecayDefault = 0.65;
var followDecay = 0.7;
var deltaPos = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	shakeAmount = 0;
	pass # Replace with function body.

func set_shake(amt, dcy):
	if(shakeAmount<amt): shakeAmount = amt;
	if(shakeDecay<dcy): shakeDecay = dcy;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(delta==0):
		return
	shakeAmount *= pow(shakeDecay,$"../".targetDelta/delta)
	var shakeVector = Vector2(0,0);
	shakeVector.x = sqrt(sqrt(randf()))*0.5*(rand_range(0, 1)*2-1)*shakeAmount;
	shakeVector.y = sqrt(sqrt(randf()))*0.5*(rand_range(0, 1)*2-1)*shakeAmount;
	if(shakeAmount<0.001):
		shakeDecay = shakeDecayDefault
	
	var globalPos = get_global_position()
	position = -deltaPos
	offset.x = -fposmod(globalPos.x,pixelSize)/scale.x;
	offset.y = -fposmod(globalPos.y,pixelSize)/scale.y;
	offset += shakeVector;
	if(!$"../".cameraFollowPause):
		deltaPos *= pow(followDecay,$"../".targetDelta/delta)
