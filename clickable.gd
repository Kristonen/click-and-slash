class_name Clickable
extends Area2D

signal clicked

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if event is InputEventMouse and event.is_action_pressed("MOUSE_LEFT"):
		clicked.emit()
