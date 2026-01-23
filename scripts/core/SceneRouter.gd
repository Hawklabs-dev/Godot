extends Node

@export var ui_root_path: NodePath
@export var level_root_path: NodePath
@export var title_scene: PackedScene
@export var menu_scene: PackedScene
@export var level_scenes: Array[PackedScene] = []
@export var gameover_scene: PackedScene
@export var levelcomplete_scene: PackedScene
@export var victory_scene: PackedScene

var _active_ui: Node
var _active_level: Node

func _ready() -> void:
	if ui_root_path.is_empty():
		ui_root_path = "../UIRoot"
	if level_root_path.is_empty():
		level_root_path = ".."

func goto_title() -> void:
	_swap_ui(title_scene)

func goto_menu() -> void:
	_swap_ui(menu_scene)

func start_level(level_id: int) -> void:
	var level_scene := _get_level_scene(level_id)
	if level_scene == null:
		push_warning("SceneRouter: Missing level scene for index %s" % level_id)
		return
	_swap_level(level_scene)
	_clear_ui()

func goto_gameover() -> void:
	_swap_ui(gameover_scene)

func goto_levelcomplete() -> void:
	_swap_ui(levelcomplete_scene)

func goto_victory() -> void:
	_swap_ui(victory_scene)

func _get_level_scene(level_id: int) -> PackedScene:
	if level_id >= 0 and level_id < level_scenes.size():
		return level_scenes[level_id]
	return null

func _swap_ui(scene: PackedScene) -> void:
	_clear_ui()
	if scene == null:
		return
	var ui_root := get_node_or_null(ui_root_path)
	if ui_root == null:
		push_warning("SceneRouter: UIRoot missing at %s" % ui_root_path)
		return
	_active_ui = scene.instantiate()
	ui_root.add_child(_active_ui)

func _clear_ui() -> void:
	if _active_ui and is_instance_valid(_active_ui):
		_active_ui.queue_free()
	_active_ui = null

func _swap_level(scene: PackedScene) -> void:
	if _active_level and is_instance_valid(_active_level):
		_active_level.queue_free()
	_active_level = null
	var level_root := get_node_or_null(level_root_path)
	if level_root == null:
		push_warning("SceneRouter: Level root missing at %s" % level_root_path)
		return
	_active_level = scene.instantiate()
	level_root.add_child(_active_level)
