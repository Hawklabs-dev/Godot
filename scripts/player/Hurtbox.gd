extends Area2D

@export var health_path: NodePath

func apply_damage(amount: int) -> void:
	var health := get_node_or_null(health_path)
	if health and health.has_method("apply_damage"):
		health.apply_damage(amount)

