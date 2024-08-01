extends TextureButton
enum button_type {
	ATTACK,
	PARRY,
} 

@export var ui_button := button_type.ATTACK

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if ui_button == button_type.ATTACK:
		Input.action_release('ui_attack')
		Input.action_press("ui_attack", 1)
	#if pressed and ui_button == button_type.PARRY:
		#Input.action_press("ui_parry")
