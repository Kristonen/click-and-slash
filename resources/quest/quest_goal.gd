@abstract class_name QuestGoal
extends Resource

signal progress_updated(current : int, goal : int)
signal completed

@export var target_amount : int

var current_amount : int = 0
var is_completed : bool = false

func setup_listeners() -> void:
	pass
	
func cleanup_listeners() -> void:
	pass

func initialize() -> void:
	current_amount = 0
	is_completed = false
	
func add_progress(value : int = 1) -> void:
	if is_completed: return
	
	current_amount = min(current_amount + value, target_amount)
	progress_updated.emit(current_amount, target_amount)
	
	if current_amount >= target_amount:
		is_completed = true
		completed.emit()
