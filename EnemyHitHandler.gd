extends Node
signal relayed_hit(damage)

func _on_PlayerBullet_enemy_hit(damage):
	emit_signal("relayed_hit", damage)
