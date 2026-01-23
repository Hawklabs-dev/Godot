extends "res://scripts/enemies/EnemyBase.gd"

@export var sway_amplitude := 40.0
@export var sway_speed := 2.0

var _time := 0.0

func _physics_process(delta: float) -> void:
	_time += delta
	velocity = Vector2(sin(_time * sway_speed) * sway_amplitude, speed)
	move_and_slide()
