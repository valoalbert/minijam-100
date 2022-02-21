extends Node

signal update_points

var points_counter : int = 0
var furniture_counter : int = 0
var enemies_counter : int = 0
var cards_counter : int = 0
var deads_counter : int = 0
var secrets : int = 0
var player_ko : bool = false

func _ready():
	get_parent().connect("player_dead", self, "_on_reset_values")
	pass
	
func on_furniture_destroyed():
	furniture_counter += 1

func on_reset_furniture():
	furniture_counter = 0

func on_get_points(points):
	points_counter += points
	emit_signal("update_points")
	print(points_counter)

func on_reset_points():
	points_counter = 0

func on_enemy_killed():
	enemies_counter += 1

func on_reset_enemies():
	enemies_counter = 0

func on_get_cards():
	
	cards_counter += 1
	print(cards_counter)

func on_reset_cards():
	cards_counter = 0

func on_player_dead():
	deads_counter += 1

func on_secret_revealed():
	secrets += 1

func on_reset_deads():
	deads_counter = 0

func _on_reset_values(points, enemies, cards):
	points_counter = points
	enemies_counter = enemies
	cards_counter = cards
