class_name Spawner
extends Node

@export var data : SpawnData:
	set(value):
		data = value
		current_amount = 0
		max_amount = data.max_amount
@export var enemy_container : Node2D
@export var timer : Timer

var current_amount : int
var max_amount : int

func _ready() -> void:
	timer.timeout.connect(_on_timeout_spawner)
	if not data or not data.enemy_scene: return
	timer.wait_time = data.spawn_interval

func _on_timeout_spawner() -> void:
	if current_amount < max_amount:
		spawn()
		
func spawn() -> void:
	var enemy : Enemy = data.enemy_scene.instantiate()
	var size : Vector2 = get_viewport().get_visible_rect().size
	var x : float = randf_range(16, size.x - 16)
	var y : float = randf_range(16, size.y - 16)
	enemy.died.connect(_on_enemy_died)
	enemy.global_position = Vector2(x, y)
	enemy_container.add_child(enemy)
	current_amount += 1

func set_new_spawn(new_data : SpawnData) -> void:
	data = new_data
	timer.wait_time = data.spawn_interval

func set_enemy_container(node : Node2D) -> void:
	enemy_container = node

func new_wave_started(wave : WaveData) -> void:
	if wave.wave_number == data.required_wave:
		timer.start()
	elif data.required_wave < wave.wave_number:
		max_amount += data.increase_per_wave

func _on_enemy_died(enemy : Enemy) -> void:
	current_amount = maxi(0, current_amount - 1)
	Event.enemy_killed.emit(enemy)
	
