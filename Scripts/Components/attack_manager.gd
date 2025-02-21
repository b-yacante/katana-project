extends Area3D
@export var damage: int
## Must be assigned as decimal, this represent seconds between attack action
@export var attack_speed: float
## Must be assigned as percent, but just the number without the sign %
## @tutorial: 20 | 40 | 100
@export var damage_modifier: int
## Must be assigned as decimal, this represent seconds of the modifier
## @tutorial: 0.1 | 1 | 0.025
@export var damage_time_modifier: float
## Must be assigned as percent, but just the number without the sign %
## @tutorial: 20 | 40 | 100
@export var attack_speed_modifier: float
## Must be assigned as decimal, this represent seconds of the modifier
## @tutorial: 0.1 | 1 | 0.025
@export var attack_speed_time_modifier:float
## Must be assigned as decimal, this represent seconds of the modifier
## @tutorial: 0.1 | 1 | 0.025
@export var pre_casting_attack: float

var is_attacking: bool
var attacking_time: float
var current_damage: int
var current_attack_speed: float
var can_attack := true

var implements = Interface.IAttack

func _ready():
	is_attacking = false
	current_damage = damage
	current_attack_speed = attack_speed
	
func attack():
	if can_attack and not is_attacking:
		can_attack = false
		await get_tree().create_timer(pre_casting_attack).timeout
		print('attack')
		is_attacking = true
		await get_tree().create_timer(attacking_time).timeout
		is_attacking = false
		await get_tree().create_timer(current_attack_speed).timeout
		can_attack = true
		print('can attack again')

func convert_percentage(value: float) -> float:
	var decimal_percent = value * 0.01
	return decimal_percent

func activate_damage_modifier():
	current_damage = roundi(damage + convert_percentage(damage_modifier))
	await get_tree().create_timer(damage_time_modifier).timeout
	current_damage = damage
	
func activate_attack_speed_modifier():
	current_attack_speed = attack_speed + convert_percentage(attack_speed_modifier)
	await get_tree().create_timer(attack_speed_time_modifier).timeout
	current_attack_speed = attack_speed

func _on_body_entered(body):
	if "implements" in body:
		if body.implements == Interface.IHealth:
			body.take_damage(current_damage)
	for child in body.get_children():
		if "implements" in child:
			if child.implements == Interface.IHealth:
				child.take_damage(current_damage)
