extends KinematicBody2D
var time = 0
export (PackedScene) var Bullet = preload("res://BaseBullet.tscn")
export (float) var seconds_per_shot = 1.5
var recoilVector = Vector2.ZERO
var recoilAmount = 50;
var recoilDecay = 0.0001;
var movePause = 1.3;
var moveSpeed = 600;
var pitch;
var pitchVariation = 0.3
var minRange = 300;
var shootRange = 500;
var sightRange = 1000;
var z_offset = 99;
var velocity : Vector2
var direction;
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
	direction = floor(rad2deg(angle_to_player())/45+3.5)
	if(direction==-1):
		direction = 0;
	var distance = $"../Player".global_position.distance_to(global_position);
	if((distance<shootRange) || (distance<sightRange && time<=movePause)):
		time += delta
	if(distance<sightRange && (distance>=shootRange && time>movePause && distance>minRange)):
		velocity = Vector2.RIGHT.rotated((direction+1)/8*2*PI)*moveSpeed*delta
	else:
		velocity = Vector2.ZERO
	if(time > seconds_per_shot):
		time = fmod(time, seconds_per_shot)
		shoot_pattern()
	velocity += recoilVector
	#1000.0 because of floating point weirdness
	recoilVector *= pow(recoilDecay,1000.0/delta)
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.slide(collision.normal)
		move_and_collide(velocity)
		
		
func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if(distance<shootRange):
		shoot_angle(900, angle_8_to_player(), 3000, 1)
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
	recoilVector = -v.normalized()*recoilAmount
	return bullet

func shoot_angle(speed, angle, reach, damage):
	var v = Vector2(-speed, 0)
	v = v.rotated(angle)
	return shoot(v, reach, damage)
	
func angle_to_player():
	return position.angle_to_point($"../Player".position)
	
func angle_8_to_player():
	return deg2rad(floor(rad2deg(angle_to_player())/45+0.5)*45)

func set_health(h):
	health = h
	if h <= 0:
		queue_free()
