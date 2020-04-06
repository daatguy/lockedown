extends KinematicBody2D

export var speed = 800;
var direction = 0;
var screen_size #this feels like it belongs somewhere else
onready var fog = get_node("Camera2D/Fog")
onready var sprite = get_node("AnimatedSprite")
onready var healthBar = get_node("HealthBar")
export var PlayerBullet = preload("res://PlayerBullet.tscn")
var reload = 0;
var firing = .25; #how many seconds it takes you to shoot a bullet
var maxHealth = 4;
var health = maxHealth

func _ready():
	screen_size = get_viewport_rect().size
	$RayCast2D.add_exception(self)

func _process(delta):
	
	healthBar.animation = str(health);
	
	if(reload < firing):
		reload += delta;
	z_index = 99+position[1]*0.1
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("left"):
		velocity += Vector2.LEFT
	if Input.is_action_pressed("down"):
		velocity += Vector2.DOWN
	if Input.is_action_pressed("up"):
		velocity += Vector2.UP
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		direction = fposmod(floor(rad2deg(-velocity.angle())/45),8);
		if(0 < velocity.angle() && velocity.angle() <= PI): # ||velocity.y>0 || (velocity.y==0 && velocity.x<0)):
			direction += 1
		#print(direction);
		sprite.animation = "walk"+str(direction)
	else:
		sprite.animation = "idle"+str(direction)
	if(!test_move(transform,velocity * delta)):
		position += velocity * delta

func _on_Bullet_hit(damage):
	$"Camera2D".shakeAmount = 16;
	$"PlayerHitFreeze".time = 0.1;
	health -= 1;
	
func _input(event):
	if event is InputEventMouseButton && reload > firing:
		var angle = position.angle_to_point(get_global_mouse_position())
		#shoot_angle(1000, angle, 500,1)
		shoot_raycast(angle)
		reload = 0
		
func shoot_raycast(angle):
	var to = Vector2(500, 0)
	to = to.rotated(angle)
	$RayCast2D.cast_to = to
	$RayCast2D.force_raycast_update()
	if ($RayCast2D.is_colliding()):
		print("hitted")
	else:
		print("miss")
		
func shoot(v, reach, damage):
	var bullet = PlayerBullet.instance()
	$"..".add_child(bullet)
	bullet.position = position + v.normalized()*128;
	bullet.velocity = v
	bullet.reach = reach
	bullet.damage = damage
	return bullet

func shoot_angle(speed, angle, reach, damage):
	var v = Vector2(-speed, 0)
	v = v.rotated(angle)
	return shoot(v, reach, damage)
