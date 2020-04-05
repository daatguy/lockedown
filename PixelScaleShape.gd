extends CollisionShape2D

func _ready():
	shape.radius *= scale.length()/1.4142135623730951 #sqrt(2)
