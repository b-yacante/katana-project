extends Node
## Health points, assign as Integer
@export var max_health: int
## Shield points, assign as Integer
@export var max_shield: int
## Must be assigned as decimal, this represent seconds of the modifier
## @tutorial: 0.1 | 1 | 0.025
@export var parry_time: float

var is_parring: bool

var current_health: int
var current_shield: int

var implements = Interface.IHealth

func _ready() -> void:
	is_parring = false
	current_health = max_health
	current_shield = max_shield

func parry():
	is_parring = true
	await get_tree().create_timer(parry_time).timeout
	is_parring = false

func healing(points: int):
	if(current_health < max_health):
		current_health += points

func shield_addition(points: int):
	if(current_shield < max_shield):
		current_shield += points

func take_damage(damage: int):
	if is_parring:
		#TODO: tirarle la espada al enemigo
		pass
	else:
		if(current_shield > 0):
			current_shield -= damage
		else:
			current_health -= damage
			if(current_health <= 0):
				#TODO: execute die
				queue_free()
