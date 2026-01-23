extends Node

enum Pattern {
	SINGLE,
	DOUBLE,
	TRIPLE_FAN,
}

@export var bullet_scene: PackedScene
@export var fire_cooldown := 1.2
@export var bullet_speed := 260.0
@export var spawn_offset := Vector2(0, 16)
@export var pattern := Pattern.SINGLE

var _cooldown := 0.0

func _process(delta: float) -> void:
	_cooldown = max(_cooldown - delta, 0.0)
	if _cooldown <= 0.0:
		_fire_pattern()

func set_pattern(new_pattern: int) -> void:
	pattern = new_pattern

func _fire_pattern() -> void:
	if bullet_scene == null:
		return
	match pattern:
		Pattern.SINGLE:
			_spawn_bullet(Vector2.DOWN)
			_cooldown = 1.2
		Pattern.DOUBLE:
			_spawn_bullet(Vector2(0.2, 1.0))
			_spawn_bullet(Vector2(-0.2, 1.0))
			_cooldown = 1.6
		Pattern.TRIPLE_FAN:
			_spawn_bullet(Vector2.DOWN)
			_spawn_bullet(Vector2(0.3, 1.0))
			_spawn_bullet(Vector2(-0.3, 1.0))
			_cooldown = 2.2

func _spawn_bullet(direction: Vector2) -> void:
	var bullet := bullet_scene.instantiate()
	if bullet is Node2D:
		bullet.position = global_position + spawn_offset
	if bullet.has_method("set_direction"):
		bullet.set_direction(direction)
	if bullet.has_variable("speed"):
		bullet.speed = bullet_speed
	get_tree().current_scene.add_child(bullet)
