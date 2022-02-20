extends load_player

export(String, FILE, "*.tscn") var next_scene_path

func _on_control_panel_body_entered(body):
	if body.is_in_group("Player"):
		if GameManager.get_node("PlayerData").cards_counter == 2:
			get_tree().change_scene(next_scene_path)
	pass # Replace with function body.
