extends "res://EnemyGeneric.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	if velocity.length() > 0:
		sprite.animation = "walk"+str(direction)
	else:
		if(shooting):
			sprite.animation = "shoot"+str(direction)
			if(sprite.frame==1):
				shooting = false
		else:
			#warning-ignore:warning_id 
			sprite.animation = "idle"+str(direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
