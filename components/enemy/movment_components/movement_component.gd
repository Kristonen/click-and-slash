@abstract class_name MovementComponent
extends Node2D

@export var body : CharacterBody2D

func setup() -> void:
	pass
	
@abstract func move(delta : float) -> void
