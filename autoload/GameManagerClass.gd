extends Node

signal player_dead
signal server_destroyed
signal enemy_die
signal on_game_started

var volume = 0

var game_start = false

var stop_watch_scene : PackedScene
var stop_watch
var final_time : String

func _ready():
	stop_watch_scene = preload("res://autoload/time/StopWatch.tscn")
	stop_watch = stop_watch_scene.instance()
	connect("on_game_started",self, "add_stop_watch")
	pass
	
func _process(delta):
	$mainmenu.volume_db = volume
	$Gameplay.volume_db = volume
	pass

func add_stop_watch():
	add_child(stop_watch)
	
func play_main_menu():
	$mainmenu.playing = true
	pass
	
func play_gameplay():
	$mainmenu.playing = false
	$Gameplay.playing = true
	pass
	
func stop_music():
	$mainmenu.stop()
	$Gameplay.stop()
