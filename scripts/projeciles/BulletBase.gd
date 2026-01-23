extends Area2D

@export var speed := 300.0
@export var direction := Vector2.UP
@export var lifetime := 4.0

var _alive_time := 0.0

func _process(delta: float) -> void:
	position += direction.normalized() * speed * delta
	_alive_time += delta
	if _alive_time >= lifetime:
		queue_free()

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction

func despawn() -> void:
	queue_free()

