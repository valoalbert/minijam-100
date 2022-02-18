extends Sprite

# shoot() must enable raycast, detect colision
# if it's an enemy, kill it. if it's a wall, place particle in that position

func _shoot():
	if $RayCast2D.is_colliding():
		var object = $RayCast2D.get_collider()
		
		if object.is_in_group("enemy"):
			print(object.name)
			object.queue_free()
		else:
			print("hit a wall")
		

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		_shoot()

