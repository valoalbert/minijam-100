extends Node2D

func _ready():
	GameManager.volume = $volume.value
	GameManager.play_main_menu()

func _on_volume_value_changed(value):
	GameManager.volume = value
	pass # Replace with function body.


func _on_Button_pressed():
	GameManager.emit_signal("on_game_started")
	GameManager.game_start = true
	get_tree().change_scene("res://scenes/levels/FirtsFloor.tscn")
	GameManager.play_gameplay()
	pass # Replace with function body.
