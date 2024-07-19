extends Node
## Health points, assign as Integer
@export var max_health: int
## Shield points, assign as Integer
@export var max_shield: int

var current_health: int 
var current_shield: int 

var implements = Interface.IHealth

func _ready() -> void:
	current_health = max_health
	current_shield = max_shield

func healing(points: int):
	current_health += points

func shield_addition(points: int):
	current_shield += points

func take_damage(damage: int):
	if(current_health <= 0):
		#TODO: execute die
		queue_free()

	if(current_shield > 0):
		current_shield -= damage
	else: 
		current_health -= damage
