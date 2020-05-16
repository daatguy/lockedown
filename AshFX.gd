extends Node2D

export (Texture) var texture setget _set_texture
var splats : Array = [];
const size = 64

func add_splat(pos : Vector2, dir : int):
	splats.append([pos,dir])
	
func _process(_delta):
	update()
	
func _set_texture(value):
	# If the texture variable is modified externally,
	# this callback is called.
	texture = value #texture was changed
	update() # update the node

func _draw():
	for splat in splats:
		var pos = splat[0]
		var dir = splat[1]
		#z_index = int(pos[1]*0.1)
		var rect1 = Rect2(pos-$"..".get_global_position()-+Vector2(1,1)*size*$"../AnimatedSprite".pixelSize/2, Vector2(1,1)*size*$"../AnimatedSprite".pixelSize)
		var rect2 = Rect2(dir*size,0,size,size)
		texture.draw_rect_region(get_canvas_item(), rect1, rect2)
