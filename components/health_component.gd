class_name HealthComponent
extends Node

signal damaged(dmg : int)
signal died()

@export var current_health : float:
	set(value):
		current_health = value
		if current_health <= min_health:
			died.emit()
@export var max_health : float
@export var min_health : float

func take_damage(damage : float) -> void:
	current_health -= damage
	damaged.emit(damage)
