extends CPUParticles2D

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	self.queue_free()
	pass # Replace with function body.
