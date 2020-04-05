extends Button

var maxText = ""
var textLength = 0
const textSpeed = 0.3
var wasHovered = false
onready var loadSound = get_node("Load")
onready var hoverSound = get_parent().get_node("Hover")
onready var clickSound = get_parent().get_node("Click")
const vol = -40
const gain = 4
const shakeGrow = 0.025
const shakeMin = 3
const shakeMax = 24
var shakeSize = shakeMin
var x
var y

#Implement in children
func _on_finished_text():
	pass

func _pressed():
	clickSound.play()

func _ready():
	x = self.rect_position.x
	y = self.rect_position.y
	maxText = text
	hide()

func _process(_delta):
	if(self.is_hovered()):
		wasHovered = true
		hoverSound.playing = true
		hoverSound.pitch_scale = 1+(self.shakeSize-shakeMin)/shakeMax
		hoverSound.volume_db = vol+gain*(self.shakeSize-shakeMin)/shakeMax
		self.rect_position.x = randf()*shakeSize-shakeSize/2+x
		self.rect_position.y = randf()*shakeSize-shakeSize/2+y
		if(shakeSize<shakeMax):
			self.shakeSize += shakeGrow
	elif(wasHovered):
		wasHovered = false
		hoverSound.playing = false
		hoverSound.pitch_scale = 1
		hoverSound.volume_db = vol
		self.shakeSize = shakeMin
		self.rect_position.x = x
		self.rect_position.y = y

	#Texty things

	if(is_visible()):
		if(textLength==0):
			loadSound.play()
		if(textLength<maxText.length()):
			textLength += textSpeed
			if(textLength>=maxText.length()):
				textLength = maxText.length()
				_on_finished_text()
		text = maxText.substr(0,floor(textLength))
