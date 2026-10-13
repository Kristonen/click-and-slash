class_name HealthBar
extends ProgressBar

func update_bar(current_health : float, max_health : float) -> void:
	value = current_health
	max_value = max_health
