extends KinematicBody2D

var _speed = 200
var velocity : Vector2

func _ready() -> void:
	velocity = Vector2.ZERO
	pass
	
func _process(_delta : float):
	var _param = move_and_slide(velocity)

func _flush():
	self.queue_free()


func move_towards_player(current_position : Vector2 , player_position : Vector2) -> void:
	velocity = current_position.direction_to(player_position) * _speed

func _on_exit_screen_limits(body):
	if body.is_in_group("screen_limits"):
		_flush()
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.die()
		_flush()

