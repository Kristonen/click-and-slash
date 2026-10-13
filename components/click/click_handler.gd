class_name ClickHandler
extends Node2D

signal clicked(pos : Vector2)

var player : Player

func _ready() -> void:
	if get_parent() is Player:
		player = get_parent()

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("MOUSE_LEFT"): return
	clicked.emit(get_global_mouse_position())
