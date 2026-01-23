extends Area2D

@export var damage := 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("apply_damage"):
		area.apply_damage(damage)
		if owner and owner.has_method("despawn"):
			owner.despawn()

