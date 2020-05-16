extends "res://EnemyGeneric.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	if(shooting):
		sprite.speed_scale = 1
		sprite.animation = "shoot"+str(direction)
		if(sprite.frame==1):
			shooting = false
	else:
		if velocity.length() > 0.1:
			sprite.animation = "walk"+str(direction)
			sprite.speed_scale = moveSpeed/500.0
		else:
			sprite.speed_scale = 1
			#warning-ignore:warning_id 
			sprite.animation = "idle"+str(direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
