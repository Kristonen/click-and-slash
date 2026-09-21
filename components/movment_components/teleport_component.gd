class_name TeleportComponent
extends Node

@export var teleport_time : float = 2.0
@export var margin : float = 32.0
@export var body : CharacterBody2D

@onready var teleport_timer: Timer = $Timer

func _ready() -> void:
	teleport_timer.timeout.connect(_on_teleport_cd)
	teleport_timer.one_shot = true
	teleport_timer.wait_time = teleport_time
	teleport_timer.start()
	
	if not body and get_parent() is CharacterBody2D:
		body = get_parent()

func _on_teleport_cd() -> void:
	if not body: return
	var size : Vector2 = get_viewport().get_visible_rect().size
	var x : float = randf_range(margin, size.x - margin)
	var y : float = randf_range(margin, size.y - margin)
	body.global_position = Vector2(x, y)
	teleport_timer.start()
