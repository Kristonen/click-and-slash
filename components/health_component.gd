class_name HealthComponent
extends Node

signal damaged(data : Data)
signal died()

@export var clickable : Clickable
@export var current_health : int:
	set(value):
		current_health = value
		if current_health <= min_health:
			died.emit()
@export var max_health : int
@export var min_health : int

func _ready() -> void:
	if clickable:
		clickable.clicked.connect(take_damage)
	else:
		push_error("No clickable set in %s", name)

func take_damage(data : Data) -> void:
	if data is ClickData:
		current_health -= data.damage
		damaged.emit(data)
