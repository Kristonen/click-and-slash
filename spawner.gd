class_name Spawner
extends Node2D

@export var spawn_data : Array[SpawnData]
@export var enemy_node : Node2D

func _process(_delta: float) -> void:
	for data : SpawnData in spawn_data:
		if data.current_amount < data.max_amount:
			data.spawn(enemy_node, get_viewport())
