class_name Projectile
extends Node2D

var stats_manager : StatsManager
var base_damage : float
var dir : Vector2
	
func _physics_process(delta: float) -> void:
	if dir != Vector2.ZERO:
		position += dir * 500 * delta
