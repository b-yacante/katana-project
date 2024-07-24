extends CharacterBody3D

var _speed: float = 0
@export var player := 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		%"Player Input".set_multiplayer_authority(id)

@onready var input = %"Player Input"

func _ready():
	# Set the camera as current if we are this player.
	#if player == multiplayer.get_unique_id():
		#$Camera3D.current = true
	# Only process on server.
	# EDIT: Let the client simulate player movement too to compesate network input latency.
	# set_physics_process(multiplayer.is_server())
	pass

func _physics_process(delta: float) -> void:
	var direction = (transform.basis * Vector3(input.direction.x, 0, input.direction.y)).normalized()

	if direction:
		velocity.x = direction.x * _speed
		velocity.z = direction.z * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
		velocity.z = move_toward(velocity.z, 0, _speed)
	# Moving the Character
	move_and_slide()


func _on_velocity_modifier(speed: float) -> void:
	_speed = speed
	pass # Replace with function body.
