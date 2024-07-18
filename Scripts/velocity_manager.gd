extends Node
@export var speed: float = 2
@export var speedup_modifier: float = 20
@export var slowdown_modifier: float = 0.8
@export var dash_speed: float = 2

signal velocity_modifier(speed: float)

func _ready() -> void:
	emit_signal("velocity_modifier", speed)

func convert_percentage(value: float) -> float:
	var decimal_percent = value * 0.01
	return decimal_percent * 100

func activate_speedup():
	var speed_modified: float = speed + convert_percentage(speedup_modifier)
	emit_signal("velocity_modifier", speed_modified)
	await get_tree().create_timer(1).timeout
	emit_signal("velocity_modifier", speed)

func activate_slowdown():
	var speed_modified: float = speed - convert_percentage(speedup_modifier)
	emit_signal("velocity_modifier", speed_modified)
	await get_tree().create_timer(1).timeout
	emit_signal("velocity_modifier", speed)
