extends ProgressBar

func set_hp(current: int, max_hp: int) -> void:
	max_value = max_hp
	value = current
