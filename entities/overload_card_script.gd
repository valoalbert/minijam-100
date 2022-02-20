extends Node2D

export (int) var  id

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		get_parent().level_complete = true
		GameManager.get_node("PlayerData").on_get_cards()
		self.queue_free()
	pass # Replace with function body.
