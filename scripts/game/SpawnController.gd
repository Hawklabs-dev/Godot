extends Node

signal enemy_spawned
signal enemy_killed
signal all_waves_finished

@export var spawn_points: Array[NodePath] = []
@export var spawn_timeline: Array[Dictionary] = []

var _elapsed := 0.0
var _spawn_index := 0
var _spawned_total := 0
var _killed_total := 0
var _waves_finished := false

func _process(delta: float) -> void:
	if _waves_finished:
		return
	_elapsed += delta
	while _spawn_index < spawn_timeline.size() and _elapsed >= spawn_timeline[_spawn_index].get("time", 0.0):
		_spawn_enemy(spawn_timeline[_spawn_index])
		_spawn_index += 1
	if _spawn_index >= spawn_timeline.size() and not _waves_finished:
		_waves_finished = true
		emit_signal("all_waves_finished")

func register_enemy_killed() -> void:
	_killed_total += 1
	emit_signal("enemy_killed")

func _spawn_enemy(entry: Dictionary) -> void:
	var scene: PackedScene = entry.get("scene")
	if scene == null:
		push_warning("SpawnController: Missing scene on spawn entry.")
		return
	var enemy := scene.instantiate()
	var spawn_position := _pick_spawn_position(entry)
	if enemy is Node2D:
		enemy.position = spawn_position
	if entry.has("hp") and enemy.has_method("set_max_hp"):
		enemy.set_max_hp(entry["hp"])
	if entry.has("pattern") and enemy.has_method("set_weapon_pattern"):
		enemy.set_weapon_pattern(entry["pattern"])
	if enemy.has_signal("killed"):
		enemy.connect("killed", register_enemy_killed)
	add_child(enemy)
	_spawned_total += 1
	emit_signal("enemy_spawned")

func _pick_spawn_position(entry: Dictionary) -> Vector2:
	if entry.has("spawn_x"):
		return Vector2(entry["spawn_x"], entry.get("spawn_y", 0.0))
	if spawn_points.is_empty():
		return Vector2.ZERO
	var index := entry.get("spawn_index", randi() % spawn_points.size())
	var path := spawn_points[index]
	var node := get_node_or_null(path)
	if node and node is Node2D:
		return node.position
	return Vector2.ZERO
