class_name Clickable
extends Area2D

signal clicked(damage : float)

func hit(damage : float) -> void:
	clicked.emit(damage)
