extends Node
## Movement speed
@export var speed: float
## Must be assigned as percent, but just the number without the sign %
## @tutorial: 20 | 40 | 100
@export var speedup_modifier: float
## Must be assigned as decimal, this represent seconds of the modifier
## @tutorial: 0.1 | 1 | 0.025
@export var speedup_time_modifier: float
## Must be assigned as percent, but just the number without the sign %
## @tutorial: 20 | 40 | 100
@export var slowdown_modifier: float 
## Must be assigned as decimal, this represent seconds of the modifier
## @tutorial: 0.1 | 1 | 0.025
@export var slowdown_time_modifier: float
## Must be assigned as decimal, this will multiply the speed
## @tutorial: 1.5 | 2 | 5
@export var dash_speed: float
## Must be assigned as decimal, this represent seconds of the modifier
## @tutorial: 0.1 | 1 | 0.025
@export var dash_time_modifier: float

signal velocity_modifier(speed: float)

var implements = Interface.IVelocity

func _ready() -> void:
	emit_signal("velocity_modifier", speed)

func convert_percentage(value: float) -> float:
	var decimal_percent = value * 0.01
	return decimal_percent

func activate_speedup():
	var speed_modified: float = speed + convert_percentage(speedup_modifier)
	emit_signal("velocity_modifier", speed_modified)
	await get_tree().create_timer(speedup_time_modifier).timeout
	emit_signal("velocity_modifier", speed)

func activate_slowdown():
	var speed_modified: float = speed - convert_percentage(speedup_modifier)
	emit_signal("velocity_modifier", speed_modified)
	await get_tree().create_timer(slowdown_time_modifier).timeout
	emit_signal("velocity_modifier", speed)

func activate_dash():
	var speed_modified: float = speed * dash_speed
	emit_signal("velocity_modifier", speed_modified)
	await get_tree().create_timer(dash_time_modifier).timeout
	emit_signal("velocity_modifier", speed)
