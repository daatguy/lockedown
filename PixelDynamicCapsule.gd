extends CollisionShape2D

var defaultPos : Vector2;

func _ready():
	defaultPos = position;

func adjust_collider(velocity):
	shape.height = velocity.length()
	position = defaultPos+(-velocity)*0.5
	rotation = velocity.angle()+PI/2
