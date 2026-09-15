class_name Player extends Node2D

func _ready() -> void:
	Game.player = self

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
