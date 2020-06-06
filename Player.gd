extends KinematicBody2D

export var speed = 800;
var direction = 0;
var screen_size #this feels like it belongs somewhere else
onready var fog = get_node("Fog")
onready var sprite = get_node("AnimatedSprite")
onready var healthBar = get_node("Camera2D/HealthBar")
export var PlayerBullet = preload("res://PlayerBullet.tscn")
export var PlayerAttack = preload("res://PlayerPolygonAttack.tscn")
export var Ray = preload("res://Ray.tscn")
var targetFPS : float = 60.0;
var targetDelta : float = 1.0/targetFPS;
var reload = 0;
#var firing = .25; #how many seconds it takes you to shoot a bullet
var maxHealth = 4;
var health = maxHealth
var cameraFollowPause = false;
var dashCameraLength = 0.12*targetFPS;
var dashIFrameBegin = 0.5*targetFPS;
var dashIFrameEnd = 0.1*targetFPS;
var dashSpeed = 5600;
var dashSpeedCutoff = 2400;
var dashDecay = 0.9;
var dashDecayHold = 0.6;
var dashConsecutive = 0.7;
var dashMultiplier = 1.0;
var dashMultiMin = 0.25;
var dashRecharge = 0.75;
var dashDistance = 0;
var dashMouseDistance;
var dashBulletMax = 1;
var dashBulletCount = 0;
var dashFrames = 0;
var dashVector : Vector2;
var dashing = false
var dashReleased = false;
var lastHitEnemy = null
var lazerTime = 0
var timeSinceAttack = 0;
var attacksInRow = 0;
var velocity
var lastDelta

func _ready():
	screen_size = get_viewport_rect().size
	#$RayCast2D.add_exception(self)

func _process(delta):
	lastDelta = delta
	timeSinceAttack += delta
	if(timeSinceAttack>1.5):
		#Reset our pitch run
		attacksInRow = 0;
	healthBar.animation = str(health);
	z_index = int(99+position[1]*0.1)
	if(dashMultiplier<1.0/dashConsecutive):
		if(dashMultiplier<dashMultiMin): dashMultiplier = dashMultiMin;
		dashMultiplier /= pow(dashConsecutive,delta/dashRecharge)
		if(dashMultiplier>1.0/dashConsecutive): dashMultiplier = 1.0/dashConsecutive
	$"Camera2D/DashBar".frame = floor((1.0-((dashMultiplier-dashMultiMin)/(1.0/dashConsecutive-dashMultiMin)))*20.0)
	
	velocity = Vector2.ZERO
	var walkingPressed = false
	if(dashing):
		if(delta!=0):
			dashFrames += targetDelta/delta;
		var decay = dashDecay;
		#$"DashSound".pitch_scale = 1.3+0.15*randf()
		if(Input.is_action_pressed("dash") && !dashReleased):
			decay = dashDecayHold
		else:
			dashReleased = true
		velocity = delta * dashVector.normalized() * (dashSpeed*dashMultiplier) * pow(decay, dashFrames)
		if(dashFrames>dashCameraLength):
			cameraFollowPause = false;
		if(dashDistance+velocity.length()>dashMouseDistance):
			velocity = velocity.normalized()*(dashMouseDistance-dashDistance)
			stop_dash()
		else:
			dashDistance += velocity.length()
		if(velocity.length() < dashSpeedCutoff*delta):
			dashReleased = true
		if(velocity.length() <= speed*delta):
			stop_dash()
	else:
		cameraFollowPause = false
		#if(reload < firing):
		#	reload += delta;
		if Input.is_action_pressed("right"):
			velocity += Vector2.RIGHT
			walkingPressed = true
		if Input.is_action_pressed("left"):
			velocity += Vector2.LEFT
			walkingPressed = true
		if Input.is_action_pressed("down"):
			velocity += Vector2.DOWN
			walkingPressed = true
		if Input.is_action_pressed("up"):
			velocity += Vector2.UP
			walkingPressed = true
		if Input.is_action_just_pressed('dash'):
			dash()
			walkingPressed = true
		velocity = velocity.normalized() * speed * delta
	if (velocity.length() > 0 && (walkingPressed or sprite.animation!="attack")):
		direction = fposmod(round(rad2deg(-velocity.angle())/45),8);
		sprite.animation = "walk"+str(direction)
	elif(sprite.animation!="attack"):
		sprite.animation = "idle"+str(direction)
	#if(!test_move(transform,velocity)):
	var oldPos = position
	var collision = move_and_collide(velocity)
	if collision:
		if(collision.collider.is_in_group("hittable") && collision.collider!=lastHitEnemy):
			#PERFORM AN EPIC GUN-FU ATTACK
			lastHitEnemy = collision.collider
			var hitVector = (collision.collider.get_node("CollisionShape2D").get_global_position()-$"CollisionShape2D".get_global_position())
			hitVector.y *= -1
			var paf = $"PlayerAttackFreeze"
			paf.angleVector = hitVector
			lazerTime = 60/$"MusicTimer".bpm
			paf.time = $"MusicTimer".get_time_to_next_beat_delay(lazerTime)
			paf.enemy = collision.collider
			timeSinceAttack = 0;
			attacksInRow += 1;
		else:
			velocity = velocity.slide(collision.normal)
			#warning-ignore:RETURN_VALUE_DISCARDED
			move_and_collide(velocity)
	else:
		lastHitEnemy = null
	
	
		#position += velocity
	$"Camera2D".deltaPos += position-oldPos
	$"CollisionShape2D".adjust_collider(position-oldPos);

func is_valid_hit(_damage, dirIn):
	#return false
	
	var invDirIn = fposmod(dirIn+4,8)
	if(invDirIn==direction):
		return true
	if(dashBulletCount>dashBulletMax):
		return true
	if(dashFrames>=dashIFrameBegin && dashFrames<dashIFrameEnd):
		return false
	return false

func dash():
	dashMultiplier *= dashConsecutive
	$"DashSound".pitch_scale = dashMultiplier*1.5
	$"DashSound".volume_db = -18+6*dashMultiplier
	$"DashSound".play()
	$"DashParticles".emitting = true
	dashing = true;
	dashReleased = false;
	dashBulletCount = 0;
	dashFrames = 0;
	dashDistance = 0;
	cameraFollowPause = true
	dashVector = get_global_mouse_position()-get_global_position()
	dashMouseDistance = dashVector.length()
	
func stop_dash():
	#place_polygon()
	dashFrames = 0;
	dashing = false;

func _on_Bullet_hit(damage, _dirIn):
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
		$"Camera2D".set_shake(64,0.65)
		$"PlayerHitFreeze".time = 0.1;
	
#func _input(event):
#	if event is InputEventMouseButton && reload > firing:
#		var angle = get_global_position().angle_to_point(get_global_mouse_position())
		#shoot_angle(1000, angle, 500,1)
		#shoot_raycast(angle)
#		reload = 0
#		var ray = Ray.instance()
#		ray.rotation = angle+PI
#		add_child(ray)

		
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
