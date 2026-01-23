extends Node2D

signal level_completed
signal player_died

@export var spawn_controller_path: NodePath
@export var player_path: NodePath

var _spawn_controller: Node
var _player: Node
var _remaining_enemies := 0
var _waves_finished := false

func _ready() -> void:
	_spawn_controller = get_node_or_null(spawn_controller_path)
	if _spawn_controller:
		_spawn_controller.connect("enemy_spawned", _on_enemy_spawned)
		_spawn_controller.connect("enemy_killed", _on_enemy_killed)
		_spawn_controller.connect("all_waves_finished", _on_all_waves_finished)
	else:
		push_warning("LevelController: SpawnController not found.")

	_player = get_node_or_null(player_path)
	if _player and _player.has_signal("died"):
		_player.connect("died", _on_player_died)
	elif _player and _player.has_method("get_health"):
		var health := _player.get_health()
		if health and health.has_signal("died"):
			health.connect("died", _on_player_died)

func _on_enemy_spawned() -> void:
	_remaining_enemies += 1

func _on_enemy_killed() -> void:
	_remaining_enemies = max(_remaining_enemies - 1, 0)
	_check_level_complete()

func _on_all_waves_finished() -> void:
	_waves_finished = true
	_check_level_complete()

func _check_level_complete() -> void:
	if _waves_finished and _remaining_enemies == 0:
		emit_signal("level_completed")

func _on_player_died() -> void:
	emit_signal("player_died")
