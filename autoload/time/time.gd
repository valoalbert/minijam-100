extends Node

var time = 0
var minutes = 0
var seconds = 0
var finalTime = "0:00"

func _ready():
	set_process(false)

func _process(delta):
	time += delta
	
	if time > 60:
		minutes += 1
		time = 0

	finalTime = str(minutes)+":"+str(stepify(time,0.01))
	print("this is time: "+finalTime)
