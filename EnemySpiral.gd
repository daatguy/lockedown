extends "res://EnemyGeneric.gd"

export var bullet_velocity = Vector2(300, 0)

func shoot_pattern():
	shoot(bullet_velocity, 1200, 37)
	bullet_velocity = bullet_velocity.rotated(-PI-4)
