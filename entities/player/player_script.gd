extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2.ZERO

enum {
	IDLE,
	WALK,
	HIT
}

var state = IDLE

func get_input():
	velocity = Vector2.ZERO
	if state != HIT:
		state = IDLE
		
	if Input.is_action_pressed('right'):
		velocity.x += 1
		state = WALK
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		state = WALK
	if Input.is_action_pressed('down'):
		velocity.y += 1
		state = WALK
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		state = WALK
	if Input.is_action_just_pressed("attack"):
		state = HIT
		$AttackTimer.start()
	
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	
			
	look_at(get_global_mouse_position())
	get_input()
	match state:
		IDLE:
			$AnimationPlayer.play("idle")
		WALK:
			$AnimationPlayer.play("walk")
		HIT:
			$AnimationPlayer.play("hit")
			
	velocity = move_and_slide(velocity)


func _on_AttackTimer_timeout():
	state = IDLE
	pass # Replace with function body.
