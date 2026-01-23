extends CanvasLayer

@export var hp_label_path: NodePath
@export var hp_bar_path: NodePath

var _health: Node

func bind_health(health: Node) -> void:
	if _health and _health.has_signal("hp_changed"):
		_health.disconnect("hp_changed", _on_hp_changed)
	_health = health
	if _health and _health.has_signal("hp_changed"):
		_health.connect("hp_changed", _on_hp_changed)
		_on_hp_changed(_health.hp, _health.max_hp)

func _on_hp_changed(current: int, max_hp: int) -> void:
	var label := get_node_or_null(hp_label_path)
	if label:
		label.text = "HP %d / %d" % [current, max_hp]
	var bar := get_node_or_null(hp_bar_path)
	if bar:
		bar.max_value = max_hp
		bar.value = current
