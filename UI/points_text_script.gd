extends RichTextLabel

var points

func _ready():
	GameManager.get_node("PlayerData").connect("update_points", self, "_update_bbcode")
	points = GameManager.get_node("PlayerData").points_counter
	bbcode_text = "[right][tornado]" + str(points) +"[/tornado][/right]"
	pass

func _process(delta):
	bbcode_text = "[right][tornado]" + str(points) +"[/tornado][/right]"
	pass
	
func _update_bbcode():
	points = GameManager.get_node("PlayerData").points_counter
	get_parent().get_node("AnimationPlayer").play("shake")
	pass
