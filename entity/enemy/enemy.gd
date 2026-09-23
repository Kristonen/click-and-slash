@abstract class_name Enemy
extends CharacterBody2D

signal died(enemy : Enemy)

@export var health_component : HealthComponent

func _ready() -> void:
	if health_component:
		health_component.died.connect(_on_died)

func _on_died() -> void:
	pass
