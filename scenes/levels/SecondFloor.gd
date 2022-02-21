extends Node2D

class_name load_player

export (bool) var level_complete
var points
var enemies
var cards
var furniture
var secrets

func _ready():
	var player_scene = preload("res://entities/player/Player.tscn")
	var player = player_scene.instance()
	player.global_transform = $Position2D.global_transform
	add_child(player)
	points = GameManager.get_node("PlayerData").points_counter
	enemies = GameManager.get_node("PlayerData").enemies_counter
	cards = GameManager.get_node("PlayerData").cards_counter
	furniture = GameManager.get_node("PlayerData").furniture_counter
	secrets = GameManager.get_node("PlayerData").secrets
