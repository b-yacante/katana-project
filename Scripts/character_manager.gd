extends CharacterBody3D

@onready var input_player = $InputPlayer
var _speed: float = 0

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	
func _ready():
	var pos := Vector2.from_angle(randf() * 2 * PI)
	position = Vector3(pos.x * 1 * randf(), 0, pos.y * 1 * randf())
	#set_multiplayer_authority(name.to_int())
	##input_player.set_multiplayer_authority(name.to_int())
	## Set the camera as current if we are this player.
	if name.to_int() == multiplayer.get_unique_id():
		$PlayerCamera.current = true
		

func _input(event):
	if !is_multiplayer_authority(): return
	if Input.is_action_pressed("ui_attack"):
		for child in $Body.get_children():
			if "implements" in child:
				if child.implements == Interface.IAttack:
					child.attack()

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	var direction = (transform.basis * Vector3(input_player.direction.x, 0, input_player.direction.y)).normalized()
	if direction:
		$Body.basis = Basis.looking_at(direction)
		velocity.x = direction.x * _speed
		velocity.z = direction.z * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
		velocity.z = move_toward(velocity.z, 0, _speed)
	# Moving the Character
	move_and_slide()


func _on_velocity_modifier(speed: float) -> void:
	_speed = speed
