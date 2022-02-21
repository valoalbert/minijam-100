extends load_player

var room_revealed = false

func _on_SecretReveal_body_entered(body):
	if body.is_in_group("Player") and !room_revealed:
		var tween = $Secretroom/Tween
		tween.interpolate_property($Secretroom, "modulate",
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), 2.0, 
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		GameManager.get_node("PlayerData").on_secret_revealed()
		room_revealed =  true

	pass # Replace with function body.
