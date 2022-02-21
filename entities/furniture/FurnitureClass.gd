extends Node2D

class_name Furniture

export (int) var health
export (int) var points

func _ready():
	$Hitsound.volume_db = GameManager.volume + 5.0
	pass
func on_get_hit(damage):
	health -= damage
	$Hitsound.playing = true
	
	match health:
		3:
			$AnimationPlayer.play("break")
		0:
			$Collider.queue_free()
			$AnimationPlayer.play("break")
			GameManager.get_node("PlayerData").on_furniture_destroyed()
			GameManager.get_node("PlayerData").on_get_points(points)
