extends Node2D

@export var scroll_speed := 120.0
@export var loop_distance := 1024.0
@export var scroll_nodes: Array[NodePath] = []

var _halted := false

func _process(delta: float) -> void:
	if _halted:
		return
	for path in scroll_nodes:
		var node := get_node_or_null(path)
		if node and node is Node2D:
			node.position.y += scroll_speed * delta
			if node.position.y >= loop_distance:
				node.position.y -= loop_distance * 2.0

func halt_scroll() -> void:
	_halted = true

func resume_scroll() -> void:
	_halted = false
