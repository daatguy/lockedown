extends KinematicBody2D
var time = 0
export (PackedScene) var Bullet = preload("res://BaseBullet.tscn")
export (float) var seconds_per_shot = 1.2
var recoilVector = Vector2.ZERO
var recoilAmount = 50;
var recoilDecay = 0.1;
var movePause = 0.6;
var moveSpeed = 600;
var pitch;
var pitchVariation = 0.3
var minRange = 300;
var shootRange = 500;
var sightRange = 1000;
var z_offset = 99;
var velocity : Vector2
var direction;
var smartAngleBias = 0.7;
var smartMoveBias = 0.5;
var shooting = false
var health = 2 setget set_health
onready var sprite = get_node("AnimatedSprite")

func _ready():
	pitch = get_node("ShootSound").pitch_scale;
	direction = floor(rand_range(0,8))
	#$Area2D.connect("area_entered", self, "_on_Area2D_area_entered")
	time = seconds_per_shot
	
func _process(delta):
	var z = z_offset+position[1]*0.1
	if(z>-4095 && z<4096):
		z_index = z
	direction = dir_to_player()
	var distance = $"../Player".global_position.distance_to(global_position);
	if((distance<shootRange) || (distance<sightRange && time<=movePause)):
		time += delta
	if(distance<sightRange && (distance>=shootRange && time>movePause && distance>minRange)):
		velocity = Vector2.RIGHT.rotated(smart_angle_to_player(distance/moveSpeed,smartMoveBias)+PI/4)*moveSpeed*delta
	else:
		velocity = Vector2.ZERO
	if(time > seconds_per_shot):
		time = fmod(time, seconds_per_shot)
		shoot_pattern()
	velocity += recoilVector
	if(delta!=0): recoilVector *= pow(recoilDecay,1.0/delta)
	#buggy error handling from pow
	if(str(recoilVector)=="(-1.#IND,-1.#IND)"): recoilVector = Vector2.ZERO
	if(str(velocity)=="(-1.#IND,-1.#IND)"): velocity = Vector2.ZERO
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.slide(collision.normal)
		#warning-ignore:RETURN_VALUE_DISCARDED
		move_and_collide(velocity)
		
		
func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if(distance<shootRange):
		shoot_angle(900, smart_angle_8_to_player(distance/900, smartAngleBias), 900*1.2*2, 1)
		get_node("ShootSound").pitch_scale = pitch-pitchVariation/2+pitchVariation*randf();
		get_node("ShootSound").play();

func shoot(v, reach, damage):
	var bullet = Bullet.instance()
	$"..".add_child(bullet)
	bullet.position = position + v.normalized()*128;
	bullet.velocity = v
	bullet.reach = reach
	bullet.damage = damage
	shooting = true
	sprite.frame = 0
	recoilVector = -v.normalized()*recoilAmount
	return bullet

func shoot_angle(speed, angle, reach, damage):
	var v = Vector2(-speed, 0)
	v = v.rotated(angle-PI*0.75)
	return shoot(v, reach, damage)
	
func angle_to_player():
	var vec = $"../Player".position-position
	var r = 0;
	if(vec.x==0):
		r = 0.5*PI if vec.y>0 else 1.5*PI
	else:
		r = atan2(vec.y,vec.x)-PI/4
	if(r<0): r+= 2*PI
	if(r>2*PI): r-= 2*PI
	return r
	
func smart_angle_to_player(itime, bias):
	var vec = $"../Player".position+$"../Player".velocity*itime/$"../Player".lastDelta*bias-position
	var r = 0;
	if(vec.x==0):
		r = 0.5*PI if vec.y>0 else 1.5*PI
	else:
		r = atan2(vec.y,vec.x)-PI/4
	if(r<0): r+= 2*PI
	if(r>2*PI): r-= 2*PI
	return r
	
func dir_to_player():
	var r = int(angle_8_to_player()/PI*4)
	if r>=8: r = 0
	if r<0: r = 7
	return r 
	
func angle_8_to_player():
	return round(angle_to_player()/2/PI*8)/8*2*PI
	
func smart_angle_8_to_player(itime,bias):
	return round(smart_angle_to_player(itime,bias)/2/PI*8)/8*2*PI

func set_health(h):
	health = h
	if h <= 0:
		queue_free()
