class_name Item
extends Node2D

@export var collectable : Collectable

var is_following : bool = false

func _ready() -> void:
	assert(collectable != null, "Collectable not set")
	collectable.detected_by_collector.connect(_on_detector)
	collectable.collected.connect(_on_collected)
	
func _physics_process(delta: float) -> void:
	if is_following:
		var dir : Vector2 = (Game.player.global_position - global_position).normalized()
		global_position += dir * 5 * delta

func _on_detector() -> void:
	is_following = true

func _on_collected() -> void:
	queue_free()
