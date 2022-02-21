extends Node


func _ready():
	GameManager.get_node("PlayerData").connect("update_points", self, "debug_print")

#func _unhandled_input(event):
#	if event.is_action_pressed("quit_game"):
#		get_tree().quit()
	
#	if event.is_action_pressed("debug_reset"):
#		get_tree().reload_current_scene()

func debug_print():
	print("Points: " + str(GameManager.get_node("PlayerData").points_counter) + "\nEnemies: " + str(GameManager.get_node("PlayerData").enemies_counter) + "\nFurniture: " + str(GameManager.get_node("PlayerData").furniture_counter))
