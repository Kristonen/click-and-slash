class_name Item
extends Node2D

signal launch_finished(item : Item)

@export_group("Dependencies")
@export var collectable : Collectable
@export var sprite : Sprite2D

@export_group("Following")
@export var start_speed : float = 50.0
@export var max_speed : float = 150.0
@export var friction : float = 0.05
var speed : float

var is_collectable : bool
var is_following : bool = false
var following : Node2D

func _ready() -> void:
	assert(collectable != null, "Collectable not set")
	assert(sprite != null, "Sprite not set")
	collectable.detected_by_collector.connect(_on_detector)
	collectable.collected.connect(_on_collected)
	launch_finished.connect(Game.level.player.check_item_launch_finishded)
	speed = start_speed
	launch()
	
func _physics_process(delta: float) -> void:
	if following:
		var dir : Vector2 = (following.global_position - global_position).normalized()
		global_position += dir * speed * delta
		speed = lerp(speed, max_speed, friction)

func launch() -> void:
	var random_offset : Vector2 = Vector2(
		randf_range(-100, 100),
		randf_range(-100, 100),
	)
	var size : Vector2 = get_viewport().get_visible_rect().size;
	var target_pos : Vector2 = global_position + random_offset
	target_pos.x = clampf(target_pos.x, 32, size.x - 32)
	target_pos.y = clampf(target_pos.y, 32, size.y - 32)
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
	launch_finished.emit(self)

func _on_detector() -> void:
	if !is_collectable: return
	following = Game.level.player

func _on_collected(collector : Collector) -> void:
	if !is_collectable: return
	collector.collected.emit(self)
	queue_free()
