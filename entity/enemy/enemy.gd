@abstract class_name Enemy
extends CharacterBody2D

signal died(enemy : Enemy)

@export var health_component : HealthComponent
@export var clickable : Clickable

func _ready() -> void:
	if health_component:
		health_component.died.connect(_on_died)
		
	if clickable:
		clickable.clicked.connect(_on_clicked)

func _on_clicked() -> void:
	var stats : StatsManager = Game.level.player.stats_manager
	print_debug(stats.get_damage())
	health_component.take_damage(stats.get_damage())

func _on_died() -> void:
	died.emit(self)
	queue_free()
