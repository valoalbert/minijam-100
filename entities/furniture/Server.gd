extends Furniture

var destroyed = false

func _ready():
	$AnimationPlayer.play("server")

func _process(delta):
	if self.health == 0 and !destroyed:
		GameManager.emit_signal("server_destroyed")
		destroyed = true
