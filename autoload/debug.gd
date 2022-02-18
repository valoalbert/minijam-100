extends Node


func _unhandled_input(event):
	if event.is_action_pressed("quit_game"):
		get_tree().quit()
	
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
