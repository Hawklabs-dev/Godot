extends Node
class_name GameState

signal level_changed(level_index: int)

var current_level_index := 0
var player_stats := {
	"max_hp": 25,
	"hp": 25,
}
var settings := {
	"music_volume": 1.0,
	"sfx_volume": 1.0,
}
var transitions := {
	"last_screen": "",
	"next_screen": "",
}

func reset_run() -> void:
	current_level_index = 0
	player_stats["hp"] = player_stats["max_hp"]
	transitions["last_screen"] = ""
	transitions["next_screen"] = ""

func set_level(level_index: int) -> void:
	current_level_index = level_index
	emit_signal("level_changed", level_index)
