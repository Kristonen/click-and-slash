@abstract class_name Enemy
extends CharacterBody2D

signal died(enemy : Enemy)

@export var health_component : HealthComponent
@export var clickable : Clickable
@export var health_bar : HealthBar

func _ready() -> void:
	if health_component:
		health_component.died.connect(_on_died)
		if health_bar:
			health_component.health_changed.connect(health_bar.update_bar)
			health_bar.update_bar(health_component.current_health, health_component.max_health)
	if clickable:
		clickable.clicked.connect(_on_clicked)
	add_to_group("enemy")

func _on_clicked(damage : float) -> void:
	health_component.take_damage(damage)

func _on_died() -> void:
	died.emit(self)
	queue_free()
