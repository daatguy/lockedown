extends Node

export (PackedScene) var Player = preload("res://Player.tscn")
var tilemap;
var size = Vector2(256,256)
var fillAmt = 0.53;
var smoothRange = 1;
var _seed;
var smoothCutoff = 5;
var halfsize

func _ready():
	halfsize = Vector2(round(size.x/2),round(size.x/2))
	generate()

func generate():
	seed_randoms()
	set_empty()
	seed_room(Vector2(-128,-128),size)
	smooth_map()
	render_ground()
	add_player()

func seed_randoms():
	if not _seed:
		randomize()
	_seed = randi() % 10000000
	seed(_seed)
	
func set_empty():
	var m = []
	for x in range(size.x):
		var c = [];
		for y in range(size.y):
			c.append(0)
		m.append(c)
	tilemap = m

func seed_room(pos : Vector2, rsize : Vector2):
	for x in range(0,size.x):
		for y in range(0,size.y):
			if( x>0 && 
				x<size.y-1 &&
				y>0 && 
				y<size.y-1 && 
				randf()>fillAmt ):
					tilemap[x][y] = 1;
			
func smooth_map():
	var oldmap = tilemap;
	for x in range(1,size.x-1):
		for y in range(1,size.y-1):
			var neighbors = 0;
			for xo in range(-smoothRange,smoothRange+1):
				for yo in range(-smoothRange,smoothRange+1):
					if(oldmap[x+xo][y+yo]!=0):
						neighbors += 1;
			if(neighbors>=smoothCutoff):
				tilemap[x][y] = 1;
			else:
				tilemap[x][y] = 0;

func render_ground():
	for x in range(0,size.x):
		for y in range(0,size.y):
			$"../TileMap".set_cell(x-round(size.x/2),y-round(size.x/2),tilemap[x][y]*15-1)
	$"../TileMap".update_bitmask_region()
	for x in range(0,size.x):
		for y in range(1,size.y):
			if(tilemap[x][y]==1&&tilemap[x][y-1]==0):
				$"../TileMap".set_cell(x-halfsize.x,y-halfsize.y-1,16);
	for x in range(0,size.x-1):
		for y in range(0,size.y):
			if(tilemap[x][y]==1&&tilemap[x+1][y]==0):
				$"../TileMap".set_cell(x-halfsize.x+1,y-halfsize.y,16);
	for x in range(1,size.x):
		for y in range(0,size.y):
			if(tilemap[x][y]==1&&tilemap[x-1][y]==0):
				$"../TileMap".set_cell(x-halfsize.x-1,y-halfsize.y,16);
	for x in range(0,size.x):
		for y in range(0,size.y-2):
			if(tilemap[x][y]==1&&tilemap[x][y+1]==0):
				var ind = randi()%3+1
				if(tilemap[x-1][y]==0&&tilemap[x-1][y+1]==0):
					ind = 0
				elif(tilemap[x+1][y]==0&&tilemap[x+1][y+1]==0):
					ind = 4
				$"../TileMap".set_cell(x-halfsize.x,y-halfsize.y+1,15,false,false,false,Vector2(ind,0))
				if(tilemap[x][y+2]==0):
					if(ind>0&&ind<4):
						ind = randi()%3+1
					$"../TileMap".set_cell(x-halfsize.x,y-halfsize.y+2,15,false,false,false,Vector2(ind,1))
				
	 
func add_player():
	while 1:
		var pos = Vector2(floor(rand_range(0,size.x)),floor(rand_range(0,size.y)))
		if(tilemap[pos.x][pos.y]==1):
			var player = Player.instance()
			$"..".call_deferred("add_child",player)
			player.position = (pos-halfsize)*16*12
			break
