extends CharacterBody2D

signal died

@export var speed := 320.0
@export var smoothing := 8.0
@export var bounds := Rect2(Vector2(48, 48), Vector2(640, 960))
@export var weapon_path: NodePath
@export var health_path: NodePath

var _velocity := Vector2.ZERO

func _ready() -> void:
	var health := get_health()
	if health:
		health.connect("died", _on_died)

func _physics_process(delta: float) -> void:
	var input_vector := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	if input_vector.length() > 1.0:
		input_vector = input_vector.normalized()
	var desired := input_vector * speed
	_velocity = _velocity.lerp(desired, smoothing * delta)
	velocity = _velocity
	move_and_slide()
	position.x = clamp(position.x, bounds.position.x, bounds.position.x + bounds.size.x)
	position.y = clamp(position.y, bounds.position.y, bounds.position.y + bounds.size.y)

func get_health() -> Node:
	if health_path.is_empty():
		return null
	return get_node_or_null(health_path)

func _on_died() -> void:
	emit_signal("died")
