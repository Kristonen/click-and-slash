class_name WaveManager
extends Node

signal wave_prepared(wave : WaveData)
signal wave_started

@export var waves : Array[WaveData]
@export var spawn_container : Node
@export var enemy_container : Node
@export var spawner_scene : PackedScene
@export var spawn_data : Array[SpawnData]
@export var upgrade_ui_scene : PackedScene

var current_wave_index : int = 0
var kill_count : int = 0

func _ready() -> void:
	for i : int in range(waves.size()):
		waves[i].wave_number = i + 1
		
	for spawns : SpawnData in spawn_data:
		if not spawns: return
		var new_spawner : Spawner = spawner_scene.instantiate()
		spawn_container.add_child(new_spawner)
		new_spawner.set_new_spawn(spawns)
		new_spawner.set_enemy_container(enemy_container)
		wave_prepared.connect(new_spawner.new_wave_started)

func start_wave(index : int) -> void:
	if index >= waves.size():
		get_tree().quit()
		return
	
	var current_wave : WaveData = waves[index]
	current_wave.goal.setup_listeners()
	current_wave.goal.completed.connect(finish_wave)
	current_wave.goal.initialize()
	wave_prepared.emit(current_wave)
	
	current_wave.goal.add_progress(0)
	wave_started.emit(current_wave.wave_time)
		
func finish_wave() -> void:
	var current_wave : WaveData = waves[current_wave_index]
	current_wave_index += 1
	current_wave.goal.cleanup_listeners()
	if current_wave.wave_number % 1 == 0 && get_parent() is Level:
		get_tree().paused = true
		var upgrade_ui : UpgradeUI = upgrade_ui_scene.instantiate()
		var size : Vector2 = get_viewport().get_visible_rect().size
		upgrade_ui.global_position = Vector2(size.x / 2, size.y / 2)
		get_parent().add_child(upgrade_ui)
	start_wave(current_wave_index)
