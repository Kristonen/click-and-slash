class_name FirstEnemy
extends Enemy

func _on_health_component_died() -> void:
	died.emit(self)
	queue_free()
