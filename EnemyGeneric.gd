extends KinematicBody2D
var time = 0
export (PackedScene) var Bullet = preload("res://BaseBullet.tscn")
export (float) var seconds_per_shot = 1
var pitch;
var pitchVariation = 0.3
var sightRange = 800;
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
	
func _process(delta):
	z_index = z_offset+position[1]*0.1
	time += delta
	if(time > seconds_per_shot):
		time = fmod(time, seconds_per_shot)
		shoot_pattern()
	direction = floor(rad2deg(angle_to_player())/45+3.5)
	if(direction==-1):
		direction = 0;
	
		
		
func shoot_pattern():
	var distance = $"../Player".global_position.distance_to(global_position);
	if(distance<sightRange):
		shoot_angle(800, angle_8_to_player(), 3000, 1)
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
	return bullet

func shoot_angle(speed, angle, reach, damage):
	var v = Vector2(-speed, 0)
	v = v.rotated(angle)
	return shoot(v, reach, damage)
	
func angle_to_player():
	return position.angle_to_point($"../Player".position)
	
func angle_8_to_player():
	return deg2rad(floor(rad2deg(angle_to_player())/45+0.5)*45)

func _on_Area2D_area_entered(area):
	print("AAAAAa")

func set_health(h):
	health = h
	if h <= 0:
		queue_free()
