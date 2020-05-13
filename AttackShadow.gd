extends Node2D

const pixelSize = 12
const shadowWidth = PI/3
const shadowColor = '#001535'
const lightColor = '#FFFFFF'
var angleVector = Vector2.ZERO
var lightmap = []

func ready():
	set_angle(0);

func set_angle(iangle):
	angleVector = iangle.normalized().rotated(-PI/2)
	update()
	
func update_lightmap():
	var bound1 = angleVector.rotated(-shadowWidth/2)
	var bound2 = angleVector.rotated(shadowWidth/2)
	lightmap =  []
	for x in range(floor(get_viewport().size.x/pixelSize*2)):
		lightmap.append([])
		for y in range(floor(get_viewport().size.y/pixelSize*2)):
			var relX = x-floor(get_viewport().size.x/pixelSize)
			var relY = y-floor(get_viewport().size.y/pixelSize)
			var light = !(relY*bound1.y>relX*bound1.x && relY*bound2.y<relX*bound2.x)
			
			lightmap[x].append(light)

func _draw():
	update_lightmap()
	for x in range(lightmap.size()):
		for y in range(lightmap[x].size()):
			var color = lightColor if lightmap[x][y] else shadowColor
			draw_rect(Rect2($"../../".get_global_position()-get_viewport().size+Vector2(x*pixelSize, y*pixelSize), Vector2(pixelSize, pixelSize)), color)
