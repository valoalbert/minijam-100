extends Node

signal player_dead
signal server_destroyed
signal enemy_die

var volume
var time = 0
var minutes = 0
var seconds = 0
var finalTime = "0m00s"
var game_start = false

func _ready():
	
	pass
	
func _process(delta):
	$mainmenu.volume_db = volume
	$Gameplay.volume_db = volume
	
	if game_start:
		time += delta
		
		if time > 60:
			minutes += 1
			time = 0

		finalTime = str(minutes)+"m"+str(stepify(time,0.01))+"s"
	pass
	
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
