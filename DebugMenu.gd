extends Control

export(String, FILE, "*.tscn") var level_1
export(String, FILE, "*.tscn") var level_2
export(String, FILE, "*.tscn") var level_3
export(String, FILE, "*.tscn") var level_4
export(String, FILE, "*.tscn") var level_5

func _on_Level_1_pressed():
	get_tree().change_scene(level_1)
	GameManager.game_start = true
	GameManager.emit_signal("on_game_started")
	pass # Replace with function body.


func _on_Level_2_pressed():
	get_tree().change_scene(level_2)
	GameManager.game_start = true
	GameManager.emit_signal("on_game_started")
	pass # Replace with function body.


func _on_Level_3_pressed():
	get_tree().change_scene(level_3)
	GameManager.game_start = true
	GameManager.emit_signal("on_game_started")
	pass # Replace with function body.


func _on_Level_4_pressed():
	get_tree().change_scene(level_4)
	GameManager.game_start = true
	GameManager.emit_signal("on_game_started")
	pass # Replace with function body.


func _on_Level_5_pressed():
	get_tree().change_scene(level_5)
	GameManager.game_start = true
	GameManager.emit_signal("on_game_started")
	pass # Replace with function body.
