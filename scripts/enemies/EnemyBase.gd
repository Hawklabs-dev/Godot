extends CharacterBody2D

signal killed

@export var speed := 90.0
@export var health_path: NodePath
@export var weapon_path: NodePath
@export var death_fx_scene: PackedScene

var _health: Node
var _weapon: Node

func _ready() -> void:
	_health = get_node_or_null(health_path)
	if _health:
		_health.connect("died", _on_died)
	_weapon = get_node_or_null(weapon_path)

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, speed)
	move_and_slide()

func set_max_hp(value: int) -> void:
	if _health and _health.has_method("reset"):
		_health.reset(value)

func set_weapon_pattern(pattern: int) -> void:
	if _weapon and _weapon.has_method("set_pattern"):
		_weapon.set_pattern(pattern)

func _on_died() -> void:
	if death_fx_scene:
		var fx := death_fx_scene.instantiate()
		if fx is Node2D:
			fx.position = global_position
			get_tree().current_scene.add_child(fx)
	emit_signal("killed")
	queue_free()
