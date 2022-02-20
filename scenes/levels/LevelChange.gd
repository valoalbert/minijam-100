extends Area2D

export(String, FILE, "*.tscn") var next_scene_path


func _on_LevelChange_body_entered(body):
	if body.is_in_group("Player"):
		if get_parent().level_complete:
			get_tree().change_scene(next_scene_path)
	pass # Replace with function body.
