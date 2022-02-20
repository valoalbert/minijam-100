extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2.ZERO
var health : int = 1

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
			
	if Input.is_action_just_pressed("attack") and state == IDLE:
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

func die():
	print("dead")

func _on_AttackTimer_timeout():
	state = IDLE
	pass # Replace with function body.

func _on_AttackHitbox_body_entered(body):
	if body.is_in_group("Furniture") or body.is_in_group("Enemy"):
		body.on_get_hit(1)
	pass # Replace with function body.
