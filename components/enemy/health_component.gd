class_name HealthComponent
extends Node

signal damaged(dmg : int)
signal health_changed(current : float, max : float)
signal died()

@export var current_health : float:
	set(value):
		var was_alive : bool = current_health > min_health
		current_health = value
		health_changed.emit(current_health, max_health)
		if was_alive and current_health <= min_health:
			died.emit()
@export var max_health : float
@export var min_health : float

func is_dead() -> bool:
	return current_health <= min_health

func take_damage(damage : float) -> void:
	if is_dead(): return
	current_health -= damage
	damaged.emit(damage)
