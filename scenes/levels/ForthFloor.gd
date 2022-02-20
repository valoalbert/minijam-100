extends load_player

var server_counter = 0

func _ready():
	GameManager.connect("server_destroyed", self, "on_server_destroyed")

func on_server_destroyed():
	if server_counter < 3:
		server_counter += 1
	else:
		$Furniture/WoodenDoor.queue_free()
	pass
