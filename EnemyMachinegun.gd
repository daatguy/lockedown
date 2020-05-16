extends "res://EnemyGeneric.gd"

export var shots_per_volley = 10
var shots_taken = shots_per_volley
export var between_volley_shots = .2
export var between_volleys = 4

func _ready():
	pitchVariation = 0;
	shootRange = 1600;
	sightRange = 1600;
	moveSpeed = 0;

func _process(_delta):
	if(seconds_per_shot == between_volley_shots):
		var dir = dir_to_player()
		$"AnimatedSprite".animation = "shoot"+str(dir)
		$"AnimatedSprite".speed_scale = 1;
	elif(time>1):
		$"AnimatedSprite".animation = "crank"
		$"AnimatedSprite".speed_scale = time;
	else:
		$"AnimatedSprite".animation = "idle"
		$"AnimatedSprite".speed_scale = 1;

func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if (shots_taken == shots_per_volley):
		if(distance<shootRange):
			shots_taken = 0
			seconds_per_shot = between_volleys
			get_node("ShootSound").play();
		else:
			seconds_per_shot = 0.1;
		return
	elif (shots_taken == 0):
		seconds_per_shot = between_volley_shots
	shoot_angle(900, angle_to_player(), 1500, 1)
	shots_taken += 1
