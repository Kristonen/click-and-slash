class_name Spawner
extends Node

signal enemy_killed

@export var data : SpawnData
@export var enemy_container : Node2D

@onready var timer: Timer = $Timer

var current_amount : int

func _ready() -> void:
	timer.timeout.connect(_on_timout_spawner)
	if not data or not data.enemy_scene:
		return
	timer.wait_time = data.spawn_interval

func _on_timout_spawner() -> void:
	if current_amount < data.max_amount:
		
		spawn()
		
func spawn() -> void:
	var enemy : Enemy = data.enemy_scene.instantiate()
	var size : Vector2 = get_viewport().get_visible_rect().size
	var x : float = randf_range(16, size.x - 16)
	var y : float = randf_range(16, size.y - 16)
	enemy.global_position = Vector2(x, y)
	enemy.spawner = self
	enemy.died.connect(_on_enemy_died)
	enemy_container.add_child(enemy)
	current_amount += 1

func set_new_spawn(new_data : SpawnData) -> void:
	data = new_data
	current_amount = 0
	if data and data.enemy_scene:
		timer.wait_time = data.spawn_interval
	else:
		timer.stop()

func set_enemy_container(node : Node2D) -> void:
	enemy_container = node

func start_spawning() -> void:
	timer.start()

func stop_spawning() -> void:
	timer.stop()
	
func _on_enemy_died(enemy : Enemy) -> void:
	current_amount = max(0, current_amount - 1)
	Game.enemy_killed.emit(enemy)
	enemy_killed.emit()
	
