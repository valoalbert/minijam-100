extends CanvasLayer

func _ready():
	GameManager.connect("player_dead", self, "_hide")
	
func _hide():
	$Control.visible = false
