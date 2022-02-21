extends Node

var time = 0
var minutes = 0
var seconds = 0

func _process(delta):
	if GameManager.game_start:
		time += delta
		
		if time > 60:
			minutes += 1
			time = 0

		GameManager.final_time = str(minutes)+"m"+str(stepify(time,0.01))+"s"
	else:
		GameManager.remove_child(self)
