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

func _draw():
	print("draw start" + str(OS.get_ticks_msec()))
	var zoom = $"../../Camera2D".zoom
	var bound1 = angleVector.rotated(-shadowWidth/2)
	var bound2 = angleVector.rotated(shadowWidth/2)
	# warning-ignore:narrowing_conversion
	var xquad = (sign(bound1.x)+1)/2
	# warning-ignore:narrowing_conversion
	var yquad = (sign(bound1.y)+1)/2
	if(xquad==yquad):
		xquad = 1-xquad
		yquad = 1-yquad
	var xSize = floor(get_viewport().size.x/pixelSize*zoom.x*1.5)
	var ySize = floor(get_viewport().size.y/pixelSize*zoom.y*1.5)
	draw_rect(Rect2($"../..".get_global_position()-get_viewport().size/2*1.5*zoom, get_viewport().size*1.5*zoom), lightColor)
	if(sign(bound1.x)==sign(bound2.x) && sign(bound1.y)==sign(bound2.y)):
		for x in range(xSize*xquad*0.5,xSize*(xquad*0.5+0.5)):
			for y in range(ySize*yquad*0.5,ySize*(yquad*0.5+0.5)):
				# warning-ignore:narrowing_conversion
				var relX : int = x-floor(xSize/2)
				# warning-ignore:narrowing_conversion
				var relY : int = y-floor(ySize/2)
				var light = !(relY*bound1.y>relX*bound1.x && relY*bound2.y<relX*bound2.x)
				var color = lightColor if light else shadowColor
				draw_rect(Rect2($"../..".get_global_position()-get_viewport().size/2*1.5*zoom+Vector2(x*pixelSize, y*pixelSize), Vector2(pixelSize, pixelSize)), color)
	elif(sign(bound1.x)!=sign(bound2.x)):
		for x in range(xSize*xquad*0.5,xSize*(xquad*0.5+0.5)):
			for y in range(ySize):
				# warning-ignore:narrowing_conversion
				var relX : int = x-floor(xSize/2)
				# warning-ignore:narrowing_conversion
				var relY : int = y-floor(ySize/2)
				var light = !(relY*bound1.y>relX*bound1.x && relY*bound2.y<relX*bound2.x)
				var color = lightColor if light else shadowColor
				draw_rect(Rect2($"../..".get_global_position()-get_viewport().size/2*1.5*zoom+Vector2(x*pixelSize, y*pixelSize), Vector2(pixelSize, pixelSize)), color)
	else:
		for x in range(xSize):
			for y in range(ySize*yquad*0.5,ySize*(yquad*0.5+0.5)):
				# warning-ignore:narrowing_conversion
				var relX : int = x-floor(xSize/2)
				# warning-ignore:narrowing_conversion
				var relY : int = y-floor(ySize/2)
				var light = !(relY*bound1.y>relX*bound1.x && relY*bound2.y<relX*bound2.x)
				var color = lightColor if light else shadowColor
				draw_rect(Rect2($"../..".get_global_position()-get_viewport().size/2*1.5*zoom+Vector2(x*pixelSize, y*pixelSize), Vector2(pixelSize, pixelSize)), color)
	print("draw end" + str(OS.get_ticks_msec()))
