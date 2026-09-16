class_name Item
extends Node2D
@export_group("Dependencies")
@export var collectable : Collectable
@export var sprite : Sprite2D

var is_collectable : bool
var is_following : bool = false

func _ready() -> void:
	assert(collectable != null, "Collectable not set")
	assert(sprite != null, "Sprite not set")
	collectable.detected_by_collector.connect(_on_detector)
	collectable.collected.connect(_on_collected)
	launch()

func launch() -> void:
	var x : float = randf_range(-100, 100)
	var y : float = randf_range(-100, 100)
	var target_pos : Vector2 = global_position + Vector2(x, y)
	var tween : Tween = create_tween().set_parallel(true)
	tween.tween_property(self, "global_position", target_pos, 0.5)\
		.set_trans(Tween.TRANS_LINEAR)
		
	tween.tween_property(sprite, "position:y", -40.0, 0.5 * 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		
	tween.chain().tween_property(sprite, "position:y", 0.0, 0.5 * 0.5)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	tween.finished.connect(_on_launch_finished)
	
func _on_launch_finished() -> void:
	is_collectable = true

func _on_detector() -> void:
	if is_collectable: 
		is_following = true

func _on_collected() -> void:
	if is_collectable:
		queue_free()
