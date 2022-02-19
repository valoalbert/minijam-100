extends KinematicBody2D

class_name Enemy

export (int) var health = 1
export (int) var speed = 100
enum {
	PATROL,
	ENGAGE,
	IDLE,
	WALK,
	DISENGAGE,
	SHOOT
}

var path: Array = [] # Contains destination positions
var level_navigation: Navigation2D = null
var player = null
var player_spotted: bool = false
var flipped : float = false
var state = WALK
var velocity : Vector2

var _original_position
var _original_transform

func _ready() -> void:
	velocity = Vector2.ZERO
	_original_position = self.global_position
	_original_transform = self.global_transform
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
	pass

func _physics_process(_delta :  float) -> void:
	if state == WALK:
		_move()
	if state == ENGAGE:
		$WallDetection.enabled = false
		self.look_at(player.global_position)
		generate_path(player.global_position)
		navigate()
		_move()
	if state == IDLE:
		_stop()
	if state == SHOOT:
		
		pass
		
	pass
	
func _process(_delta : float) -> void:
	
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

func _on_PatrolTimer_timeout():
	_flip()
	pass # Replace with function body.

func _on_Vision_body_entered(body : PhysicsBody2D):
	# detectar el player y perseguir
	if body.is_in_group("Player"):
		state = ENGAGE

		pass
	pass # Replace with function body.

func _reset_enemy():
	self.global_transform = _original_transform
	state = WALK


func _on_Vision_body_exited(body):
	if body.is_in_group("Player"):
		$WallDetection.enabled = true
		state = IDLE
	pass # Replace with function body.


func _on_ShootDistance_body_entered(body):
	if body.is_in_group("Player"):
		state = SHOOT
	pass # Replace with function body.
