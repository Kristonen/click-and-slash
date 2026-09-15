@abstract class_name Enemy
extends CharacterBody2D

@export_group("Enemy")
@export var clicks_to_kill : int = 1
@export var speed : float
@export var clickable : Clickable

@export_group("DEBUG")
@export var msg : String

var click_count : int = 0
var wander_pos : Vector2
var spawner : SpawnData

func _ready() -> void:
	assert(clickable != null, "Clickable not set!")
	clickable.clicked.connect(_on_clicked)
	
func _on_clicked() -> void:
	click_count += 1
	if click_count >= clicks_to_kill:
		spawner.current_amount -= 1
		queue_free()
