extends Node2D

export(String, FILE, "*.tscn") var next_scene_path

var enemies = 0
var furniture = 0
var final_time = 0
var deads = 0

func _ready():
	enemies = GameManager.get_node("PlayerData").enemies_counter
	furniture = GameManager.get_node("PlayerData").furniture_counter
	deads = GameManager.get_node("PlayerData").deads_counter

	$Control/EnemiesKillText.text = "Enemies KO'd: " + str(enemies)
	$Control/FurnitureText.text = "Furniture Destroyed: " + str(furniture)
	$Control/KOtext.text = "Times KO'd: " + str(deads)
	$Control/FinalText.text = "Final Time: " + str(final_time)


func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		GameManager.get_node("PlayerData").points_counter = 0
		GameManager.get_node("PlayerData").enemies_counter = 0
		GameManager.get_node("PlayerData").cards_counter = 0
		GameManager.get_node("PlayerData").furniture_counter = 0
		get_tree().change_scene(next_scene_path)
