extends "res://EnemyGeneric.gd"

func shoot_pattern():
	shoot(Vector2(300,0), 1200, 37)
	shoot(Vector2(300,300), 1200, 37)
	shoot(Vector2(0,300), 1200, 37)
	shoot(Vector2(-300,300), 1200, 37)
	shoot(Vector2(-300,0), 1200, 37)
	shoot(Vector2(-300,-300), 1200, 37)
	shoot(Vector2(0,-300), 1200, 37)
	shoot(Vector2(300,-300), 1200, 37)
