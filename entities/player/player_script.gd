extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2.ZERO
var health : int = 1

var particles_scene : PackedScene
var particles_node

enum {
	IDLE,
	WALK,
	HIT,
	DEAD
}

var state = IDLE

func _ready():
	particles_scene = preload("res://entities/player/HitParticles.tscn")
	GameManager.connect("enemy_die", self, "_camera_shake")
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
	$Hitsound.playing = true
	_camera_shake()
	print("dead")

func _on_AttackTimer_timeout():
	if state != DEAD:
		state = IDLE
	pass # Replace with function body.

func _on_AttackHitbox_body_entered(body):
	if body.is_in_group("Furniture") or body.is_in_group("Enemy"):
		particles_node = particles_scene.instance()
		particles_node.emitting = true
		particles_node.global_position = body.global_position
		get_parent().add_child(particles_node)
		body.on_get_hit(1)
	pass # Replace with function body.

func _camera_shake():
	$CameraShake.play("shake")

func _on_player_dead():
	GameManager.get_node("PlayerData").on_player_dead()
	$AnimationPlayer.play("down")
	$CollisionShape2D.queue_free()
	
