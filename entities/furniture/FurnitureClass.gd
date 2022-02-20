extends Node2D

class_name Furniture

export (int) var health

func on_get_hit(damage):
	health -= damage
	
	match health:
		3:
			$AnimationPlayer.play("break")
		0:
			$Collider.queue_free()
			$AnimationPlayer.play("break")
			
