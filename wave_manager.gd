class_name WaveManager
extends Node

signal wave_completed

@export var waves : Array[WaveData]
@export var spawn_container : Node
@export var enemy_container : Node
@export var spawner_scene : PackedScene

var current_wave_index : int = 0
var kill_count : int = 0

func _ready() -> void:
	start_wave(0)

func start_wave(index : int) -> void:
	if index >= waves.size():
		get_tree().quit()
		return
	
	var current_wave : WaveData = waves[index]
	
	for child : Node in spawn_container.get_children():
		child.queue_free()
	
	for enemy : Node in enemy_container.get_children():
		enemy.queue_free()
	
	for spawn_data : SpawnData in current_wave.wave_spawns:
		var new_spawner : Spawner = spawner_scene.instantiate()
		spawn_container.add_child(new_spawner)
		new_spawner.set_new_spawn(spawn_data)
		new_spawner.set_enemy_container(enemy_container)
		new_spawner.enemy_killed.connect(_on_enemy_killed)
		new_spawner.start_spawning()
			
func _on_enemy_killed() -> void:
	kill_count += 1
	var current_wave : WaveData = waves[current_wave_index]
	if current_wave.wave_goal <= kill_count:
		print_debug("NÄCHSTE WELLE")
		current_wave_index += 1
		wave_completed.emit()
		start_wave(current_wave_index)
		
