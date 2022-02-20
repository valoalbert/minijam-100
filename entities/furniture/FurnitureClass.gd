extends Node2D

class_name Furniture

export (int) var health
export (int) var points

func on_get_hit(damage):
	health -= damage
	
	match health:
		3:
			$AnimationPlayer.play("break")
		0:
			$Collider.queue_free()
			$AnimationPlayer.play("break")
			GameManager.get_node("PlayerData").on_furniture_destroyed()
			GameManager.get_node("PlayerData").on_get_points(points)
