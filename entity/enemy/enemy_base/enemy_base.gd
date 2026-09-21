class_name EnemyBase
extends CharacterBody2D

@export var enemy_data : EnemyData
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent

var spawner : SpawnData
var move_component : MovementComponent

func _ready() -> void:
	if enemy_data:
		sprite_2d.texture = enemy_data.sprite
		health_component.max_health = enemy_data.max_health
		health_component.current_health = enemy_data.max_health
		_setup_extra_components()
	else:
		push_error("No enemy data exist")

func _physics_process(delta: float) -> void:
	if move_component:
		move_component.move(delta)

func _setup_extra_components() -> void:
	for component_scene : PackedScene in enemy_data.components:
		var component : Node = component_scene.instantiate()
		add_child(component)
		if component is MovementComponent:
			component.body = self
			if component is WanderComponent: 
				component.speed = enemy_data.speed
			move_component = component
			move_component.setup()

func _on_health_component_died() -> void:
	spawner.current_amount -= 1
	queue_free()
