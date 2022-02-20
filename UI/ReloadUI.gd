extends CanvasLayer



func _ready():
	$Control.visible = false
	GameManager.connect("player_dead", self, "_show")
	
func _unhandled_input(event):
	if event.is_action_pressed("reset") and GameManager.get_node("PlayerData").player_ko == true:
		GameManager.get_node("PlayerData").points_counter = get_parent().points
		GameManager.get_node("PlayerData").enemies_counter = get_parent().enemies
		GameManager.get_node("PlayerData").cards_counter = get_parent().cards
		GameManager.get_node("PlayerData").furniture_counter = get_parent().furniture
		get_tree().reload_current_scene()

func _show():
	$Control.visible = true
