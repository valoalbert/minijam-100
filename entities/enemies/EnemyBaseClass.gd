extends KinematicBody2D

class_name Enemy

export (int) var health = 1
export (int) var speed = 100
export (int) var points = 100
enum {
	PATROL,
	ENGAGE,
	DISENGAGE,
	IDLE,
	WALK,
	SHOOT,
	DIE
}

var path: Array = [] # Contains destination positions
var level_navigation: Navigation2D = null
var player = null
var player_spotted: bool = false
var flipped : float = false
var state = IDLE
var velocity : Vector2

var _original_position
var _original_transform
var _projectile_scene : PackedScene 
var _able_to_shoot : bool = true

func _ready() -> void:
	GameManager.connect("player_dead", self, "_reset_enemy")
	_projectile_scene = preload("res://entities/enemies/Projectile.tscn")
	_original_position = self.global_position
	_original_transform = self.global_transform
	
	velocity = Vector2.ZERO
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
	pass

func _physics_process(_delta :  float) -> void:
	
	if state == DIE:
		return
	elif state == DISENGAGE:
		_stop()
	else:
		if state == WALK:
			speed = 100
			_move()
		if state == ENGAGE:
			speed = 200
			$WallDetection.enabled = false
			self.look_at(player.global_position)
			generate_path(player.global_position)
			navigate()
			_move()
		if state == IDLE:
			_stop()
		if state == SHOOT:
			start_combat()

func _process(_delta : float) -> void:
	$Label.text = str(state)
	pass
	
func _move() -> void:
	$AnimationPlayer.play("walk")
	
	if !flipped:
		velocity.x += 1
	else:
		velocity.x -= 1
		
	velocity = move_and_slide(velocity)
	
	if $WallDetection.is_colliding():
		state = IDLE
		$PatrolTimer.start()
	
	velocity = velocity.normalized() * speed
	pass

func _stop() -> void:
	velocity.y = 0
	$AnimationPlayer.play("idle")

func _flip() -> void:
	if !flipped:
		flipped = true
	else:
		flipped = false

	self.scale.x *= -1
	state = WALK

func navigate():	# Define the next position to go to
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		
		# If reached the destination, remove this point from path array
		if global_position == path[0]:
			path.pop_front()

func generate_path(goal_location):	# It's obvious
	if level_navigation != null and player != null:
		path = level_navigation.get_simple_path(global_position, goal_location, true)

func start_combat():
	$AnimationPlayer.play("shoot")
	if _able_to_shoot:
		_able_to_shoot = false
		var _projectile = _projectile_scene.instance()
		get_parent().add_child(_projectile)
		_projectile.global_transform = self.global_transform
		_projectile.move_towards_player(self.position, get_parent().get_node("Player").position)
		$ShootTimer.start()
	pass

func on_get_hit(damage):
	health -= damage
	
	if health < 1:
		die()

func die():
	GameManager.get_node("PlayerData").on_enemy_killed()
	GameManager.get_node("PlayerData").on_get_points(points)
	GameManager.emit_signal("enemy_die")
	state = DIE
	$AnimationPlayer.play("ko")
	$Collider.queue_free()
	$ShootDistance.queue_free()
	
func _on_PatrolTimer_timeout():
	_flip()
	pass # Replace with function body.

func _reset_enemy():
	#self.global_transform = _original_transform
	state = DISENGAGE

func _on_ShootDistance_body_entered(body):
	if body.is_in_group("Enemy") and state != DIE and state != DISENGAGE and state != IDLE or body.is_in_group("Player") and state != DIE and state != DISENGAGE:
		$ShootTimer.start()
		state = SHOOT
	pass # Replace with function body.

func _on_ShootDistance_body_exited(body):
	if body.is_in_group("Player") and state != DIE and state != DISENGAGE or body.is_in_group("Enemy") and state != DIE and state != DISENGAGE:
		$ShootTimer.stop()
		state = ENGAGE
	pass # Replace with function body.

func _on_ShootTimer_timeout():
	_able_to_shoot = true
	pass # Replace with function body.
