extends "res://scripts/enemies/EnemyBase.gd"

@export var dive_speed := 120.0
@export var curve_amplitude := 120.0
@export var curve_speed := 2.5

var _time := 0.0

func _physics_process(delta: float) -> void:
	_time += delta
	velocity = Vector2(sin(_time * curve_speed) * curve_amplitude, dive_speed)
	move_and_slide()
