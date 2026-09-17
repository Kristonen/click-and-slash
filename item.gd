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

func _ready() -> void:
	assert(collectable != null, "Collectable not set")
	assert(sprite != null, "Sprite not set")
	collectable.detected_by_collector.connect(_on_detector)
	collectable.collected.connect(_on_collected)
	launch_finished.connect(Game.get_player().check_item_launch_finishded)
	speed = start_speed
	launch()
	
func _physics_process(delta: float) -> void:
	if is_following:
		var dir : Vector2 = (Game.get_player().global_position - global_position).normalized()
		global_position += dir * speed * delta
		speed = lerp(speed, max_speed, friction)

func launch() -> void:
	var target_pos : Vector2 = Vector2(-500, -500)#global_position + Vector2(x, y)
	while !Utils.check_if_in_viewport(target_pos):	
		var x : float = randf_range(-100, 100)
		var y : float = randf_range(-100, 100)
		target_pos = global_position + Vector2(x, y)
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
	if is_collectable: 
		is_following = true

func _on_collected() -> void:
	if is_collectable:
		Game.item_collected.emit(self)
		queue_free()
