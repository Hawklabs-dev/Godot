extends Node

signal damaged(amount: int, remaining_hp: int)
signal died
signal hp_changed(current: int, max_hp: int)

@export var max_hp := 25
var hp := 25

func _ready() -> void:
	hp = clamp(hp, 0, max_hp)
	emit_signal("hp_changed", hp, max_hp)

func reset(new_max_hp: int = -1) -> void:
	if new_max_hp > 0:
		max_hp = new_max_hp
	hp = max_hp
	emit_signal("hp_changed", hp, max_hp)

func apply_damage(amount: int) -> void:
	if amount <= 0 or hp <= 0:
		return
	hp = max(hp - amount, 0)
	emit_signal("damaged", amount, hp)
	emit_signal("hp_changed", hp, max_hp)
	if hp <= 0:
		emit_signal("died")

func heal(amount: int) -> void:
	if amount <= 0 or hp <= 0:
		return
	hp = min(hp + amount, max_hp)
	emit_signal("hp_changed", hp, max_hp)
