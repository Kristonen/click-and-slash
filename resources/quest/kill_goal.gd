class_name KillGoal
extends QuestGoal

@export var specific_enemy_type : PackedScene

func setup_listeners() -> void:
	Game.enemy_killed.connect(on_enemy_killed)
	
func cleanup_listeners() -> void:
	Game.enemy_killed.disconnect(on_enemy_killed)

func on_enemy_killed(enemy : Node) -> void:
	if is_completed: return
	
	if specific_enemy_type == null or enemy.is_class(specific_enemy_type.resource_path):
		add_progress()
