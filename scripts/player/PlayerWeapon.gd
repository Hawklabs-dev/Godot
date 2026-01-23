extends Node

@export var bullet_scene: PackedScene
@export var fire_rate := 2.0
@export var spawn_offset := Vector2(0, -32)
@export var shoot_action := "shoot"

var _cooldown := 0.0

func _process(delta: float) -> void:
	_cooldown = max(_cooldown - delta, 0.0)
	if Input.is_action_pressed(shoot_action) and _cooldown <= 0.0:
		_fire()

func _fire() -> void:
	if bullet_scene == null:
		return
	var bullet := bullet_scene.instantiate()
	if bullet is Node2D:
		bullet.position = global_position + spawn_offset
	if bullet.has_method("set_direction"):
		bullet.set_direction(Vector2.UP)
	get_tree().current_scene.add_child(bullet)
	_cooldown = 1.0 / max(fire_rate, 0.01)

