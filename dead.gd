extends Node2D

export (PackedScene) var MainMenu = preload("res://mainmenu.tscn")

var timer = 0;
var direction = 0;
var menud = false;

func _ready():
	$"AnimatedSprite".frame = direction;

func _process(delta):
	timer += delta;
	if(timer>2 && !menud):
		var menu = MainMenu.instance()
		add_child(menu)
		menud = true;

func set_direction(direction):
	self.direction = int(floor(direction))
