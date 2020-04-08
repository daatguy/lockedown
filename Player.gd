extends KinematicBody2D

export var speed = 800;
var direction = 0;
var screen_size #this feels like it belongs somewhere else
onready var fog = get_node("Camera2D/Fog")
onready var sprite = get_node("AnimatedSprite")
onready var healthBar = get_node("HealthBar")
export var PlayerBullet = preload("res://PlayerBullet.tscn")
export var Ray = preload("res://Ray.tscn")
var reload = 0;
var firing = .25; #how many seconds it takes you to shoot a bullet
var maxHealth = 4;
var health = maxHealth
const dashIFrameBegin = 0;
const dashIFrameEnd = 0.1;
const dashSpeed = 5600;
const dashSpeedCutoff = 2400;
const dashDecay = 0.15;
const dashDecayHold = 0.6;
var dashBulletMax = 1;
var dashBulletCount = 0;
var dashFrames = 0;
var dashVector : Vector2;
var dashing = false
var dashReleased = false;

func _ready():
	screen_size = get_viewport_rect().size
	#$RayCast2D.add_exception(self)

func _process(delta):
	
	healthBar.animation = str(health);
	z_index = int(99+position[1]*0.1)
	
	var velocity = Vector2.ZERO
	if(dashing):
		dashFrames += delta;
		var decay = dashDecay;
		$"DashSound".pitch_scale = 1.3+0.15*randf()
		if(Input.is_action_pressed("dash") && !dashReleased):
			decay = dashDecayHold
		else:
			dashReleased = true
		velocity = delta * dashVector.normalized() * (dashSpeed) * pow(decay, 1+5*dashFrames)
		if(velocity.length() < dashSpeedCutoff*delta):
			dashReleased = true
		if(velocity.length() <= speed*delta):
			dashing = false
	else:
		dashing = false
		if(reload < firing):
			reload += delta;
		if Input.is_action_pressed("right"):
			velocity += Vector2.RIGHT
		if Input.is_action_pressed("left"):
			velocity += Vector2.LEFT
		if Input.is_action_pressed("down"):
			velocity += Vector2.DOWN
		if Input.is_action_pressed("up"):
			velocity += Vector2.UP
		if Input.is_action_just_pressed('dash'):
			dash()
		velocity = velocity.normalized() * speed * delta
	if velocity.length() > 0:
		direction = fposmod(round(rad2deg(-velocity.angle())/45),8);
		sprite.animation = "walk"+str(direction)
	else:
		sprite.animation = "idle"+str(direction)
	if(!test_move(transform,velocity)):
		position += velocity

func is_valid_hit(damage, dirIn):
	var invDirIn = fposmod(dirIn+4,8)
	if(invDirIn==direction):
		return true
	if(dashBulletCount>dashBulletMax):
		return true
	if(dashFrames>=dashIFrameBegin && dashFrames<dashIFrameEnd):
		return false
	return false

func dash():
	$"DashSound".play()
	$"DashParticles".emitting = true
	dashing = true;
	dashReleased = false;
	dashBulletCount = 0;
	dashFrames = 0;
	dashVector = get_global_mouse_position()-get_global_position()

func _on_Bullet_hit(damage, dirIn):
	health -= damage;
	if(health==0):
		# Remove the current level
		
		var root = get_tree().get_root()
		# Add the next level
		var next_level_resource = load("res://dead.tscn")
		var next_level = next_level_resource.instance()
		next_level.direction = direction;
		root.add_child(next_level)
		
		var level = root.get_node("ingame")
		root.remove_child(level)
		level.call_deferred("free")
	else:
		$"Camera2D".shakeAmount = 16;
		$"PlayerHitFreeze".time = 0.1;
	
func _input(event):
	if event is InputEventMouseButton && reload > firing:
		var angle = get_global_position().angle_to_point(get_global_mouse_position())
		#shoot_angle(1000, angle, 500,1)
		#shoot_raycast(angle)
		reload = 0
		var ray = Ray.instance()
		ray.rotation = angle+PI
		add_child(ray)

		
func shoot(v, reach, damage):
	var bullet = PlayerBullet.instance()
	$"..".add_child(bullet)
	bullet.position = position + v.normalized()*128;
	bullet.velocity = v
	bullet.reach = reach
	bullet.damage = damage
	return bullet

func shoot_angle(speedIn, angleIn, reachIn, damageIn):
	var v = Vector2(-speedIn, 0)
	v = v.rotated(angleIn)
	return shoot(v, reachIn, damageIn)
