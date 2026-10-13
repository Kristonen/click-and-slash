class_name WanderComponent
extends Node

@export var speed : float
@export var wander_radius : float
@export var margin : float = 32.0
@export var body : CharacterBody2D

var wander_pos : Vector2

func _ready() -> void:
	if not body and get_parent() is CharacterBody2D:
		body = get_parent()
	get_random_wander_pos()

func _physics_process(_delta: float) -> void:
	if body.global_position.distance_to(wander_pos) < 5:
		body.velocity = Vector2.ZERO
		get_random_wander_pos()
		return
	var dir : Vector2 = (wander_pos - body.global_position).normalized()
	body.velocity = dir * speed
	body.move_and_slide()

func get_random_wander_pos() -> void:
	if not body: return
	var random_offset : Vector2 = Vector2(
		randf_range(-wander_radius, wander_radius),
		randf_range(-wander_radius, wander_radius)
	)
	var size : Vector2 = get_viewport().get_visible_rect().size
	var target : Vector2 = body.global_position + random_offset
	target.x = clampf(target.x, margin, size.x - margin)
	target.y = clampf(target.y, margin, size.y - margin)
	wander_pos = target
