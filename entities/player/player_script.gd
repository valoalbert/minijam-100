extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2.ZERO
var health : int = 1

enum {
	IDLE,
	WALK,
	HIT,
	DEAD
}

var state = IDLE

func _ready():
	GameManager.connect("player_dead", self, "_on_player_dead")
	self.scale = Vector2(1.3,1.3)

func _physics_process(_delta):
	if state != DEAD:
		look_at(get_global_mouse_position())
		get_input()
		match state:
			IDLE:
				$AnimationPlayer.play("idle")
			WALK:
				$AttackHitbox/CollisionShape2D.disabled = true
				$AnimationPlayer.play("walk")
			HIT:
				$AnimationPlayer.play("hit")
				
		velocity = move_and_slide(velocity)

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

func die():
	state = DEAD
	GameManager.emit_signal("player_dead")
	GameManager.get_node("PlayerData").player_ko = true
	print("dead")

func _on_AttackTimer_timeout():
	if state != DEAD:
		state = IDLE
	pass # Replace with function body.

func _on_AttackHitbox_body_entered(body):
	if body.is_in_group("Furniture") or body.is_in_group("Enemy"):
		body.on_get_hit(1)
	pass # Replace with function body.

func _on_player_dead():
	$AnimationPlayer.play("down")
	$CollisionShape2D.queue_free()
	
