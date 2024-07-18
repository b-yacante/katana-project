extends CharacterBody3D

var _speed: float = 0

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
	# Ground Velocity
	velocity.x = direction.x * _speed
	velocity.z = direction.z * _speed
	# Moving the Character
	move_and_slide()



func _on_velocity_modifier(speed: float) -> void:
	_speed = speed
	pass # Replace with function body.
