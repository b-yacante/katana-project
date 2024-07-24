extends MultiplayerSynchronizer

@export var direction := Vector2()
#TODO crear la funcion attack y parry con RPC
#@rpc("call_local")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#TODO: Agregar parry y ataque
