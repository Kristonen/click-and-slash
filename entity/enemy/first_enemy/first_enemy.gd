class_name FirstEnemy
extends Enemy

func _on_died() -> void:
	died.emit(self)
	queue_free()
