class_name SpawnData
extends Resource

@export var enemy_scene : PackedScene
@export var max_amount : int

var current_amount : int = 0

func spawn(enemy_node : Node2D, view : Viewport) -> bool:
	if !enemy_scene or !enemy_node: return false
	var x : float = randf_range(0, view.size.x)
	var y : float = randf_range(0, view.size.y)
	
	var enemy : Enemy = enemy_scene.instantiate()
	enemy.global_position = Vector2(x, y)
	enemy.spawner = self
	enemy_node.add_child(enemy)
	current_amount += 1
	return true
